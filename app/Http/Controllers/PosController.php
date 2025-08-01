<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use App\Models\Account;
use App\Models\PaymentMethod;
use App\Mail\SaleMail;
use App\Models\Product;
use App\Models\Category;
use App\Models\Brand;
use App\Models\PaymentSale;
use App\Models\Sale;
use App\Models\SaleDetail;
use App\Models\Unit;
use App\Models\ProductVariant;
use App\Models\product_warehouse;
use App\Models\Warehouse;
use App\Models\User;
use App\Models\UserWarehouse;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use App\Models\Client;
use App\Models\Setting;
use App\Models\PosSetting;
use App\Models\Currency;
use Carbon\Carbon;
use DataTables;
use Stripe;
use Config;
use DB;
use PDF;
use App\utils\helpers;

class PosController extends Controller
{

    protected $currency;
    protected $symbol_placement;

    public function __construct()
    {
        $helpers = new helpers();
        $this->currency = $helpers->Get_Currency();
        $this->symbol_placement = $helpers->get_symbol_placement();

    }


     //--------------------- index  ------------------------\\

     public function index(Request $request)
     {

        $user_auth = auth()->user();

       if ($user_auth->can('pos')){

            $settings = Setting::where('deleted_at', '=', null)->first();

            if ($settings->warehouse_id) {
                if (Warehouse::where('id', $settings->warehouse_id)->where('deleted_at', '=', null)->first()) {
                    $default_warehouse = $settings->warehouse_id;
                } else {
                    $default_warehouse = '';
                }
            } else {
                $default_warehouse = '';
            }

            if ($settings->client_id) {
                if (Client::where('id', $settings->client_id)->where('deleted_at', '=', null)->first()) {
                    $default_Client = $settings->client_id;
                } else {
                    $default_Client = '';
                }
            } else {
                $default_Client = '';
            }
            
            $clients = Client::where('deleted_at', '=', null)->get(['id', 'username']);
            $payment_methods = PaymentMethod::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','title']);
            $accounts = Account::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','account_name']);

            //get warehouses assigned to user
            if($user_auth->is_all_warehouses){
                $warehouses = Warehouse::where('deleted_at', '=', null)->get(['id', 'name']);
            }else{
                $warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
                $warehouses = Warehouse::where('deleted_at', '=', null)->whereIn('id', $warehouses_id)->get(['id', 'name']);
            } 

            $totalRows = '';
            $data = [];
            $product_autocomplete = [];

            
           
            return view('sales.pos',[
                'clients'            => $clients,
                'payment_methods'    => $payment_methods,
                'accounts'           => $accounts,
                'warehouses'         => $warehouses,
                'settings'           => $settings,
                'default_warehouse'  => $default_warehouse,
                'default_Client'     => $default_Client,
                'totalRows'          => $totalRows,
            ]);
                 

        }else{
            return abort('403', __('You are not authorized'));
        }
     }

    //------------ Create New  POS --------------\\

