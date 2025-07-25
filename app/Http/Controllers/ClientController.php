<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Imports\ClientImport;
use App\Models\User;
use App\Models\Client;
use App\Models\AgentCommercial;
use App\Models\Sale;
use App\Models\PaymentSale;
use App\Models\PaymentSaleReturns;
use App\Models\SaleReturn;
use Carbon\Carbon;
use App\Models\PaymentMethod;
use App\Models\Account;
use App\Models\Warehouse;
use App\Models\Unit;
use App\Models\Setting;

use Excel;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use DataTables;
use App\utils\helpers;
use DB;
use Auth;
use App\Services\AccountLedgerService;
class ClientController extends Controller
{

    protected $currency;
    protected $symbol_placement;

    public function __construct()
    {
        $helpers = new helpers();
        $this->currency = $helpers->Get_Currency();
        $this->symbol_placement = $helpers->get_symbol_placement();

    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {

        $user_auth = auth()->user();
		if ($user_auth->can('client_view_all') || $user_auth->can('client_view_own')){

            $payment_methods = PaymentMethod::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','title']);

            return view('clients.client_list', compact('payment_methods'));

        }
        return abort('403', __('You are not authorized'));

    }



    public function get_clients_datatable(Request $request)
    {

        $user_auth = auth()->user();
        if (!$user_auth->can('client_view_all') && !$user_auth->can('client_view_own')){
            return abort('403', __('You are not authorized'));
        }else{

            $columns_order = array( 
                0 => 'id', 
                3 => 'code', 
                4 => 'username',
            );

            $start = $request->input('start');
            $order = 'clients.'.$columns_order[$request->input('order.0.column')];
            $dir = $request->input('order.0.dir');

            $clients_data = Client::where('deleted_at', '=', null)
            ->where(function ($query) use ($user_auth) {
                if (!$user_auth->can('client_view_all')) {
                    return $query->where('user_id', '=', $user_auth->id);
                }
            })

            // Search With Multiple Param
            ->where(function ($query) use ($request) {
                return $query->when($request->filled('search'), function ($query) use ($request) {
                    return $query->where('username', 'LIKE', "%{$request->input('search.value')}%")
                        ->orWhere('code', 'LIKE', "%{$request->input('search.value')}%")
                        ->orWhere('phone', 'like', "%{$request->input('search.value')}%");
                });
            });

            $totalRows = $clients_data->count();
            $totalFiltered = $totalRows;

            if($request->input('length') != -1)
            $limit = $request->input('length');
            else
            $limit = $totalRows;

            $clients = $clients_data
            ->offset($start)
            ->limit($limit)
            ->orderBy($order, $dir)
            ->get();

            $data = array();

            foreach ($clients as $client) {
                $item['id']    = $client->id;
                $url = url("images/clients/".$client->photo);
                $item['photo'] =  '<div class="avatar mr-2 avatar-md"><img src="'.$url.'" alt=""></div>';
                $item['code'] = $client->code;
                $item['username'] = $client->username;
                $item['phone'] = $client->phone;
                $item['city'] = $client->city;

                //sell_due
                $sell_due = 0;

                $total_amount = DB::table('sales')
                    ->where('deleted_at', '=', null)
                    ->where('client_id', $client->id)
                    ->sum('GrandTotal');
    
                $total_paid = DB::table('sales')
                    ->where('sales.deleted_at', '=', null)
                    ->where('sales.client_id', $client->id)
                    ->sum('paid_amount');

                $sell_due = $total_amount - $total_paid;
                $item['sell_due'] =  $this->render_price_with_symbol_placement(number_format($sell_due, 2, '.', ','));

                //return due
                $total_return_Due = 0;

                $total_amount_return = DB::table('sale_returns')
                ->where('deleted_at', '=', null)
                ->where('client_id', $client->id)
                ->sum('GrandTotal');

                $total_paid_return = DB::table('sale_returns')
                    ->where('sale_returns.deleted_at', '=', null)
                    ->where('sale_returns.client_id', $client->id)
                    ->sum('paid_amount');
    
                $total_return_Due = $total_amount_return - $total_paid_return;

                $item['return_due'] =  $this->render_price_with_symbol_placement(number_format($total_return_Due, 2, '.', ','));

             
                //status

                if($client->status == 1){
                    $item['status'] = '<span class="badge badge-success">Client Active</span>';
                }else{
                    $item['status'] = '<span class="badge badge-warning">Client In-Active</span>';
                }

                $item['action'] =  '<div class="dropdown">
                            <button class="btn btn-outline-info btn-rounded dropdown-toggle" id="dropdownMenuButton" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                            .trans('translate.Action').

                            '</button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" x-placement="bottom-start" style="position: absolute; will-change: transform; top: 0px; left: 0px; transform: translate3d(0px, 34px, 0px);">';
                                
                                //check if user has permission "pay_sale_due"
                                 if ($user_auth->can('client_details')){
                                    $item['action'] .=  ' <a class="dropdown-item" href="/people/clients/' .$client->id.'"> <i class="nav-icon  i-Eye font-weight-bold mr-2"></i> ' .trans('translate.Customer_details').'</a>';
                                }

                                 //check if user has permission "client_edit"
                                 if ($user_auth->can('client_edit')){
                                    $item['action'] .=  '<a class="dropdown-item" href="/people/clients/' .$client->id. '/edit" ><i class="nav-icon i-Edit font-weight-bold mr-2"></i> ' .trans('translate.Edit_Customer').'</a>';
                                }

                                //check if user has permission "pay_sale_due"
                                 if ($user_auth->can('pay_sale_due')){
                                    $item['action'] .=  '<a class="dropdown-item payment_sale cursor-pointer"  id="' .$client->id. '" > <i class="nav-icon i-Dollar font-weight-bold mr-2"></i> ' .trans('translate.pay_all_sell_due_at_a_time').'</a>';
                                }

                                 //check if user has permission "payment_sale_return"
                                 if ($user_auth->can('pay_sale_return_due')){
                                    $item['action'] .=  '<a class="dropdown-item payment_sale_return cursor-pointer"  id="' .$client->id. '" > <i class="nav-icon i-Dollar font-weight-bold mr-2"></i> '.trans('translate.pay_all_sell_return_due_at_a_time').'</a>';
                                }

                                //check if user has permission "client_delete"
                                if ($user_auth->can('client_delete')){
                                    $item['action'] .=  '<a class="dropdown-item delete cursor-pointer" id="' .$client->id. '" > <i class="nav-icon i-Close-Window font-weight-bold mr-2"></i> ' .trans('translate.Delete_Customer').'</a>';
                                }
                                if ($user_auth->can('client_details')) {
    $item['action'] .=  '<a class="dropdown-item" href="/clients/' .$client->id. '/ledger/export">
        <i class="nav-icon i-File-Excel font-weight-bold mr-2"></i> Export Ledger
    </a>';
}

                                $item['action'] .=  '</div>
                        </div>';
                    $data[] = $item;
            }


            $json_data = array(
                "draw"            => intval($request->input('draw')),  
                "recordsTotal"    => intval($totalRows),  
                "recordsFiltered" => intval($totalFiltered), 
                "data"            => $data   
            );
                
            echo json_encode($json_data);
        }
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $user_auth = auth()->user();
		if ($user_auth->can('client_add')){

            return view('clients.create_client');
        }
        return abort('403', __('You are not authorized'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('client_add')){

            $request->validate([
                'username' => 'required',
                'photo'          => 'nullable|image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
            ]);

            if ($request->hasFile('photo')) {

                $image = $request->file('photo');
                $filename = time().'.'.$image->extension();  
                $image->move(public_path('/images/clients'), $filename);

            } else {
                $filename = 'no_avatar.png';
            }
            
            Client::create([

                'user_id'        => $user_auth->id,
                'username'       => $request['username'],
                'code'           => $this->getNumberOrder(),
                'email'          => $request['email'],
                'city'           => $request['city'],
                'phone'          => $request['phone'],
                'address'        => $request['address'],
                'status'         => 1,
                'photo'          => $filename,
            ]);

            return response()->json(['success' => true]);
        }
         return abort('403', __('You are not authorized'));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
public function show(Request $request, $id)
{
    $user_auth = auth()->user();

    if ($user_auth->can('client_details')) {
        $helpers = new helpers();
        $currency = $helpers->Get_Currency();

        $client = Client::where('deleted_at', '=', null)
            ->where(function ($query) use ($user_auth) {
                if (!$user_auth->can('client_view_all')) {
                    return $query->where('user_id', '=', $user_auth->id);
                }
            })->findOrFail($id);

        $client_data = [];

        $item['full_name'] = $client->username;
        $item['code'] = $client->code;
        $item['phone'] = $client->phone;
        $item['address'] = $client->address;
        $item['status'] = $client->status == 1 ? 1 : 0;

        $total_amount = DB::table('sales')
            ->where('deleted_at', '=', null)
            ->where('client_id', $id)
            ->sum('GrandTotal');

        $total_paid = DB::table('sales')
            ->where('sales.deleted_at', '=', null)
            ->where('sales.client_id', $id)
            ->sum('paid_amount');

        $total_debt = $total_amount - $total_paid;

        $item['total_sales'] = DB::table('sales')
            ->where('deleted_at', '=', null)
            ->where('client_id', $id)
            ->count();

        $item['total_amount'] = $this->render_price_with_symbol_placement(number_format($total_amount, 2, '.', ','));
        $item['total_paid']   = $this->render_price_with_symbol_placement(number_format($total_paid, 2, '.', ','));
        $item['total_debt']   = $this->render_price_with_symbol_placement(number_format($total_debt, 2, '.', ','));

        $client_data[] = $item;

        // 💡 Fetch sales history
        $sales = DB::table('sales')
            ->where('deleted_at', '=', null)
            ->where('client_id', $id)
            ->select('id','Ref', 'date', 'created_at')
            ->orderBy('date', 'desc')
            ->get();

        return view('clients.details_client', [
            'client_id' => $id,
            'client_data' => $client_data[0],
            'sales' => $sales,
        ]);
    }

    return abort('403', __('You are not authorized'));
}


    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('client_edit')){

            $client = Client::where('deleted_at', '=', null)
            ->where(function ($query) use ($user_auth) {
                if (!$user_auth->can('client_view_all')) {
                    return $query->where('user_id', '=', $user_auth->id);
                }
            })->findOrFail($id);
            
            return view('clients.edit_client', compact('client'));

        }
        return abort('403', __('You are not authorized'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('client_edit')){

            $this->validate($request, [
                'username' => 'required|string|max:255',
                'photo'          => 'nullable|image|mimes:jpeg,png,jpg,bmp,gif,svg|max:2048',
            ]);

            $user = Client::findOrFail($id);
            $currentAvatar = $user->photo;
            if ($request->photo) {
                if ($request->photo != $currentAvatar) {

                    $image = $request->file('photo');
                    $filename = time().'.'.$image->extension();  
                    $image->move(public_path('/images/clients'), $filename);
                    $path = public_path() . '/images/clients';
                    $userPhoto = $path . '/' . $currentAvatar;
                    if (file_exists($userPhoto)) {
                        if ($user->photo != 'no_avatar.png') {
                            @unlink($userPhoto);
                        }
                    }
                } else {
                    $filename = $currentAvatar;
                }
            }else{
                $filename = $currentAvatar;
            }

            $client = Client::whereId($id)->update([
                'username'       => $request['username'],
                'email'          => $request['email'],
                'city'           => $request['city'],
                'phone'          => $request['phone'],
                'address'        => $request['address'],
                'status'         => 1,
                'photo'          => $filename,
            ]);
          
            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('client_delete')){

            Client::whereId($id)->update([
                'deleted_at' => Carbon::now(),
            ]);

            return response()->json(['success' => true]);

        }
        return abort('403', __('You are not authorized'));
    }

     //------------- get Number Order Customer -------------\\

     public function getNumberOrder()
     {
         $last = DB::table('clients')->latest('id')->first();
 
         if ($last) {
             $code = $last->code + 1;
         } else {
             $code = 1;
         }
         return $code;
     }
 

    public function get_client_debt_total($id){

        $user_auth = auth()->user();
		if ($user_auth->can('pay_sale_due')){

            $client = Client::findOrFail($id);
            $sell_due = 0;

            $item['total_amount'] = DB::table('sales')
                ->where('deleted_at', '=', null)
                ->where('client_id', $id)
                ->sum('GrandTotal');

            $item['total_paid'] = DB::table('sales')
                ->where('sales.deleted_at', '=', null)
                ->where('sales.client_id', $id)
                ->sum('paid_amount');

            $sell_due =  $item['total_amount'] - $item['total_paid'];

            $payment_methods = PaymentMethod::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','title']);
            $accounts = Account::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','account_name']);

            return response()->json([
                'sell_due' => $sell_due,
                'payment_methods' => $payment_methods,
                'accounts' => $accounts,
            ]);

        }
        return abort('403', __('You are not authorized'));
    }

     //------------- clients_pay_due -------------\\

//      public function clients_pay_due(Request $request)
//      {
//         $user_auth = auth()->user();
// 		if ($user_auth->can('pay_sale_due')){

//             request()->validate([
//                 'client_id'           => 'required',
//                 'payment_method_id'   => 'required',
//             ]);

//             if($request['montant'] > 0){
//                 $client_sales_due = Sale::where('deleted_at', '=', null)
//                 ->where([
//                     ['payment_statut', '!=', 'paid'],
//                     ['client_id', $request->client_id]
//                 ])->get();

//                     $paid_amount_total = $request->montant;


//                         foreach($client_sales_due as $key => $client_sale){
//                             if($paid_amount_total == 0)
//                             break;
//                             $due = $client_sale->GrandTotal  - $client_sale->paid_amount;

//                             if($paid_amount_total >= $due){
//                                 $amount = $due;
//                                 $payment_status = 'paid';
//                             }else{
//                                 $amount = $paid_amount_total;
//                                 $payment_status = 'partial';
//                             }

//                             $payment_sale = new PaymentSale();
//                             $payment_sale->date = $request['date'];
//                             $payment_sale->account_id =  $request['account_id']?$request['account_id']:NULL;
//                             $payment_sale->sale_id = $client_sale->id;
//                             $payment_sale->Ref = $this->generate_random_code_payment();
//                             $payment_sale->payment_method_id = $request['payment_method_id'];
//                             $payment_sale->montant = $amount;
//                             $payment_sale->change = 0;
//                             $payment_sale->notes = $request['notes'];
//                             $payment_sale->user_id = Auth::user()->id;
//                             $payment_sale->save();

//                             \App\Services\ClientLedgerService::log(
//     $request->client_id,
//     'sale_payment',
//     $payment_sale->Ref,
//     0,
//     $amount
// );
//                             $account = Account::where('id', $request['account_id'])->exists();

//                             if ($account) {
//                                 // Account exists, perform the update
//                                 $account = Account::find($request['account_id']);
//                                 $account->update([
//                                     'initial_balance' => $account->initial_balance + $amount,
//                                 ]);
//                             }

//                             $client_sale->paid_amount += $amount;
//                             $client_sale->payment_statut = $payment_status;
//                             $client_sale->save();

//                             $paid_amount_total -= $amount;
//                         }

//             }
            
//             return response()->json(['success' => true]);

//         }
//         return abort('403', __('You are not authorized'));
 
//      }
          public function clients_pay_due(Request $request)
{
    $user_auth = auth()->user();
    if ($user_auth->can('pay_sale_due')) {

        request()->validate([
            'client_id'         => 'required',
            'payment_method_id' => 'required',
        ]);

        if ($request['montant'] > 0) {

            $client_sales_due = Sale::whereNull('deleted_at')
                ->where('payment_statut', '!=', 'paid')
                ->where('client_id', $request->client_id)
                ->get();

            $paid_amount_total = $request->montant;

            foreach ($client_sales_due as $client_sale) {

                if ($paid_amount_total == 0) break;

                $due = $client_sale->GrandTotal - $client_sale->paid_amount;

                $amount = $paid_amount_total >= $due ? $due : $paid_amount_total;
                $payment_status = $paid_amount_total >= $due ? 'paid' : 'partial';

                // Save PaymentSale
                $payment_sale = new PaymentSale();
                $payment_sale->date = $request['date'];
                $payment_sale->account_id = $request['account_id'] ?? NULL;
                $payment_sale->sale_id = $client_sale->id;
                $payment_sale->Ref = $this->generate_random_code_payment();
                $payment_sale->payment_method_id = $request['payment_method_id'];
                $payment_sale->montant = $amount;
                $payment_sale->change = 0;
                $payment_sale->notes = $request['notes'];
                $payment_sale->user_id = Auth::id();
                $payment_sale->save();

                // Client Ledger Log
                \App\Services\ClientLedgerService::log(
                    $request->client_id,
                    'sale_payment',
                    $payment_sale->Ref,
                    0,
                    $amount
                );

                // ✅ Account Ledger Log (NEW)
                if ($request['account_id']) {
                    AccountLedgerService::log(
                        $request['account_id'],
                        'client_payment',
                        $payment_sale->Ref,
                        $amount, // Money is going out
                        0
                    );
                }

                // Update Account balance
                if ($request['account_id']) {
                    $account = Account::find($request['account_id']);
                    if ($account) {
                        $account->update([
                            'initial_balance' => $account->initial_balance + $amount,
                        ]);
                    }
                }

                // Update Sale
                $client_sale->paid_amount += $amount;
                $client_sale->payment_statut = $payment_status;
                $client_sale->save();

                $paid_amount_total -= $amount;
            }
        }

        return response()->json(['success' => true]);
    }

    return abort('403', __('You are not authorized'));
}
     public function get_client_debt_return_total($id){

        $user_auth = auth()->user();
		if ($user_auth->can('pay_sale_return_due')){

            $client = Client::findOrFail($id);
            $return_due = 0;

            $item['total_amount_return'] = DB::table('sale_returns')
                ->where('deleted_at', '=', null)
                ->where('client_id', $id)
                ->sum('GrandTotal');

            $item['total_paid_return'] = DB::table('sale_returns')
                ->where('sale_returns.deleted_at', '=', null)
                ->where('sale_returns.client_id', $id)
                ->sum('paid_amount');
            
            $return_due =  $item['total_amount_return'] - $item['total_paid_return'];

            $payment_methods = PaymentMethod::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','title']);
            $accounts = Account::where('deleted_at', '=', null)->orderBy('id', 'desc')->get(['id','account_name']);

            return response()->json([
                'return_due' => $return_due,
                'payment_methods' => $payment_methods,
                'accounts' => $accounts,
            ]);

        }
        return abort('403', __('You are not authorized'));
    }

     //------------- clients_pay_return_due -------------\\

   public function clients_pay_return_due(Request $request)
{
    $user_auth = auth()->user();
    if ($user_auth->can('pay_sale_return_due')) {

        request()->validate([
            'client_id'         => 'required',
            'payment_method_id' => 'required',
        ]);

        if ($request['montant'] > 0) {

            $client_sell_return_due = SaleReturn::whereNull('deleted_at')
                ->where('payment_statut', '!=', 'paid')
                ->where('client_id', $request->client_id)
                ->get();

            $paid_amount_total = $request->montant;

            foreach ($client_sell_return_due as $client_sale_return) {

                if ($paid_amount_total == 0) break;

                $due = $client_sale_return->GrandTotal - $client_sale_return->paid_amount;

                $amount = $paid_amount_total >= $due ? $due : $paid_amount_total;
                $payment_status = $paid_amount_total >= $due ? 'paid' : 'partial';

                // Save PaymentSaleReturns
                $payment_sale_return = new PaymentSaleReturns();
                $payment_sale_return->sale_return_id = $client_sale_return->id;
                $payment_sale_return->account_id = $request['account_id'] ?? NULL;
                $payment_sale_return->Ref = $this->generate_random_code_payment_return();
                $payment_sale_return->date = $request['date'];
                $payment_sale_return->payment_method_id = $request['payment_method_id'];
                $payment_sale_return->montant = $amount;
                $payment_sale_return->change = 0;
                $payment_sale_return->notes = $request['notes'];
                $payment_sale_return->user_id = Auth::id();
                $payment_sale_return->save();

                // Client Ledger Log
                \App\Services\ClientLedgerService::log(
                    $request->client_id,
                    'sale_return_payment',
                    $payment_sale_return->Ref,
                    $amount, // debit: money goes to client
                    0
                );

                // ✅ Account Ledger Log (NEW)
                if ($request['account_id']) {
                    AccountLedgerService::log(
                        $request['account_id'],
                        'client_return_payment',
                        $payment_sale_return->Ref,
                        $amount, // debit: money paid out
                        0
                    );
                }

                // Update Account Balance
                if ($request['account_id']) {
                    $account = Account::find($request['account_id']);
                    if ($account) {
                        $account->update([
                            'initial_balance' => $account->initial_balance - $amount,
                        ]);
                    }
                }

                // Update SaleReturn
                $client_sale_return->paid_amount += $amount;
                $client_sale_return->payment_statut = $payment_status;
                $client_sale_return->save();

                $paid_amount_total -= $amount;
            }
        }

        return response()->json(['success' => true]);
    }

    return abort('403', __('You are not authorized'));
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

    // generate_random_code_payment_return
    public function generate_random_code_payment_return()
    {
        $gen_code = 'INV/RS-' . date("Ymd") . '-'. substr(number_format(time() * mt_rand(), 0, '', ''), 0, 6);

        if (PaymentSaleReturns::where('Ref', $gen_code)->exists()) {
            $this->generate_random_code_payment_return();
        } else {
            return $gen_code;
        }
        
    }

    public function import_clients_page()
    {
        $user_auth = auth()->user();
		if ($user_auth->can('import_clients')){

            return view('clients.import_clients');
        }
        return abort('403', __('You are not authorized'));
    }

    // import clients
    public function import_clients(Request $request)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('import_clients')){

            //Set maximum php execution time
            ini_set('max_execution_time', 0);

            $request->validate([
                'clients' => 'required|mimes:xls,xlsx',
            ]);

            $client_array = Excel::toArray(new ClientImport, $request->file('clients'));

            $clients = [];

            foreach ($client_array[0] as $key => $value) {

                //--client name
                if($value['full_name'] != ''){
                    $row['username'] = $value['full_name'];
                }else{
                    return back()->with('error','Nom du Client n\'existe pas!');
                }

                //--client email
                if ($value['email'] != '') {
                    $row['email'] = $value['email'];
                } else {
                    $row['email'] = NULL;
                }

                //--client country
                if ($value['country'] != '') {
                    $row['country'] = $value['country'];
                } else {
                    $row['country'] = NULL;
                }

                //--client city
                if ($value['city'] != '') {
                    $row['city'] = $value['city'];
                } else {
                    $row['city'] = NULL;
                }

                //--client address
                if ($value['address'] != '') {
                    $row['address'] = $value['address'];
                } else {
                    $row['address'] = NULL;
                }

                //--client phone
                if ($value['phone'] != '') {
                    $row['phone'] = $value['phone'];
                } else {
                    $row['phone'] = NULL;
                }

                $clients[]= $row;
            }

            foreach ($clients as $key => $client_value) {

                $client = new Client;

                $client->username = $client_value['username'];
                $client->code = $this->getNumberOrder();
                $client->email = $client_value['email'];
                $client->country = $client_value['country'];
                $client->city = $client_value['city'];
                $client->address = $client_value['address'];
                $client->phone = $client_value['phone'];

                //default value
                $client->status = 1;
                $client->photo = 'no_avatar.png';
        
                $client->save();
               
            }
            
            return redirect()->back()->with('success','Clients Imported successfully!');

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



    public function getClientDue($id)
{
    $client = Client::findOrFail($id);
    
    // Calculate outstanding balance
    $total_amount = DB::table('sales')
        ->where('deleted_at', '=', null)
        ->where('client_id', $client->id)
        ->sum('GrandTotal');

    $total_paid = DB::table('sales')
        ->where('sales.deleted_at', '=', null)
        ->where('sales.client_id', $client->id)
        ->sum('paid_amount');

    $sell_due = $total_amount - $total_paid;
    
    return response()->json([
        'sell_due' => $this->render_price_with_symbol_placement(number_format($sell_due, 2, '.', ',')),
    ]);
}



// public function clientdetailshow($id)
// {
//     $client = Client::findOrFail($id); // Get client detail by ID

//     // Fetch related sales using Eloquent Model
//     $sales = Sale::where('client_id', $id)
//         ->whereNull('deleted_at') // Proper way to check null in Eloquent
//         ->orderBy('id', 'desc')
//         ->get();

//     return view('sales.details_sale', [
//         'client_data' => $client,
//         'sales' => $sales,
//     ]);
// }

public function clientdetailshow($id)
{
    $user_auth = auth()->user();
    if ($user_auth->can('sales_details')) {

        if($user_auth->is_all_warehouses){
            $array_warehouses_id = Warehouse::where('deleted_at', '=', null)->pluck('id')->toArray();
        } else {
            $array_warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
        }

        $sale_data = Sale::with('details.product.unitSale', 'details.product.category', 'details.product.brand')
            ->where('deleted_at', '=', null)
            ->where(function ($query) use ($array_warehouses_id) {
                return $query->whereIn('warehouse_id', $array_warehouses_id);
            })
            ->where(function ($query) use ($user_auth) {
                if (!$user_auth->can('sales_view_all')) {
                    return $query->where('user_id', '=', $user_auth->id);
                }
            })->findOrFail($id);

        $details = array();
        $total_quantity = 0;
        $total_product_discount = 0;

        $sale_details['id']                     = $sale_data->id;
        $sale_details['Ref']                    = $sale_data->Ref;
        $sale_details['date']                   = $sale_data->date;
        $sale_details['note']                   = $sale_data->notes;
        $sale_details['statut']                 = $sale_data->statut;
        $sale_details['warehouse']              = $sale_data['warehouse']->name;

        if($sale_data->discount_type == 'fixed'){
            $sale_details['discount']           = $this->render_price_with_symbol_placement(number_format($sale_data->discount, 2, '.', ','));
        } else {
            $sale_details['discount']           = $this->render_price_with_symbol_placement(number_format($sale_data->discount_percent_total, 2, '.', ',')) .' ('.$sale_data->discount.'%)';
        }

        $sale_details['shipping']               = $this->render_price_with_symbol_placement(number_format($sale_data->shipping, 2, '.', ','));
        $sale_details['tax_rate']               = $sale_data->tax_rate;
        $sale_details['TaxNet']                 = $this->render_price_with_symbol_placement(number_format($sale_data->TaxNet, 2, '.', ','));
        $sale_details['client_name']            = $sale_data['client']->username;
        $sale_details['client_phone']           = $sale_data['client']->phone;
        $sale_details['client_adr']             = $sale_data['client']->address;
        $sale_details['client_email']           = $sale_data['client']->email;
        $sale_details['GrandTotal']             = $this->render_price_with_symbol_placement(number_format($sale_data->GrandTotal, 2, '.', ','));
        $sale_details['paid_amount']            = $this->render_price_with_symbol_placement(number_format($sale_data->paid_amount, 2, '.', ','));
        $sale_details['due']                    = $this->render_price_with_symbol_placement(number_format($sale_data->GrandTotal - $sale_data->paid_amount, 2, '.', ','));
        $sale_details['payment_status']         = $sale_data->payment_statut;
        $sale_details['assigned_driver']        = $sale_data->assigned_driver;
        $sale_details['sale_has_return']        = SaleReturn::where('sale_id', $id)->where('deleted_at', '=', null)->exists() ? 'yes' : 'no';

        foreach ($sale_data['details'] as $detail) {
            $unit = Unit::where('id', $detail->sale_unit_id)->first();
            $product = $detail['product'];

            if ($detail->product_variant_id) {
                $productsVariants = ProductVariant::where('product_id', $detail->product_id)
                    ->where('id', $detail->product_variant_id)->first();

                $data['code'] = $productsVariants->code;
                $variant_name = '['.$productsVariants->name . '] ';
            } else {
                $data['code'] = $product['code'];
                $variant_name = '';
            }

            $category_name = $product['category'] ? $product['category']->name : '';
            $brand_name = $product['brand'] ? $product['brand']->name : '';
            $product_name = $product['name'];
            $name_parts = array_filter([$category_name, $brand_name, $product_name]);
            $data['name'] = $variant_name . implode(' - ', $name_parts);

            $data['quantity'] = $detail->quantity;
            $data['total'] = $detail->total;
            $data['price'] = $detail->price;
            $data['unit_sale'] = $unit ? $unit->ShortName : '';

            if ($detail->discount_method == '2') {
                $data['DiscountNet'] = $detail->discount;
            } else {
                $data['DiscountNet'] = $detail->price * $detail->discount / 100;
            }

            $total_product_discount += $data['DiscountNet'] * $detail->quantity;

            $tax_price = $detail->TaxNet * (($detail->price - $data['DiscountNet']) / 100);
            $data['Unit_price'] = $detail->price;
            $data['discount'] = $detail->discount;

            if ($detail->tax_method == '1') {
                $data['Net_price'] = $detail->price - $data['DiscountNet'];
                $data['taxe'] = $tax_price;
            } else {
                $data['Net_price'] = ($detail->price - $data['DiscountNet']) / (($detail->TaxNet / 100) + 1);
                $data['taxe'] = $detail->price - $data['Net_price'] - $data['DiscountNet'];
            }

            $data['is_imei'] = $product['is_imei'];
            $data['imei_number'] = $detail->imei_number;
            
            // Add all measurement fields
            $data['garment_type'] = $product->garment_type;
            $data['stitched_garment'] = $product->stitched_garment;
            
            // Kameez/Shirt measurements
            $data['kameez_length'] = $product->kameez_length;
            $data['kameez_shoulder'] = $product->kameez_shoulder;
            $data['kameez_sleeves'] = $product->kameez_sleeves;
            $data['kameez_chest'] = $product->kameez_chest;
            $data['kameez_upper_waist'] = $product->kameez_upper_waist;
            $data['kameez_lower_waist'] = $product->kameez_lower_waist;
            $data['kameez_hip'] = $product->kameez_hip;
            $data['kameez_neck'] = $product->kameez_neck;
            $data['kameez_arms'] = $product->kameez_arms;
            $data['kameez_cuff'] = $product->kameez_cuff;
            $data['kameez_biceps'] = $product->kameez_biceps;
            
            // Shalwar/Pant measurements
            $data['shalwar_length'] = $product->shalwar_length;
            $data['shalwar_waist'] = $product->shalwar_waist;
            $data['shalwar_bottom'] = $product->shalwar_bottom;
            
            // Pant/Shirt measurements
            $data['pant_length'] = $product->pant_length;
            $data['pant_waist'] = $product->pant_waist;
            $data['pant_hip'] = $product->pant_hip;
            $data['pant_thigh'] = $product->pant_thai;
            $data['pant_knee'] = $product->pant_knee;
            $data['pant_bottom'] = $product->pant_bottom;
            $data['pant_fly'] = $product->pant_fly;
            
            // Collar types
            $data['collar_shirt'] = $product->collar_shirt;
            $data['collar_sherwani'] = $product->collar_sherwani;
            $data['collar_damian'] = $product->collar_damian;
            $data['collar_round'] = $product->collar_round;
            $data['collar_square'] = $product->collar_square;
            
            // Additional measurements
            $data['pshirt_length'] = $product->pshirt_length;
            $data['pshirt_shoulder'] = $product->pshirt_shoulder;
            $data['pshirt_sleeves'] = $product->pshirt_sleeves;
            $data['pshirt_chest'] = $product->pshirt_chest;
            $data['pshirt_neck'] = $product->pshirt_neck;
            $data['pshirt_collar_shirt'] = $product->pshirt_collar_shirt;
            $data['pshirt_collar_round'] = $product->pshirt_collar_round;
            $data['pshirt_collar_square'] = $product->pshirt_collar_square;
            $data['thaan_length'] = $product->thaan_length;
            $data['suit_length'] = $product->suit_length;
            $data['available_sizes'] = $product->available_sizes;

            $details[] = $data;
            $total_quantity += $detail->quantity;
        }

        $sale_details['total_quantity'] = number_format($total_quantity, 2, '.', ',');
        $sale_details['product_discount_total'] = $this->render_price_with_symbol_placement(number_format($total_product_discount, 2, '.', ','));

        $company = Setting::where('deleted_at', '=', null)->first();

        // Previous balance logic
        $client_id = $sale_data->client_id;
        
        $total_amount_prev = DB::table('sales')
            ->where('deleted_at', '=', null)
            ->where('client_id', $client_id)
            ->where('id', '!=', $sale_data->id)
            ->sum('GrandTotal');
        
        $total_paid_prev = DB::table('sales')
            ->where('deleted_at', '=', null)
            ->where('client_id', $client_id)
            ->where('id', '!=', $sale_data->id)
            ->sum('paid_amount');
        
        $previous_balance = $total_amount_prev - $total_paid_prev;
        $sale_details['previous_balance'] = $this->render_price_with_symbol_placement(number_format($previous_balance, 2, '.', ','));
        
        // Updated balance after this sale
        $total_amount_now = $total_amount_prev + $sale_data->GrandTotal;
        $total_paid_now = $total_paid_prev + $sale_data->paid_amount;
        $updated_balance = $total_amount_now - $total_paid_now;
        $sale_details['updated_balance'] = $this->render_price_with_symbol_placement(number_format($updated_balance, 2, '.', ','));

        return view('sales.details_sale', [
            'sale' => $sale_details,
            'details' => $details,
            'company' => $company,
        ]);
    }

    return abort('403', __('You are not authorized'));
}


}