    public function CreatePOS(Request $request)
    {
        request()->validate([
            'client_id' => 'required',
            'warehouse_id' => 'required',
        ]);

        $item = \DB::transaction(function () use ($request) {
            $helpers = new helpers();
            $order = new Sale;

            $order->is_pos = 1;
            $order->date = $request->date;
            // $order->Ref = 'SO-' . date("Ymd") . '-'. date("his");
            $order->client_id = $request->client_id;
            $order->warehouse_id = $request->warehouse_id;
            $order->tax_rate = $request->tax_rate;
            $order->TaxNet = $request->TaxNet;
            $order->discount = $request->discount;
            $order->discount_type = $request->discount_type;
            $order->discount_percent_total = $request->discount_percent_total;
            $order->shipping = $request->shipping;
            $order->GrandTotal = $request->GrandTotal;
            $order->notes = $request->notes;
            $order->statut = 'completed';
            $order->payment_statut = 'unpaid';
            $order->user_id = Auth::user()->id;
            //Shirt/suit measurements
            $order->shirt_length = $request->shirt_length;
            $order->shirt_shoulder = $request->shirt_shoulder;
            $order->shirt_sleeves = $request->shirt_sleeves;
            $order->shirt_chest = $request->shirt_chest;
            $order->shirt_upper_waist = $request->shirt_upper_waist;
            $order->shirt_lower_waist = $request->shirt_lower_waist;
            $order->shirt_hip = $request->shirt_hip;
            $order->shirt_neck = $request->shirt_neck;
            $order->shirt_arms = $request->shirt_arms;
            $order->shirt_cuff = $request->shirt_cuff;
            $order->shirt_biceps = $request->shirt_biceps;
            $order->shirt_collar_type = $request->shirt_collar_type;
            $order->shirt_daman_type = $request->shirt_daman_type;

            //Pant/shawar measurements
            $order->pant_length = $request->pant_length;
            $order->pant_waist = $request->pant_waist;
            $order->pant_hip = $request->pant_hip;
            $order->pant_thigh = $request->pant_thigh;
            $order->pant_knee = $request->pant_knee;
            $order->pant_bottom = $request->pant_bottom;
            $order->pant_fly = $request->pant_fly;

            $order->save();
            
            
              // Now generate the correct Ref using the ID
            $order->Ref = 'SO-' . date("Ymd") . '-' . $order->id;
            $order->save(); // Update only the Ref

$client = Client::find($request->client_id);
\App\Services\ClientLedgerService::log(
    $request->client_id,
    'pos_sale',               // or just 'sale' if you prefer
    $order->Ref,
    $order->GrandTotal,
    0
);

            $data = $request['details'];
            foreach ($data as $key => $value) {

                $unit = Unit::where('id', $value['sale_unit_id'])->first();
            
                // Quantity conversion
                $convertedQty = $value['quantity'];
                if ($unit) {
                    $convertedQty = $unit->operator == '/'
                        ? $value['quantity'] / $unit->operator_value
                        : $value['quantity'] * $unit->operator_value;
                }
            
                $orderDetails[] = [
                    'date'               => $order->date,
                    'sale_id'            => $order->id,
                    'sale_unit_id' => !empty($value['sale_unit_id']) && Unit::find($value['sale_unit_id']) ? $value['sale_unit_id'] : NULL,

                    'quantity'           => $value['quantity'],
                    'product_id'         => $value['product_id'],
                    'product_variant_id' => !empty($value['product_variant_id']) ? $value['product_variant_id'] : NULL,
                    'total'              => $value['subtotal'],
                    'price'              => $value['Unit_price'],
                    'TaxNet'             => $value['tax_percent'],
                    'tax_method'         => $value['tax_method'],
                    'discount'           => $value['discount'],
                    'discount_method'    => $value['discount_Method'],
                    'imei_number'        => $value['imei_number'],
                ];
            
                // Stock update
                if (!empty($value['product_variant_id'])) {
                    $product_warehouse = product_warehouse::where('warehouse_id', $order->warehouse_id)
                        ->where('product_id', $value['product_id'])
                        ->where('product_variant_id', $value['product_variant_id'])
                        ->first();
                } else {
                    $product_warehouse = product_warehouse::where('warehouse_id', $order->warehouse_id)
                        ->where('product_id', $value['product_id'])
                        ->first();
                }
            
                if ($unit && $product_warehouse) {
                    $product_warehouse->qte -= $convertedQty;
                    $product_warehouse->save();
                }
            
         \App\Services\LedgerService::log(
    $value['product_id'],
    'pos',
    $order->Ref,
    0,
    $convertedQty,
       $client->username ?? 'POS Customer',
    $value['code'] ?? null                             // product_code
);

            }
            

            SaleDetail::insert($orderDetails);

            // if($request['montant'] > 0){

            //     $sale = Sale::findOrFail($order->id);

            //     $total_paid = $sale->paid_amount + $request['montant'];
            //     $due = $sale->GrandTotal - $total_paid;

            //     if ($due === 0.0 || $due < 0.0) {
            //         $payment_statut = 'paid';
            //     } else if ($due != $sale->GrandTotal) {
            //         $payment_statut = 'partial';
            //     } else if ($due == $sale->GrandTotal) {
            //         $payment_statut = 'unpaid';
            //     }

            //     PaymentSale::create([
            //         'sale_id'    => $order->id,
            //         'account_id' => $request['account_id']?$request['account_id']:NULL,
            //         'Ref'        => $this->generate_random_code_payment(),
            //         'date'       => $request['date'],
            //         'payment_method_id'  => $request['payment_method_id'],
            //         'montant'    => $request['montant'],
            //         'change'     => 0,
            //         'notes'      => $request['payment_notes'],
            //         'user_id'    => Auth::user()->id,
            //     ]);

            //     $account = Account::where('id', $request['account_id'])->exists();

            //     if ($account) {
            //         // Account exists, perform the update
            //         $account = Account::find($request['account_id']);
            //         $account->update([
            //             'initial_balance' => $account->initial_balance + $request['montant'],
            //         ]);
            //     }

            //     $sale->update([
            //         'paid_amount' => $total_paid,
            //         'payment_statut' => $payment_statut,
            //     ]);

            // } 
              if ($request['montant'] > 0) {

    $sale = Sale::findOrFail($order->id);

    $total_paid = $sale->paid_amount + $request['montant'];
    $due = $sale->GrandTotal - $total_paid;

    $payment_statut = match (true) {
        $due <= 0     => 'paid',
        $due < $sale->GrandTotal => 'partial',
        default       => 'unpaid',
    };

    $payment = PaymentSale::create([
        'sale_id'           => $order->id,
        'account_id'        => $request['account_id'] ?? NULL,
        'Ref'               => $this->generate_random_code_payment(),
        'date'              => $request['date'],
        'payment_method_id' => $request['payment_method_id'],
        'montant'           => $request['montant'],
        'change'            => 0,
        'notes'             => $request['payment_notes'],
        'user_id'           => Auth::user()->id,
    ]);

    if ($request['account_id']) {
        $account = Account::find($request['account_id']);
        if ($account) {
            $account->update([
                'initial_balance' => $account->initial_balance + $request['montant'],
            ]);

            // ✅ Account Ledger Log
            \App\Services\AccountLedgerService::log(
                $account->id,
                'pos_payment',
                $order->Ref,
                0,
                $request['montant']
            );
        }
    }

    $sale->update([
        'paid_amount'    => $total_paid,
        'payment_statut' => $payment_statut,
    ]);
}

           
            return $order->id;

        }, 10);

        return response()->json(['success' => true, 'id' => $item]);

    }

      // generate_random_code_payment
    public function generate_random_code_payment()
    {
        $gen_code = 'INV/SL-' . date("Ymd") . '-'. substr(number_format(time() * mt_rand(), 0, '', ''), 0, 6);

        if (PaymentSale::where('Ref', $gen_code)->exists()) {
            $this->generate_random_code_payment();
        } else {
            return $gen_code;
        }
        
    }

    //------------ Get Products--------------\\

    public function GetProductsByParametre(request $request)
    {
         // How many items do you want to display.
         $perPage = 8;
         $pageStart = \Request::get('page', 1);
         // Start displaying items from this number;
         $offSet = ($pageStart * $perPage) - $perPage;
         $data = array();

        $product_warehouse_data = product_warehouse::where('warehouse_id', $request->warehouse_id)
            ->with('product', 'product.unitSale')
            ->where('deleted_at', '=', null)
            ->where(function ($query) use ($request) {
                if ($request->stock == '1' && $request->product_service == '1') {
                    return $query->where('qte', '>', 0)->orWhere('manage_stock', false);

                }elseif($request->stock == '1' && $request->product_service == '0') {
                    return $query->where('qte', '>', 0)->orWhere('manage_stock', true);

                }else{
                    return $query->where('manage_stock', true);
                }
            })

        // Filter
        ->where(function ($query) use ($request) {
            return $query->when($request->filled('category_id'), function ($query) use ($request) {
                return $query->whereHas('product', function ($q) use ($request) {
                    $q->where('category_id', '=', $request->category_id);
                });
            });
        })
        ->where(function ($query) use ($request) {
            return $query->when($request->filled('brand_id'), function ($query) use ($request) {
                return $query->whereHas('product', function ($q) use ($request) {
                    $q->where('brand_id', '=', $request->brand_id);
                });
            });
        });

        $totalRows = $product_warehouse_data->count();

        $product_warehouse_data = $product_warehouse_data
            ->offset($offSet)
            ->limit(8)
            ->get();

        foreach ($product_warehouse_data as $product_warehouse) {
            if ($product_warehouse->product_variant_id) {
                $productsVariants = ProductVariant::where('product_id', $product_warehouse->product_id)
                    ->where('id', $product_warehouse->product_variant_id)
                    ->where('deleted_at', null)
                    ->first();

                $item['product_variant_id'] = $product_warehouse->product_variant_id;
                $item['Variant'] = $productsVariants->name . '-' . $product_warehouse['product']->name;

                $item['code'] = $productsVariants->code;
                $item['name'] = '['.$productsVariants->name . '] ' . $product_warehouse['product']->name;

                $item['barcode'] = '['.$productsVariants->name . '] ' . $product_warehouse['product']->name;

                $product_price = $productsVariants->price;

            } else if ($product_warehouse->product_variant_id === null) {
                $item['product_variant_id'] = null;
                $item['Variant'] = null;
                $item['code'] = $product_warehouse['product']->code;
                $item['name'] = $product_warehouse['product']->name;
                $item['barcode'] = $product_warehouse['product']->code;

                $product_price =  $product_warehouse['product']->price;
            }

            $item['product_type'] = $product_warehouse['product']->type;
            $item['id']           = $product_warehouse->product_id;
            $item['qty_min']      = $product_warehouse['product']->type != 'is_service'?$product_warehouse['product']->qty_min:'---';
            $item['image']        = $product_warehouse['product']->image;

            //check if product has promotion
            $todaydate = date('Y-m-d');

            if($product_warehouse['product']->is_promo 
                && $todaydate >= $product_warehouse['product']->promo_start_date
                && $todaydate <= $product_warehouse['product']->promo_end_date){
                    $price_init = $product_warehouse['product']->promo_price;
                    $item['is_promotion'] = 1;
                    $item['promo_percent'] =  round(100 * ($product_price - $price_init) / $product_price);
            }else{
                $price_init = $product_price;
                $item['is_promotion'] = 0;
            }

            if ($product_warehouse['product']['unitSale'] && $product_warehouse['product']['unitSale']->operator == '/') {
                $item['qte_sale'] = $product_warehouse->qte * $product_warehouse['product']['unitSale']->operator_value;
                $price = $price_init / $product_warehouse['product']['unitSale']->operator_value;

            }elseif ($product_warehouse['product']['unitSale'] && $product_warehouse['product']['unitSale']->operator == '*') {
                $item['qte_sale'] = $product_warehouse->qte / $product_warehouse['product']['unitSale']->operator_value;
                $price = $price_init * $product_warehouse['product']['unitSale']->operator_value;
           
            }else{
                $item['qte_sale'] = $product_warehouse->qte;
                $price = $price_init;
            }

            $item['unitSale'] = $product_warehouse['product']['unitSale']?$product_warehouse['product']['unitSale']->ShortName:'';
            $item['qte'] = $product_warehouse->qte;

            if ($product_warehouse['product']->TaxNet !== 0.0) {

                //Exclusive
                if ($product_warehouse['product']->tax_method == '1') {
                    $tax_price = $price * $product_warehouse['product']->TaxNet / 100;

                    $item['Net_price'] = $this->render_price_with_symbol_placement(number_format($price + $tax_price, 2, '.', ','));

                    // Inxclusive
                } else {
                    $item['Net_price'] = $this->render_price_with_symbol_placement(number_format($price, 2, '.', ','));
                }
            } else {
                $item['Net_price'] = $this->render_price_with_symbol_placement(number_format($price, 2, '.', ','));
            }

            $data[] = $item;
        }

        return response()->json([
            'products' => $data,
            'totalRows' => $totalRows,
        ]);
    }


    //------------ autocomplete_product_pos -----------------\\

    public function autocomplete_product_pos(request $request, $id)
    {
        $data = [];
        $product_warehouse_data = product_warehouse::with('warehouse', 'product', 'productVariant')
            ->where('warehouse_id', $id)
            ->where('deleted_at', '=', null)
            ->where(function ($query) use ($request) {
                if ($request->stock == '1' && $request->product_service == '1') {
                    return $query->where('qte', '>', 0)->orWhere('manage_stock', false);

                }elseif($request->stock == '1' && $request->product_service == '0') {
                    return $query->where('qte', '>', 0)->orWhere('manage_stock', true);

                }else{
                    return $query->where('manage_stock', true);
                }
            })

        // Filter
        ->where(function ($query) use ($request) {
            return $query->when($request->filled('category_id'), function ($query) use ($request) {
                return $query->whereHas('product', function ($q) use ($request) {
                    $q->where('category_id', '=', $request->category_id);
                });
            });
        })
        ->where(function ($query) use ($request) {
            return $query->when($request->filled('brand_id'), function ($query) use ($request) {
                return $query->whereHas('product', function ($q) use ($request) {
                    $q->where('brand_id', '=', $request->brand_id);
                });
            });
        })->get();

        foreach ($product_warehouse_data as $product_warehouse) {

            if ($product_warehouse->product_variant_id) {
                $item['product_variant_id'] = $product_warehouse->product_variant_id;

                $item['code'] = $product_warehouse['productVariant']->code;
                $item['name'] = '['.$product_warehouse['productVariant']->name . '] ' . $product_warehouse['product']->name;

                $item['Variant'] = '['.$product_warehouse['productVariant']->name . '] ' . $product_warehouse['product']->name;
                $item['barcode'] = '['.$product_warehouse['productVariant']->name . '] ' . $product_warehouse['product']->name;

            } else {
                $item['product_variant_id'] = null;
                $item['Variant'] = null;
                $item['code'] = $product_warehouse['product']->code;
                $item['name'] = $product_warehouse['product']->name;
                $item['barcode'] = $product_warehouse['product']->code;
            }

            $item['id'] = $product_warehouse->product_id;
            
            $item['qty_min'] = $product_warehouse['product']->type != 'is_service'?$product_warehouse['product']->qty_min:'---';
            $item['Type_barcode'] = $product_warehouse['product']->Type_barcode;
            $item['product_type'] = $product_warehouse['product']->type;

            if ($product_warehouse['product']['unitSale'] && $product_warehouse['product']['unitSale']->operator == '/') {
                $item['qte_sale'] = $product_warehouse->qte * $product_warehouse['product']['unitSale']->operator_value;
           
            } elseif ($product_warehouse['product']['unitSale'] && $product_warehouse['product']['unitSale']->operator == '*') {
                $item['qte_sale'] = $product_warehouse->qte / $product_warehouse['product']['unitSale']->operator_value;
            
            }else{
                $item['qte_sale'] = $product_warehouse->qte;
            }

            $item['qte'] = $product_warehouse->qte;
            $item['unitSale'] = $product_warehouse['product']['unitSale']?$product_warehouse['product']['unitSale']->ShortName:'';

            $data[] = $item;
        }

        return response()->json($data);
    }

     //------------- Reference Number Order SALE -----------\\
 
     public function getNumberOrder()
     {
 
         $last = DB::table('sales')->latest('id')->first();
 
         if ($last) {
             $item = $last->Ref;
             $nwMsg = explode("_", $item);
             $inMsg = $nwMsg[1] + 1;
             $code = $nwMsg[0] . '_' . $inMsg;
         } else {
             $code = 'V_1';
         }
         return $code;
     }

     //-------------- Print Invoice ---------------\\

public function Print_Invoice_POS(Request $request, $id)
{
    $user_auth = auth()->user();

    if ($user_auth->can('pos')){

        $details = array();

        $sale = Sale::with('details.product.unitSale', 'client')
            ->where('deleted_at', '=', null)
            ->findOrFail($id);

        $item['id']                     = $sale->id;
        $item['Ref']                    = $sale->Ref;
        $item['date']                   = Carbon::parse($sale->date)->format('d-m-Y H:i');
        $item['client_id']              = $sale->client_id;

        if($sale->discount_type == 'fixed'){
            $item['discount']           = $this->render_price_with_symbol_placement(number_format($sale->discount, 2, '.', ','));
        }else{
            $item['discount']           = $this->render_price_with_symbol_placement(number_format($sale->discount_percent_total, 2, '.', ',')) .'('.$sale->discount .' '.'%)';
        }

        $item['shipping']               = $this->render_price_with_symbol_placement(number_format($sale->shipping, 2, '.', ','));
        $item['taxe']                   = $this->render_price_with_symbol_placement(number_format($sale->TaxNet, 2, '.', ','));
        $item['tax_rate']               = $sale->tax_rate;
        $item['client_name']            = $sale['client']->username ?? 'N/A';
        
        // Additional client information
        $item['client_address']         = $sale['client']->adresse ?? '';
        $item['client_phone']           = $sale['client']->phone ?? '';
        
        $item['warehouse_name']         = $sale['warehouse']->name;
        $item['GrandTotal']             = $this->render_price_with_symbol_placement(number_format($sale->GrandTotal, 2, '.', ','));
        $item['paid_amount']            = $this->render_price_with_symbol_placement(number_format($sale->paid_amount, 2, '.', ','));
        $item['due']                    = $this->render_price_with_symbol_placement(number_format($sale->GrandTotal - $sale->paid_amount, 2, '.', ','));
        
        // Additional dates and notes
        $item['trial_date']             = $sale->trial_date ? Carbon::parse($sale->trial_date)->format('d-m-Y') : '';
        $item['delivery_date']          = $sale->delivery_date ? Carbon::parse($sale->delivery_date)->format('d-m-Y') : '';
        $item['notes']                  = $sale->notes ?? '';

        foreach ($sale['details'] as $detail) {
            $unit = Unit::where('id', $detail->sale_unit_id)->first();

            if ($detail->product_variant_id) {
                $productsVariants = ProductVariant::where('product_id', $detail->product_id)
                    ->where('id', $detail->product_variant_id)->first();

                $data['code'] = $productsVariants->code ?? '';
                $data['name'] = '['.$productsVariants->name . '] ' . $detail['product']['name'];
            } else {
                $data['code'] = $detail['product']['code'] ?? '';
                $data['name'] = $detail['product']['name'] ?? '';
            }

            $data['price'] = $this->render_price_with_symbol_placement(number_format($detail->price, 2, '.', ','));
            $data['total'] = $this->render_price_with_symbol_placement(number_format($detail->total, 2, '.', ','));
            $data['quantity'] = $detail->quantity;
            $data['unit_sale'] = $unit ? $unit->ShortName : '';
            $data['is_imei'] = $detail['product']['is_imei'] ?? false;
            $data['imei_number'] = $detail->imei_number ?? '';

            $details[] = $data;
        }

        // Prepare measurements data
        $measurements = [
            // Shirt measurements
            'shirt_length'      => $sale->shirt_length ?? '',
            'shoulder'          => $sale->shirt_shoulder ?? '',
            'sleeves'           => $sale->shirt_sleeves ?? '',
            'chest'             => $sale->shirt_chest ?? '',
            'upper_waist'       => $sale->shirt_upper_waist ?? '',
            'lower_waist'       => $sale->shirt_lower_waist ?? '',
            'hip'               => $sale->shirt_hip ?? '',
            'neck'              => $sale->shirt_neck ?? '',
            'arms'              => $sale->shirt_arms ?? '',
            'cuff'              => $sale->shirt_cuff ?? '',
            'biceps'            => $sale->shirt_biceps ?? '',
            'collar_type'       => $sale->shirt_collar_type ?? '',
            'daman_type'        => $sale->shirt_daman_type ?? '',
            
            // Pant measurements
            'pant_length'       => $sale->pant_length ?? '',
            'waist'             => $sale->pant_waist ?? '',
            'pant_hip'          => $sale->pant_hip ?? '',
            'thigh'             => $sale->pant_thigh ?? '',
            'knee'              => $sale->pant_knee ?? '',
            'bottom'            => $sale->pant_bottom ?? '',
            'fly'               => $sale->pant_fly ?? '',
        ];

        $payments = PaymentSale::with('sale','payment_method')
            ->where('sale_id', $id)
            ->orderBy('id', 'DESC')
            ->get();

        $payments_details = [];
        foreach ($payments as $payment) {
            $payment_data['Reglement'] = $payment->payment_method->title ?? '';
            $payment_data['montant']   = $this->render_price_with_symbol_placement(number_format($payment->montant, 2, '.', ','));
            $payments_details[] = $payment_data;
        }

        // Calculate previous outstanding balance (before this transaction)
        $client_id = $sale->client_id;
        
        $total_amount = DB::table('sales')
            ->where('deleted_at', '=', null)
            ->where('client_id', $client_id)
            ->where('id', '!=', $id) // Exclude current sale
            ->sum('GrandTotal');

        $total_paid = DB::table('sales')
            ->where('sales.deleted_at', '=', null)
            ->where('sales.client_id', $client_id)
            ->where('id', '!=', $id) // Exclude current sale
            ->sum('paid_amount');

        $previous_balance = $total_amount - $total_paid;
        
        // Format the previous balance with currency symbol
        $previous_balance_formatted = $this->render_price_with_symbol_placement(
            number_format($previous_balance, 2, '.', ',')
        );

        $settings = Setting::where('deleted_at', '=', null)->first();
        $pos_settings = PosSetting::where('deleted_at', '=', null)->first();

        return view('sales.invoice_pos',
            [
                'payments' => $payments_details,
                'setting' => $settings,
                'pos_settings' => $pos_settings,
                'sale' => $item,
                'details' => $details,
                'previous_balance' => $previous_balance_formatted,
                'measurements' => $measurements, // New measurements data
            ]
        );
    }

    return abort('403', __('You are not authorized'));
}



    // render_price_with_symbol_placement

    public function render_price_with_symbol_placement($amount) {

        if ($this->symbol_placement == 'before') {
            return $this->currency . ' ' . $amount;
        } else {
            return $amount . ' ' . $this->currency;
        }
    }

   

}
