<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use App\Imports\ProductImport;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\product_warehouse;
use App\Models\Unit;
use App\Models\Warehouse;
use App\Models\UserWarehouse;
use App\Models\Currency;
use DataTables;
use Excel;
use DB;
use Carbon\Carbon;
use App\utils\helpers;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;
use Illuminate\Foundation\Validation\ValidatesRequests;

class ProductsController extends Controller
{
    protected $currency;
    protected $symbol_placement;

    public function __construct()
    {
        $helpers = new helpers();
        $this->currency = $helpers->Get_Currency();
        $this->symbol_placement = $helpers->get_symbol_placement();
    }
    // added stitched and unstiched functionality

   public function index(Request $request)
{
    $user_auth = auth()->user();
    if ($user_auth->can('products_view')){
   
        $categories = Category::where('deleted_at', null)->get(['id', 'name']);
        $brands = Brand::where('deleted_at', null)->get(['id', 'name']);

        //get warehouses assigned to user
        if($user_auth->is_all_warehouses){
            $warehouses = Warehouse::where('deleted_at', '=', null)->get(['id', 'name']);
        }else{
            $warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
            $warehouses = Warehouse::where('deleted_at', '=', null)->whereIn('id', $warehouses_id)->get(['id', 'name']);
        }

        // Get the product type from request or set default
        $type = $request->type ?? 'all';

        return view('products.list_product', compact('categories','brands','warehouses', 'type'));
    }
    return abort('403', __('You are not authorized'));
}

public function get_product_datatable(Request $request)
{
    $user_auth = auth()->user();
    if (!$user_auth->can('products_view')) {
        return abort('403', __('You are not authorized'));
    }

    if ($user_auth->is_all_warehouses) {
        $array_warehouses_id = Warehouse::where('deleted_at', '=', null)->pluck('id')->toArray();
    } else {
        $array_warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
    }

    $helpers = new helpers();
    $symbol_placement = $helpers->get_symbol_placement();

    $columns = [0 => 'name', 1 => 'category_id', 2 => 'brand_id'];
    $param = [0 => 'like', 1 => '=', 2 => '='];

    $columns_order = [
        0 => 'id',
        3 => 'name',
        4 => 'code',
    ];

    $start = $request->input('start');
    $order = 'products.' . $columns_order[$request->input('order.0.column')];
    $dir = $request->input('order.0.dir');

    $product_data = Product::where('deleted_at', '=', null)
        ->where(function ($query) use ($request) {
            return $query->when($request->filled('code'), function ($query) use ($request) {
                return $query->where('products.code', 'LIKE', "%{$request->code}%")
                    ->orWhereHas('variants', function ($query) use ($request) {
                        $query->where('code', 'LIKE', "%{$request->code}%");
                    });
            });
        });

    $products_Filtred = $helpers->filter($product_data, $columns, $param, $request)
        ->where(function ($query) use ($request) {
            return $query->when($request->filled('search.value'), function ($query) use ($request) {
                return $query->where('products.name', 'LIKE', "%{$request->input('search.value')}%")
                    ->orWhere('products.code', 'LIKE', "%{$request->input('search.value')}%")
                    ->orWhereHas('category', function ($q) use ($request) {
                        $q->where('name', 'LIKE', "%{$request->input('search.value')}%");
                    })
                    ->orWhereHas('brand', function ($q) use ($request) {
                        $q->where('name', 'LIKE', "%{$request->input('search.value')}%");
                    });
            });
        });

    $totalRows = $products_Filtred->count();
    $limit = $request->input('length') != -1 ? $request->input('length') : $totalRows;

    $products = $products_Filtred
        ->with('unit', 'category', 'brand', 'unitSale', 'unitPurchase')
        ->offset($start)
        ->limit($limit)
        ->orderBy($order, $dir)
        ->get();

    $data = [];

    foreach ($products as $product) {
        $item = [];

        $item['id'] = $product->id;
        $item['visibility'] = '<div class="form-check form-switch">
            <input class="form-check-input toggle-visibility" type="checkbox" id="visibility_' . $product->id . '" 
            ' . ($product->is_visible ? 'checked' : '') . ' data-id="' . $product->id . '">
            </div>';

        $url = url("images/products/" . $product->image);
        $item['image'] = '<div class="avatar mr-2 avatar-md"><img src="' . $url . '" alt=""></div>';

        $item['type'] = $this->getProductTypeText($product->type);
        $item['name'] = $product->name;
        $item['code'] = $product->code;
        $item['category'] = $product->category->name ?? 'N/A';
        $item['brand'] = $product->brand->name ?? 'N/A';

        if ($product->type == 'is_single') {
            $item['cost'] = $this->render_price_with_symbol_placement(number_format($product->cost, 2), $symbol_placement);
            $item['price'] = $this->render_price_with_symbol_placement(number_format($product->price, 2), $symbol_placement);
            $qty = product_warehouse::where('product_id', $product->id)
                ->whereIn('warehouse_id', $array_warehouses_id)
                ->where('deleted_at', '=', null)
                ->sum('qte');
            $item['quantity'] = $qty . ' ' . $product->unit->ShortName;

        } elseif ($product->type == 'is_variant') {
            $variants = ProductVariant::where('product_id', $product->id)->where('deleted_at', '=', null)->get();

            $item['cost'] = $item['price'] = $item['name'] = $item['code'] = $item['quantity'] = '';

            foreach ($variants as $variant) {
                $item['cost'] .= $this->render_price_with_symbol_placement(number_format($variant->cost, 2), $symbol_placement) . '<br>';
                $item['price'] .= $this->render_price_with_symbol_placement(number_format($variant->price, 2), $symbol_placement) . '<br>';
                $item['name'] .= '[' . $variant->name . '] ' . $product->name . '<br>';
                $item['code'] .= $variant->code . '<br>';

                $qty = product_warehouse::where('product_id', $product->id)
                    ->where('product_variant_id', $variant->id)
                    ->whereIn('warehouse_id', $array_warehouses_id)
                    ->where('deleted_at', '=', null)
                    ->sum('qte');

                $item['quantity'] .= $qty . ' ' . $product->unit->ShortName . '<br>';
            }

        } else {
            $item['cost'] = '----';
            $item['quantity'] = '----';
            $item['price'] = $this->render_price_with_symbol_placement(number_format($product->price, 2), $symbol_placement);
        }

        $item['tax'] = $product->TaxNet . '% (' . ($product->tax_method == 1 ? 'Exclusive' : 'Inclusive') . ')';
        $item['unit'] = $product->unit->ShortName ?? 'N/A';
        $item['stock_alert'] = $product->stock_alert;
        $item['note'] = $product->note ?? 'N/A';

        $item['garment_type'] = $product->type == 'stitched_garment' ? $product->garment_type : 'N/A';
        $item['measurements'] = $product->type == 'stitched_garment' ? $this->getGarmentMeasurements($product) : 'N/A';
        $item['thaan_length'] = $product->type == 'unstitched_garment' ? $product->thaan_length : 'N/A';
        $item['suit_length'] = $product->type == 'unstitched_garment' ? $product->suit_length : 'N/A';
        $item['available_sizes'] = $product->type == 'unstitched_garment'
            ? implode(', ', json_decode($product->available_sizes ?? '[]', true))
            : 'N/A';

      
        $item['action'] = '<button type="button" class="btn bg-transparent _r_btn border-0" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            <span class="_dot _r_block-dot bg-dark"></span>
            <span class="_dot _r_block-dot bg-dark"></span>
            <span class="_dot _r_block-dot bg-dark"></span>
        </button>';

        $item['action'] .= '<div class="dropdown-menu">';
        if ($user_auth->can('products_edit')) {
            $item['action'] .= '<a class="dropdown-item" href="/products/products/' . $product->id . '/edit" id="' . $product->id . '">
                <i class="nav-icon i-Edit text-success font-weight-bold m3-2"></i>' . trans('translate.edit_product') . '</a>';
        }
        if ($user_auth->can('products_delete')) {
            $item['action'] .= '<a class="delete dropdown-item cursor-pointer" id="' . $product->id . '">
                <i class="nav-icon i-Close-Window text-danger font-weight-bold mr-3"></i>' . trans('translate.delete_product') . '</a>';
            $item['action'] .= '<a class="dropdown-item" href="' . route('product.ledger.download', $product->id) . '">
                <i class="nav-icon i-Download text-primary font-weight-bold mr-3"></i>Download Ledger</a>';
        }
        $item['action'] .= '</div>';

        $data[] = $item;
    }

    return response()->json([
        "draw" => intval($request->input('draw')),
        "recordsTotal" => intval($totalRows),
        "recordsFiltered" => intval($totalRows),
        "data" => $data
    ]);
}


protected function getProductTypeText($type)
{
    $types = [
        'is_single' => 'Single',
        'is_variant' => 'Variable',
        'is_service' => 'Service',
        'stitched_garment' => 'Stitched Garment',
        'unstitched_garment' => 'Unstitched Garment'
    ];
    
    return $types[$type] ?? $type;
}

protected function getGarmentMeasurements($product)
{
    if ($product->garment_type == 'shirt_suit') {
        return sprintf(
            "Length: %s, Shoulder: %s, Sleeves: %s, Chest: %s",
            $product->shirt_length,
            $product->shirt_shoulder,
            $product->shirt_sleeves,
            $product->shirt_chest
        );
    } elseif ($product->garment_type == 'pant_shalwar') {
        return sprintf(
            "Length: %s, Waist: %s, Hip: %s",
            $product->pant_length,
            $product->pant_waist,
            $product->pant_hip
        );
    }
    return 'N/A';
}
 // end stitched and unstiched functionality

    public function create()
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_add')){
            $categories = Category::where('deleted_at', null)->get(['id', 'name']);
            $brands = Brand::where('deleted_at', null)->get(['id', 'name']);
            $units = Unit::where('deleted_at', null)->where('base_unit', null)->get();

            return view('products.create_product', compact('categories','brands','units'));
        }
        return abort('403', __('You are not authorized'));
    }

    public function store(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_add')){

            // define validation rules for product
            $productRules = [
                'code' => [
                    'required',
                    Rule::unique('products')->where(function ($query) {
                        return $query->where('deleted_at', '=', null);
                    }),
                    Rule::unique('product_variants')->where(function ($query) {
                        return $query->where('deleted_at', '=', null);
                    }),
                ],
                'name' => [
                    'required',
                    Rule::unique('products')->where(function ($query) {
                        return $query->whereNull('deleted_at');
                    }),
                ],
                'multiple_images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                'category_id' => 'required',
                'type' => 'required',
                'tax_method' => 'nullable|string',
                'unit_id' => Rule::requiredIf($request->type != 'is_service'),
                'cost' => Rule::requiredIf($request->type == 'is_single'),
                'price' => Rule::requiredIf($request->type != 'is_variant'),
            ];

            // if type is not is_variant, add validation for variants array
            if ($request->type == 'is_variant') {
                $productRules['variants'] = [
                    'required',
                    function ($attribute, $value, $fail) use ($request) {
                        // check if array is not empty
                        if (empty($value)) {
                            $fail('The variants array is required.');
                            return;
                        }

                        // check for duplicate codes in variants array
                        $variants = json_decode($request->variants, true);

                        if($variants){
                            foreach ($variants as $variant) {
                                if (!array_key_exists('text', $variant) || empty($variant['text'])) {
                                    $fail('Variant Name cannot be empty.');
                                    return;
                                }else if(!array_key_exists('code', $variant) || empty($variant['code'])) {
                                    $fail('Variant code cannot be empty.');
                                    return;
                                }else if(!array_key_exists('cost', $variant) || empty($variant['cost'])) {
                                    $fail('Variant cost cannot be empty.');
                                    return;
                                }else if(!array_key_exists('price', $variant) || empty($variant['price'])) {
                                    $fail('Variant price cannot be empty.');
                                    return;
                                }
                            }
                        }else{
                            $fail('The variants data is invalid.');
                            return;
                        }

                        //check if variant name empty
                        $names = array_column($variants, 'text');
                        if($names){
                            foreach ($names as $name) {
                                if (empty($name)) {
                                    $fail('Variant Name cannot be empty.');
                                    return;
                                }
                            }
                        }else{
                            $fail('Variant Name cannot be empty.');
                            return;
                        }

                        //check if variant cost empty
                        $all_cost = array_column($variants, 'cost');
                        if($all_cost){
                            foreach ($all_cost as $cost) {
                                if (empty($cost)) {
                                    $fail('Variant Cost cannot be empty.');
                                    return;
                                }
                            }
                        }else{
                            $fail('Variant Cost cannot be empty.');
                            return;
                        }

                        //check if variant price empty
                        $all_price = array_column($variants, 'price');
                        if($all_price){
                            foreach ($all_price as $price) {
                                if (empty($price)) {
                                    $fail('Variant Price cannot be empty.');
                                    return;
                                }
                            }
                        }else{
                            $fail('Variant Price cannot be empty.');
                            return;
                        }

                        //check if code empty
                        $codes = array_column($variants, 'code');
                        if($codes){
                            foreach ($codes as $code) {
                                if (empty($code)) {
                                    $fail('Variant code cannot be empty.');
                                    return;
                                }
                            }
                        }else{
                            $fail('Variant code cannot be empty.');
                            return;
                        }

                        //check if code Duplicate
                        if (count(array_unique($codes)) !== count($codes)) {
                            $fail('Duplicate codes found in variants array.');
                            return;
                        }

                        // check for duplicate codes in product_variants table
                        $duplicateCodes = DB::table('product_variants')
                            ->whereIn('code', $codes)
                            ->whereNull('deleted_at')
                            ->pluck('code')
                            ->toArray();
                        if (!empty($duplicateCodes)) {
                            $fail('This code : '.implode(', ', $duplicateCodes).' already used');
                        }

                        // check for duplicate codes in products table
                        $duplicateCodes_products = DB::table('products')
                            ->whereIn('code', $codes)
                            ->whereNull('deleted_at')
                            ->pluck('code')
                            ->toArray();
                        if (!empty($duplicateCodes_products)) {
                            $fail('This code : '.implode(', ', $duplicateCodes_products).' already used');
                        }
                    },
                ];
            }

            // validate the request data
            $validatedData = $request->validate($productRules, [
                'code.unique' => 'Product code already used.',
                'code.required' => 'This field is required',
            ]);

            \DB::transaction(function () use ($request) {
                //-- Create New Product
                $Product = new Product;

                //-- Field Required
                $Product->type = $request['type'];
                $Product->name = $request['name'];
                $Product->code = $request['code'];
                $Product->Type_barcode = 'CODE128';
                $Product->category_id = $request['category_id'];
                $Product->brand_id = $request['brand_id'] ? $request['brand_id'] : NULL;
                $Product->TaxNet = $request['TaxNet'] ? $request['TaxNet'] : 0;
                $Product->tax_method = $request['tax_method'];
                $Product->note = $request['note'];

                // Handle garment type specific fields
                if ($request['type'] == 'stitched_garment') {
                    $Product->garment_type = $request['garment_type'];
                    
                    if ($request['garment_type'] == 'shirt_suit') {
                        // Shirt/Suit measurements
                        $Product->shirt_length = $request['shirt_length'];
                        $Product->shirt_shoulder = $request['shirt_shoulder'];
                        $Product->shirt_sleeves = $request['shirt_sleeves'];
                        $Product->shirt_chest = $request['shirt_chest'];
                        $Product->shirt_upper_waist = $request['shirt_upper_waist'];
                        $Product->shirt_lower_waist = $request['shirt_lower_waist'];
                        $Product->shirt_hip = $request['shirt_hip'];
                        $Product->shirt_neck = $request['shirt_neck'];
                        $Product->shirt_arms = $request['shirt_arms'];
                        $Product->shirt_cuff = $request['shirt_cuff'];
                        $Product->shirt_biceps = $request['shirt_biceps'];
                        
                        // Collar types
                        $Product->collar_shirt = $request['collar_shirt'] ?? false;
                        $Product->collar_sherwani = $request['collar_sherwani'] ?? false;
                        $Product->collar_damian = $request['collar_damian'] ?? false;
                        $Product->collar_round = $request['collar_round'] ?? false;
                        $Product->collar_square = $request['collar_square'] ?? false;
                    } elseif ($request['garment_type'] == 'pant_shalwar') {
                        // Pant/Shalwar measurements
                        $Product->pant_length = $request['pant_length'];
                        $Product->pant_waist = $request['pant_waist'];
                        $Product->pant_hip = $request['pant_hip'];
                        $Product->pant_thai = $request['pant_thai'];
                        $Product->pant_knee = $request['pant_knee'];
                        $Product->pant_bottom = $request['pant_bottom'];
                        $Product->pant_fly = $request['pant_fly'];
                    }
                } elseif ($request['type'] == 'unstitched_garment') {
                    $Product->thaan_length = 22.5; // Fixed value
                    $Product->suit_length = 4.5;   // Fixed value
                    $Product->available_sizes = $request['available_sizes'] ?? [];
                }

                //-- check if type is_single
                if($request['type'] == 'is_single' || $request['type'] == 'stitched_garment' || $request['type'] == 'unstitched_garment'){
                    $Product->price = $request['price'];
                    $Product->cost = $request['cost'];

                    $Product->unit_id = $request['unit_id'];
                    $Product->unit_sale_id = $request['unit_sale_id'] ? $request['unit_sale_id'] : $request['unit_id'];
                    $Product->unit_purchase_id = $request['unit_purchase_id'] ? $request['unit_purchase_id'] : $request['unit_id'];

                    $Product->stock_alert = $request['stock_alert'] ? $request['stock_alert'] : 0;
                    $Product->qty_min = $request['qty_min'] ? $request['qty_min'] : 0;

                    $manage_stock = 1;

                //-- check if type is_variant
                }elseif($request['type'] == 'is_variant'){
                    $Product->price = 0;
                    $Product->cost = 0;

                    $Product->unit_id = $request['unit_id'];
                    $Product->unit_sale_id = $request['unit_sale_id'] ? $request['unit_sale_id'] : $request['unit_id'];
                    $Product->unit_purchase_id = $request['unit_purchase_id'] ? $request['unit_purchase_id'] : $request['unit_id'];

                    $Product->stock_alert = $request['stock_alert'] ? $request['stock_alert'] : 0;
                    $Product->qty_min = $request['qty_min'] ? $request['qty_min'] : 0;

                    $manage_stock = 1;

                //-- check if type is_service
                }else{
                    $Product->price = $request['price'];
                    $Product->cost = 0;

                    $Product->unit_id = NULL;
                    $Product->unit_sale_id = NULL;
                    $Product->unit_purchase_id = NULL;

                    $Product->stock_alert = 0;
                    $Product->qty_min = 0;

                    $manage_stock = 0;
                }
                
                $Product->is_variant = $request['is_variant'] == 'true' ? 1 : 0;
                $Product->is_imei = $request['is_imei'] == 'true' ? 1 : 0;

                if ($request['is_promo'] == 'true') {
                    $Product->is_promo = $request['is_promo'] == 'true' ? 1 : 0;
                    $Product->promo_price = $request['promo_price'];
                    $Product->promo_start_date = $request['promo_start_date'];
                    $Product->promo_end_date = $request['promo_end_date'];
                }

                // Handle main image
                if ($request->hasFile('image')) {
                    $image = $request->file('image');
                    $filename = time().'.'.$image->extension();  
                    $image->move(public_path('/images/products'), $filename);
                } else {
                    $filename = 'no_image.png';
                }

                $Product->image = $filename;
                $Product->save();

                // Store Multiple Images only after product is created
                if ($request->hasFile('multiple_images')) {
                    $productImages = [];
                    foreach ($request->file('multiple_images') as $image) {
                        $filename = time() . '_' . uniqid() . '.' . $image->extension();
                        $image->move(public_path('/images/products/multiple'), $filename);
                        $productImages[] = [
                            'product_id' => $Product->id,
                            'image' => $filename,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                    DB::table('product_images')->insert($productImages);
                }

                // Store Variants Product
                if ($request['type'] == 'is_variant') {
                    $variants = json_decode($request->variants);
                    $Product_variants_data = [];

                    foreach ($variants as $variant) {
                        $Product_variants_data[] = [
                            'product_id' => $Product->id,
                            'name' => $variant->text,
                            'cost' => $variant->cost,
                            'price' => $variant->price,
                            'code' => $variant->code,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                    ProductVariant::insert($Product_variants_data);
                }

                //--Store Product Warehouse
                $warehouses = Warehouse::where('deleted_at', null)->pluck('id')->toArray();
                if ($warehouses) {
                    $Product_variants = ProductVariant::where('product_id', $Product->id)
                        ->where('deleted_at', null)
                        ->get();
                    $product_warehouse = [];
                    
                    foreach ($warehouses as $warehouse) {
                        if ($request['is_variant'] == 'true') {
                            foreach ($Product_variants as $product_variant) {
                                $product_warehouse[] = [
                                    'product_id' => $Product->id,
                                    'warehouse_id' => $warehouse,
                                    'product_variant_id' => $product_variant->id,
                                    'manage_stock' => $manage_stock,
                                    'created_at' => now(),
                                    'updated_at' => now(),
                                ];
                            }
                        } else {
                            $product_warehouse[] = [
                                'product_id' => $Product->id,
                                'warehouse_id' => $warehouse,
                                'manage_stock' => $manage_stock,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ];
                        }
                    }
                    product_warehouse::insert($product_warehouse);
                }
            }, 10);

            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function show($id)
    {
        //
    }
    
    public function show_product_data($id, $variant_id)
    {
        $Product_data = Product::with('unit')
            ->where('id', $id)
            ->where('deleted_at', '=', null)
            ->first();

        $data = [];
        $item['id'] = $Product_data['id'];
        $item['image'] = $Product_data['image'];
        $item['product_type'] = $Product_data['type'];
        $item['Type_barcode'] = $Product_data['Type_barcode'];
        $item['qty_min'] = $Product_data['qty_min'];

        $item['unit_id'] = $Product_data['unit']?$Product_data['unit']->id:'';
        $item['unit'] = $Product_data['unit']?$Product_data['unit']->ShortName:'';

        $item['purchase_unit_id'] = $Product_data['unitPurchase']?$Product_data['unitPurchase']->id:'';
        $item['unitPurchase'] = $Product_data['unitPurchase']?$Product_data['unitPurchase']->ShortName:'';

        $item['sale_unit_id'] = $Product_data['unitSale']?$Product_data['unitSale']->id:'';
        $item['unitSale'] = $Product_data['unitSale']?$Product_data['unitSale']->ShortName:'';

        $item['tax_method'] = $Product_data['tax_method'];
        $item['tax_percent'] = $Product_data['TaxNet'];
        $item['is_imei'] = $Product_data['is_imei'];

        //product single
        if($Product_data['type'] == 'is_single'){
            $product_price = $Product_data['price'];
            $product_cost = $Product_data['cost'];

            $item['code'] = $Product_data['code'];
            $item['name'] = $Product_data['name'];

        //product is_variant
        }elseif($Product_data['type'] == 'is_variant'){
            $product_variant_data = ProductVariant::where('product_id', $id)
                ->where('id', $variant_id)->first();

            $product_price = $product_variant_data['price'];
            $product_cost = $product_variant_data['cost'];
            $item['code'] = $product_variant_data['code'];
            $item['name'] = '['.$product_variant_data['name'].']'.$Product_data['name'];

        //product is_service
        }else{
            $product_price = $Product_data['price'];
            $product_cost = 0;

            $item['code'] = $Product_data['code'];
            $item['name'] = $Product_data['name'];
        }

        //check if product has promotion
        $todaydate = date('Y-m-d');

        if($Product_data['is_promo'] 
            && $todaydate >= $Product_data['promo_start_date']
            && $todaydate <= $Product_data['promo_end_date']){
                $price_init = $Product_data['promo_price'];
                $item['is_promotion'] = 1;
                $item['promo_percent'] = 100 * ($product_price - $price_init) / $product_price;
        }else{
            $price_init = $product_price;
            $item['is_promotion'] = 0;
        }

        //check if product has Unit sale
        if ($Product_data['unitSale']) {
            if ($Product_data['unitSale']->operator == '/') {
                $price = $price_init / $Product_data['unitSale']->operator_value;
            } else {
                $price = $price_init * $Product_data['unitSale']->operator_value;
            }
        }else{
            $price = $price_init;
        }

        //check if product has Unit Purchase
        if ($Product_data['unitPurchase']) {
            if ($Product_data['unitPurchase']->operator == '/') {
                $cost = $product_cost / $Product_data['unitPurchase']->operator_value;
            } else {
                $cost = $product_cost * $Product_data['unitPurchase']->operator_value;
            }
        }else{
            $cost = 0;
        }

        $item['Unit_cost'] = $cost;
        $item['fix_cost'] = $product_cost;
        $item['Unit_price'] = $price;
        $item['fix_price'] = $price_init;

        if ($Product_data->TaxNet !== 0.0) {
            //Exclusive
            if ($Product_data['tax_method'] == '1') {
                $tax_price = $price * $Product_data['TaxNet'] / 100;
                $tax_cost = $cost * $Product_data['TaxNet'] / 100;

                $item['Total_cost'] = $cost + $tax_cost;
                $item['Total_price'] = $price + $tax_price;
                $item['Net_cost'] = $cost;
                $item['Net_price'] = $price;
                $item['tax_price'] = $tax_price;
                $item['tax_cost'] = $tax_cost;

                // Inxclusive
            } else {
                $item['Total_cost'] = $cost;
                $item['Total_price'] = $price;
                $item['Net_cost'] = $cost / (($Product_data['TaxNet'] / 100) + 1);
                $item['Net_price'] = $price / (($Product_data['TaxNet'] / 100) + 1);
                $item['tax_cost'] = $item['Total_cost'] - $item['Net_cost'];
                $item['tax_price'] = $item['Total_price'] - $item['Net_price'];
            }
        } else {
            $item['Total_cost'] = $cost;
            $item['Total_price'] = $price;
            $item['Net_cost'] = $cost;
            $item['Net_price'] = $price;
            $item['tax_price'] = 0;
            $item['tax_cost'] = 0;
        }

        $data[] = $item;

        return response()->json($data[0]);
    }

    public function edit($id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_edit')){
            $Product = Product::where('deleted_at', '=', null)->findOrFail($id);

            $item['id'] = $Product->id;
            $item['type'] = $Product->type;
            $item['code'] = $Product->code;
            $item['Type_barcode'] = $Product->Type_barcode;
            $item['qty_min'] = $Product->qty_min;
            $item['name'] = $Product->name;
            $item['category_id'] = $Product->category_id?$Product->category_id:'';
            $item['brand_id'] = $Product->brand_id?$Product->brand_id:'';
            $item['unit_id'] = $Product->unit_id?$Product->unit_id:'';
            $item['unit_sale_id'] = $Product->unit_sale_id?$Product->unit_sale_id:'';
            $item['unit_purchase_id'] = $Product->unit_purchase_id?$Product->unit_purchase_id:'';

            $item['tax_method'] = $Product->tax_method;
            $item['price'] = $Product->price;
            $item['cost'] = $Product->cost;
            $item['stock_alert'] = $Product->stock_alert;
            $item['TaxNet'] = $Product->TaxNet;
            $item['note'] = $Product->note ? $Product->note : '';
            $item['image'] ="";

            // Handle garment type specific fields
            if ($Product->type == 'stitched_garment') {
                $item['garment_type'] = $Product->garment_type;
                
                if ($Product->garment_type == 'shirt_suit') {
                    // Shirt/Suit measurements
                    $item['shirt_length'] = $Product->shirt_length;
                    $item['shirt_shoulder'] = $Product->shirt_shoulder;
                    $item['shirt_sleeves'] = $Product->shirt_sleeves;
                    $item['shirt_chest'] = $Product->shirt_chest;
                    $item['shirt_upper_waist'] = $Product->shirt_upper_waist;
                    $item['shirt_lower_waist'] = $Product->shirt_lower_waist;
                    $item['shirt_hip'] = $Product->shirt_hip;
                    $item['shirt_neck'] = $Product->shirt_neck;
                    $item['shirt_arms'] = $Product->shirt_arms;
                    $item['shirt_cuff'] = $Product->shirt_cuff;
                    $item['shirt_biceps'] = $Product->shirt_biceps;
                    
                    // Collar types
                    $item['collar_shirt'] = $Product->collar_shirt;
                    $item['collar_sherwani'] = $Product->collar_sherwani;
                    $item['collar_damian'] = $Product->collar_damian;
                    $item['collar_round'] = $Product->collar_round;
                    $item['collar_square'] = $Product->collar_square;
                } elseif ($Product->garment_type == 'pant_shalwar') {
                    // Pant/Shalwar measurements
                    $item['pant_length'] = $Product->pant_length;
                    $item['pant_waist'] = $Product->pant_waist;
                    $item['pant_hip'] = $Product->pant_hip;
                    $item['pant_thai'] = $Product->pant_thai;
                    $item['pant_knee'] = $Product->pant_knee;
                    $item['pant_bottom'] = $Product->pant_bottom;
                    $item['pant_fly'] = $Product->pant_fly;
                }
            } elseif ($Product->type == 'unstitched_garment') {
                $item['thaan_length'] = $Product->thaan_length;
                $item['suit_length'] = $Product->suit_length;
                $item['available_sizes'] = $Product->available_sizes;
            }

            // Get existing multiple images
            $existingImages = DB::table('product_images')
                ->where('product_id', $id)
                ->get(['id', 'image'])
                ->toArray();
            $item['existing_images'] = $existingImages;

            if ($Product->is_promo) {
                $item['is_promo'] = true;
                $item['promo_price'] = $Product->promo_price;
                $item['promo_start_date'] = $Product->promo_start_date;
                $item['promo_end_date'] = $Product->promo_end_date;
            }else{
                $item['is_promo'] = false;
            }
            
            if ($Product->type == 'is_variant') {
                $item['is_variant'] = true;
                $productsVariants = ProductVariant::where('product_id', $id)
                    ->where('deleted_at', null)
                    ->get();

                $var_id = 0;
                foreach ($productsVariants as $variant) {
                    $variant_item['var_id'] = $var_id += 1;
                    $variant_item['id'] = $variant->id;
                    $variant_item['text'] = $variant->name;
                    $variant_item['code'] = $variant->code;
                    $variant_item['price'] = $variant->price;
                    $variant_item['cost'] = $variant->cost;
                    $variant_item['product_id'] = $variant->product_id;
                    $item['ProductVariant'][] = $variant_item;
                }
            } else {
                $item['is_variant'] = false;
                $item['ProductVariant'] = [];
            }

            $item['is_imei'] = $Product->is_imei?true:false;

            $data = $item;
            $categories = Category::where('deleted_at', null)->get(['id', 'name']);
            $brands = Brand::where('deleted_at', null)->get(['id', 'name']);

            $product_units = Unit::where('id', $Product->unit_id)
                                ->orWhere('base_unit', $Product->unit_id)
                                ->where('deleted_at', null)
                                ->get();

            $units = Unit::where('deleted_at', null)
                ->where('base_unit', null)
                ->get();
                
            return view('products.edit_product',[
                'product' => $data,
                'categories' => $categories,
                'brands' => $brands,
                'units' => $units,
                'units_sub' => $product_units,
            ]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function update(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_edit')){
            try {
                // define validation rules for product
                $productRules = [
                    'code' => [
                        'required',
                        Rule::unique('products')->ignore($id)->where(function ($query) {
                            return $query->where('deleted_at', '=', null);
                        }),
                        Rule::unique('product_variants')->ignore($id, 'product_id')->where(function ($query) {
                            return $query->where('deleted_at', '=', null);
                        }),
                    ],
                    'name' => 'required',
                    'multiple_images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
                    'category_id' => 'required',
                    'tax_method' => 'required',
                    'type' => 'required',
                    'unit_id' => Rule::requiredIf($request->type != 'is_service'),
                    'cost' => Rule::requiredIf($request->type == 'is_single'),
                    'price' => Rule::requiredIf($request->type != 'is_variant'),
                ];

                // if type is not is_variant, add validation for variants array
                if ($request->type == 'is_variant') {
                    $productRules['variants'] = [
                        'required',
                        function ($attribute, $value, $fail) use ($request, $id) {
                            // check if array is not empty
                            if (empty($value)) {
                                $fail('The variants array is required.');
                                return;
                            }
                            // check for duplicate codes in variants array
                            $variants = $request->variants;
                           

                            if($variants){
                                foreach ($variants as $variant) {
                                    if (!array_key_exists('text', $variant) || empty($variant['text'])) {
                                        $fail('Variant Name cannot be empty.');
                                        return;
                                    }else if(!array_key_exists('code', $variant) || empty($variant['code'])) {
                                        $fail('Variant code cannot be empty.');
                                        return;
                                    }else if(!array_key_exists('cost', $variant) || empty($variant['cost'])) {
                                        $fail('Variant cost cannot be empty.');
                                        return;
                                    }else if(!array_key_exists('price', $variant) || empty($variant['price'])) {
                                        $fail('Variant price cannot be empty.');
                                        return;
                                    }
                                }
                            }else{
                                $fail('The variants data is invalid.');
                                return;
                            }

                            //check if variant name empty
                            $names = array_column($variants, 'text');
                            if($names){
                                foreach ($names as $name) {
                                    if (empty($name)) {
                                        $fail('Variant Name cannot be empty.');
                                        return;
                                    }
                                }
                            }else{
                                $fail('Variant Name cannot be empty.');
                                return;
                            }

                            //check if variant cost empty
                            $all_cost = array_column($variants, 'cost');
                            if($all_cost){
                                foreach ($all_cost as $cost) {
                                    if (empty($cost)) {
                                        $fail('Variant Cost cannot be empty.');
                                        return;
                                    }
                                }
                            }else{
                                $fail('Variant Cost cannot be empty.');
                                return;
                            }

                            //check if variant price empty
                            $all_price = array_column($variants, 'price');
                            if($all_price){
                                foreach ($all_price as $price) {
                                    if (empty($price)) {
                                        $fail('Variant Price cannot be empty.');
                                        return;
                                    }
                                }
                            }else{
                                $fail('Variant Price cannot be empty.');
                                return;
                            }

                            //check if code empty
                            $codes = array_column($variants, 'code');
                            if($codes){
                                foreach ($codes as $code) {
                                    if (empty($code)) {
                                        $fail('Variant code cannot be empty.');
                                        return;
                                    }
                                }
                            }else{
                                $fail('Variant code cannot be empty.');
                                return;
                            }

                            //check if code Duplicate
                            if (count(array_unique($codes)) !== count($codes)) {
                                $fail('Duplicate codes found in variants array.');
                                return;
                            }

                            // check for duplicate codes in product_variants table
                            $duplicateCodes = DB::table('product_variants')
                                ->where(function ($query) use ($id) {
                                    $query->where('product_id', '<>', $id);
                                })
                                ->whereIn('code', $codes)
                                ->whereNull('deleted_at')
                                ->pluck('code')
                                ->toArray();
                            if (!empty($duplicateCodes)) {
                                $fail('This code : '.implode(', ', $duplicateCodes).' already used');
                            }

                            // check for duplicate codes in products table
                            $duplicateCodes_products = DB::table('products')
                                ->where('id', '!=', $id)
                                ->whereIn('code', $codes)
                                ->whereNull('deleted_at')
                                ->pluck('code')
                                ->toArray();
                            if (!empty($duplicateCodes_products)) {
                                $fail('This code : '.implode(', ', $duplicateCodes_products).' already used');
                            }
                        },
                    ];
                }

                // validate the request data
                $validatedData = $request->validate($productRules, [
                    'code.unique' => 'Product code already used.',
                    'code.required' => 'This field is required',
                ]);

                \DB::transaction(function () use ($request, $id) {
                    $Product = Product::where('id', $id)
                        ->where('deleted_at', '=', null)
                        ->first();

                    //-- Update Product
                    $Product->type = $request['type'];
                    $Product->name = $request['name'];
                    $Product->code = $request['code'];
                    $Product->category_id = $request['category_id'];
                    $Product->brand_id = $request['brand_id']?$request['brand_id']:NULL;
                    $Product->TaxNet = $request['TaxNet'];
                    $Product->tax_method = $request['tax_method'];
                    $Product->note = $request['note'];

                    // Handle garment type specific fields
                    if ($request['type'] == 'stitched_garment') {
                        $Product->garment_type = $request['garment_type'];
                        
                        if ($request['garment_type'] == 'shirt_suit') {
                            // Shirt/Suit measurements
                            $Product->shirt_length = $request['shirt_length'];
                            $Product->shirt_shoulder = $request['shirt_shoulder'];
                            $Product->shirt_sleeves = $request['shirt_sleeves'];
                            $Product->shirt_chest = $request['shirt_chest'];
                            $Product->shirt_upper_waist = $request['shirt_upper_waist'];
                            $Product->shirt_lower_waist = $request['shirt_lower_waist'];
                            $Product->shirt_hip = $request['shirt_hip'];
                            $Product->shirt_neck = $request['shirt_neck'];
                            $Product->shirt_arms = $request['shirt_arms'];
                            $Product->shirt_cuff = $request['shirt_cuff'];
                            $Product->shirt_biceps = $request['shirt_biceps'];
                            
                            // Collar types
                            $Product->collar_shirt = $request['collar_shirt'] ?? false;
                            $Product->collar_sherwani = $request['collar_sherwani'] ?? false;
                            $Product->collar_damian = $request['collar_damian'] ?? false;
                            $Product->collar_round = $request['collar_round'] ?? false;
                            $Product->collar_square = $request['collar_square'] ?? false;
                        } elseif ($request['garment_type'] == 'pant_shalwar') {
                            // Pant/Shalwar measurements
                            $Product->pant_length = $request['pant_length'];
                            $Product->pant_waist = $request['pant_waist'];
                            $Product->pant_hip = $request['pant_hip'];
                            $Product->pant_thai = $request['pant_thai'];
                            $Product->pant_knee = $request['pant_knee'];
                            $Product->pant_bottom = $request['pant_bottom'];
                            $Product->pant_fly = $request['pant_fly'];
                        }
                    } elseif ($request['type'] == 'unstitched_garment') {
                        $Product->thaan_length = 22.5; // Fixed value
                        $Product->suit_length = 4.5;   // Fixed value
                        $Product->available_sizes = $request['available_sizes'] ?? [];
                    }

                    //-- check if type is_single
                    if($request['type'] == 'is_single' || $request['type'] == 'stitched_garment' || $request['type'] == 'unstitched_garment'){
                        $Product->price = $request['price'];
                        $Product->cost = $request['cost'];

                        $Product->unit_id = $request['unit_id'];
                        $Product->unit_sale_id = $request['unit_sale_id'] ? $request['unit_sale_id'] : $request['unit_id'];
                        $Product->unit_purchase_id = $request['unit_purchase_id'] ? $request['unit_purchase_id'] : $request['unit_id'];

                        $Product->stock_alert = $request['stock_alert'] ? $request['stock_alert'] : 0;
                        $Product->qty_min = $request['qty_min'] ? $request['qty_min'] : 0;

                        $manage_stock = 1;

                    //-- check if type is_variant
                    }elseif($request['type'] == 'is_variant'){
                        $Product->price = 0;
                        $Product->cost = 0;

                        $Product->unit_id = $request['unit_id'];
                        $Product->unit_sale_id = $request['unit_sale_id'] ? $request['unit_sale_id'] : $request['unit_id'];
                        $Product->unit_purchase_id = $request['unit_purchase_id'] ? $request['unit_purchase_id'] : $request['unit_id'];

                        $Product->stock_alert = $request['stock_alert'] ? $request['stock_alert'] : 0;
                        $Product->qty_min = $request['qty_min'] ? $request['qty_min'] : 0;

                        $manage_stock = 1;

                    //-- check if type is_service
                    }else{
                        $Product->price = $request['price'];
                        $Product->cost = 0;

                        $Product->unit_id = NULL;
                        $Product->unit_sale_id = NULL;
                        $Product->unit_purchase_id = NULL;

                        $Product->stock_alert = 0;
                        $Product->qty_min = 0;

                        $manage_stock = 0;
                    }
                
                    $Product->is_variant = $request['is_variant'] == 'true' ? 1 : 0;
                    $Product->is_imei = $request['is_imei'] == 'true' ? 1 : 0;
                    $Product->is_promo = $request['is_promo'] == 'true' ? 1 : 0;

                    if ($request['is_promo'] == 'true') {
                        $Product->promo_price = $request['promo_price'];
                        $Product->promo_start_date = $request['promo_start_date'];
                        $Product->promo_end_date = $request['promo_end_date'];
                    }

                    // Handle main image update
                    $currentPhoto = $Product->image;
                    if ($request->image != null) {
                        if ($request->image != $currentPhoto) {
                            $image = $request->file('image');
                            $filename = time().'.'.$image->extension();  
                            $image->move(public_path('/images/products'), $filename);
                            $path = public_path() . '/images/products';

                            $userPhoto = $path . '/' . $currentPhoto;
                            if (file_exists($userPhoto)) {
                                if ($Product->image != 'no_image.png') {
                                    @unlink($userPhoto);
                                }
                            }
                        } else {
                            $filename = $currentPhoto;
                        }
                    }else{
                        $filename = $currentPhoto;
                    }

                    $Product->image = $filename;

                    // Handle multiple images removal
                    if ($request->has('removed_images')) {
                        $removedImages = $request->removed_images;
                        if (!empty($removedImages)) {
                            // Get image filenames before deletion
                            $imagesToDelete = DB::table('product_images')
                                ->whereIn('id', $removedImages)
                                ->pluck('image')
                                ->toArray();
                            
                            // Delete from database
                            DB::table('product_images')->whereIn('id', $removedImages)->delete();
                            
                            // Delete physical files
                            foreach ($imagesToDelete as $imageFile) {
                                $imagePath = public_path('/images/products/multiple/' . $imageFile);
                                if (file_exists($imagePath)) {
                                    @unlink($imagePath);
                                }
                            }
                        }
                    }

                    // Handle new multiple images
                    if ($request->hasFile('multiple_images')) {
                        $productImages = [];
                        foreach ($request->file('multiple_images') as $image) {
                            $filename_multiple = time() . '_' . uniqid() . '.' . $image->extension();
                            $image->move(public_path('/images/products/multiple'), $filename_multiple);
                            $productImages[] = [
                                'product_id' => $Product->id,
                                'image' => $filename_multiple,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ];
                        }
                        DB::table('product_images')->insert($productImages);
                    }

                    // Store Variants Product
                    $oldVariants = ProductVariant::where('product_id', $id)
                        ->where('deleted_at', null)
                        ->get();

                    $warehouses = Warehouse::where('deleted_at', null)
                        ->pluck('id')
                        ->toArray();

                    if ($request['type'] == 'is_variant') {
                        if ($oldVariants->isNotEmpty()) {
                            $new_variants_id = [];
                            $var = 'id';

                            foreach ($request['variants'] as $new_id) {
                                if (array_key_exists($var, $new_id)) {
                                    $new_variants_id[] = $new_id['id'];
                                } else {
                                    $new_variants_id[] = 0;
                                }
                            }

                            foreach ($oldVariants as $key => $value) {
                                $old_variants_id[] = $value->id;

                                // Delete Variant
                                if (!in_array($old_variants_id[$key], $new_variants_id)) {
                                    $ProductVariant = ProductVariant::findOrFail($value->id);
                                    $ProductVariant->deleted_at = Carbon::now();
                                    $ProductVariant->save();

                                    $ProductWarehouse = product_warehouse::where('product_variant_id', $value->id)
                                        ->update(['deleted_at' => Carbon::now()]);
                                }
                            }

                            foreach ($request['variants'] as $key => $variant) {
                                if (array_key_exists($var, $variant)) {
                                    $ProductVariantDT = new ProductVariant;
                                    //-- Field Required
                                    $ProductVariantDT->product_id = $variant['product_id'];
                                    $ProductVariantDT->name = $variant['text'];
                                    $ProductVariantDT->price = $variant['price'];
                                    $ProductVariantDT->cost = $variant['cost'];
                                    $ProductVariantDT->code = $variant['code'];

                                    $ProductVariantUP['product_id'] = $variant['product_id'];
                                    $ProductVariantUP['code'] = $variant['code'];
                                    $ProductVariantUP['name'] = $variant['text'];
                                    $ProductVariantUP['price'] = $variant['price'];
                                    $ProductVariantUP['cost'] = $variant['cost'];

                                } else {
                                    $ProductVariantDT = new ProductVariant;

                                        //-- Field Required
                                        $ProductVariantDT->product_id = $id;
                                        $ProductVariantDT->code = $variant['code'];
                                        $ProductVariantDT->name = $variant['text'];
                                        $ProductVariantDT->price = $variant['price'];
                                        $ProductVariantDT->cost = $variant['cost'];

                                        $ProductVariantUP['product_id'] = $id;
                                        $ProductVariantUP['code'] = $variant['code'];
                                        $ProductVariantUP['name'] = $variant['text'];
                                        $ProductVariantUP['price'] = $variant['price'];
                                        $ProductVariantUP['cost'] = $variant['cost'];
                                        $ProductVariantUP['qty'] = 0.00;
                                }

                                if (!in_array($new_variants_id[$key], $old_variants_id)) {
                                    $ProductVariantDT->save();

                                    //--Store Product warehouse
                                    if ($warehouses) {
                                        $product_warehouse= [];
                                        foreach ($warehouses as $warehouse) {
                                            $product_warehouse[] = [
                                                'product_id' => $id,
                                                'warehouse_id' => $warehouse,
                                                'product_variant_id' => $ProductVariantDT->id,
                                                'manage_stock' => $manage_stock,
                                            ];
                                        }
                                        product_warehouse::insert($product_warehouse);
                                    }
                                } else {
                                    ProductVariant::where('id', $variant['id'])->update($ProductVariantUP);
                                }
                            }
                        } else {
                            $ProducttWarehouse = product_warehouse::where('product_id', $id)
                                ->update(['deleted_at' => Carbon::now()]);

                            foreach ($request['variants'] as $variant) {
                                $product_warehouse_DT = [];
                                $ProductVarDT = new ProductVariant;

                                //-- Field Required
                                $ProductVarDT->product_id = $id;
                                $ProductVarDT->code = $variant['code'];
                                $ProductVarDT->name = $variant['text'];
                                $ProductVarDT->cost = $variant['cost'];
                                $ProductVarDT->price = $variant['price'];
                                $ProductVarDT->save();

                                //-- Store Product warehouse
                                if ($warehouses) {
                                    foreach ($warehouses as $warehouse) {
                                        $product_warehouse_DT[] = [
                                            'product_id' => $id,
                                            'warehouse_id' => $warehouse,
                                            'product_variant_id' => $ProductVarDT->id,
                                            'manage_stock' => $manage_stock,
                                        ];
                                    }
                                    product_warehouse::insert($product_warehouse_DT);
                                }
                            }
                        }
                    } else {
                        if ($oldVariants->isNotEmpty()) {
                            foreach ($oldVariants as $old_var) {
                                $var_old = ProductVariant::where('product_id', $old_var['product_id'])
                                    ->where('deleted_at', null)
                                    ->first();
                                $var_old->deleted_at = Carbon::now();
                                $var_old->save();

                                $ProducttWarehouse = product_warehouse::where('product_variant_id', $old_var['id'])
                                    ->update(['deleted_at' => Carbon::now()]);
                            }

                            if ($warehouses) {
                                foreach ($warehouses as $warehouse) {
                                    $product_warehouse[] = [
                                        'product_id' => $id,
                                        'warehouse_id' => $warehouse,
                                        'product_variant_id' => null,
                                        'manage_stock' => $manage_stock,
                                    ];
                                }
                                product_warehouse::insert($product_warehouse);
                            }
                        }
                    }

                    $Product->save();
                }, 10);

                return response()->json(['success' => true]);
            } catch (ValidationException $e) {
                return response()->json([
                    'status' => 422,
                    'msg' => 'error',
                    'errors' => $e->errors(),
                ], 422);
            }
        }
        return abort('403', __('You are not authorized'));
    }

    public function destroy($id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_delete')){
            \DB::transaction(function () use ($id) {
                $Product = Product::findOrFail($id);
                $Product->deleted_at = Carbon::now();
                $Product->save();

                $path = public_path() . '/images/products';
                $pr_image = $path . '/' . $Product->image;
                if (file_exists($pr_image)) {
                    if ($Product->image != 'no_image.png') {
                        @unlink($pr_image);
                    }
                }

                product_warehouse::where('product_id', $id)->update([
                    'deleted_at' => Carbon::now(),
                ]);

                ProductVariant::where('product_id', $id)->update([
                    'deleted_at' => Carbon::now(),
                ]);

            }, 10);

            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function delete_by_selection(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_delete')){
            \DB::transaction(function () use ($request) {
                $selectedIds = $request->selectedIds;
                foreach ($selectedIds as $product_id) {
                    $Product = Product::findOrFail($product_id);
                    $Product->deleted_at = Carbon::now();
                    $Product->save();

                    $path = public_path() . '/images/products';
                    $pr_image = $path . '/' . $Product->image;
                    if (file_exists($pr_image)) {
                        if ($Product->image != 'no_image.png') {
                            @unlink($pr_image);
                        }
                    }

                    product_warehouse::where('product_id', $product_id)->update([
                        'deleted_at' => Carbon::now(),
                    ]);

                    ProductVariant::where('product_id', $product_id)->update([
                        'deleted_at' => Carbon::now(),
                    ]);
                }
            }, 10);

            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function Products_by_Warehouse(request $request, $id)
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
            })->get();

        foreach ($product_warehouse_data as $product_warehouse) {
            if ($product_warehouse->product_variant_id) {
                $item['product_variant_id'] = $product_warehouse->product_variant_id;
                $item['code'] = $product_warehouse['productVariant']->code;
                $item['Variant'] = '['.$product_warehouse['productVariant']->name . ']' . $product_warehouse['product']->name;
                $item['name'] = '['.$product_warehouse['productVariant']->name . ']' . $product_warehouse['product']->name;
                $item['barcode'] = $product_warehouse['productVariant']->code;
                $product_price = $product_warehouse['productVariant']->price;
            } else {
                $item['product_variant_id'] = null;
                $item['Variant'] = null;
                $item['code'] = $product_warehouse['product']->code;
                $item['name'] = $product_warehouse['product']->name;
                $item['barcode'] = $product_warehouse['product']->code;
                $product_price = $product_warehouse['product']->price;
            }

            $item['id'] = $product_warehouse->product_id;
            $item['product_type'] = $product_warehouse['product']->type;
            $item['qty_min'] = $product_warehouse['product']->qty_min;
            $item['Type_barcode'] = $product_warehouse['product']->Type_barcode;
            $item['image'] = $product_warehouse['product']->image;

            if($product_warehouse['product']['unitSale']){
                if($product_warehouse['product']['unitSale']->operator == '/') {
                    $item['qte_sale'] = $product_warehouse->qte * $product_warehouse['product']['unitSale']->operator_value;
                    $price = $product_price / $product_warehouse['product']['unitSale']->operator_value;
                }else{
                    $item['qte_sale'] = $product_warehouse->qte / $product_warehouse['product']['unitSale']->operator_value;
                    $price = $product_price * $product_warehouse['product']['unitSale']->operator_value;
                }
            }else{
                $item['qte_sale'] = $product_warehouse->qte;
                $price = $product_price;
            }

            if($product_warehouse['product']['unitPurchase']) {
                if($product_warehouse['product']['unitPurchase']->operator == '/') {
                    $item['qte_purchase'] = round($product_warehouse->qte * $product_warehouse['product']['unitPurchase']->operator_value, 5);
                }else{
                    $item['qte_purchase'] = round($product_warehouse->qte / $product_warehouse['product']['unitPurchase']->operator_value, 5);
                }
            }else{
                $item['qte_purchase'] = $product_warehouse->qte;
            }

            $item['manage_stock'] = $product_warehouse->manage_stock;
            $item['qte'] = $product_warehouse->qte;
            $item['unitSale'] = $product_warehouse['product']['unitSale']?$product_warehouse['product']['unitSale']->ShortName:'';
            $item['unitPurchase'] = $product_warehouse['product']['unitPurchase']?$product_warehouse['product']['unitPurchase']->ShortName:'';

            if ($product_warehouse['product']->TaxNet !== 0.0) {
                //Exclusive
                if ($product_warehouse['product']->tax_method == '1') {
                    $tax_price = $price * $product_warehouse['product']->TaxNet / 100;
                    $item['Net_price'] = $price + $tax_price;
                // Inxclusive
                } else {
                    $item['Net_price'] = $price;
                }
            } else {
                $item['Net_price'] = $price;
            }

            $data[] = $item;
        }

        return response()->json($data);
    }

    public function Products_Alert(request $request)
    {
        $product_warehouse_data = product_warehouse::with('warehouse', 'product', 'productVariant')
            ->join('products', 'product_warehouse.product_id', '=', 'products.id')
            ->whereRaw('qte <= stock_alert')
            ->where(function ($query) use ($request) {
                return $query->when($request->filled('warehouse'), function ($query) use ($request) {
                    return $query->where('warehouse_id', $request->warehouse);
                });
            })->where('product_warehouse.deleted_at', null)->get();

        $data = [];

        if ($product_warehouse_data->isNotEmpty()) {
            foreach ($product_warehouse_data as $product_warehouse) {
                if ($product_warehouse->qte <= $product_warehouse['product']->stock_alert) {
                    if ($product_warehouse->product_variant_id) {
                        $item['code'] = $product_warehouse['productVariant']->name . '-' . $product_warehouse['product']->code;
                    } else {
                        $item['code'] = $product_warehouse['product']->code;
                    }
                    $item['quantity'] = $product_warehouse->qte;
                    $item['name'] = $product_warehouse['product']->name;
                    $item['warehouse'] = $product_warehouse['warehouse']->name;
                    $item['stock_alert'] = $product_warehouse['product']->stock_alert;
                    $data[] = $item;
                }
            }
        }

        $perPage = $request->limit; // How many items do you want to display.
        $pageStart = \Request::get('page', 1);
        // Start displaying items from this number;
        $offSet = ($pageStart * $perPage) - $perPage;
        $collection = collect($data);
        // Get only the items you need using array_slice
        $data_collection = $collection->slice($offSet, $perPage)->values();

        $products = new LengthAwarePaginator($data_collection, count($data), $perPage, Paginator::resolveCurrentPage(), array('path' => Paginator::resolveCurrentPath()));
        
        //get warehouses assigned to user
        $user_auth = auth()->user();
        if($user_auth->is_all_warehouses){
            $warehouses = Warehouse::where('deleted_at', '=', null)->get(['id', 'name']);
        }else{
            $warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
            $warehouses = Warehouse::where('deleted_at', '=', null)->whereIn('id', $warehouses_id)->get(['id', 'name']);
        }

        return response()->json([
            'products' => $products,
            'warehouses' => $warehouses,
        ]);
    }

    public function Get_element_barcode(Request $request)
    {
        //get warehouses assigned to user
        $user_auth = auth()->user();
        if($user_auth->is_all_warehouses){
            $warehouses = Warehouse::where('deleted_at', '=', null)->get(['id', 'name']);
        }else{
            $warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
            $warehouses = Warehouse::where('deleted_at', '=', null)->whereIn('id', $warehouses_id)->get(['id', 'name']);
        }
        
        return response()->json(['warehouses' => $warehouses]);
    }

    public function import_products_page()
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_add')){
            return view('products.import_products');
        }
        return abort('403', __('You are not authorized'));
    }

    public function import_products(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_add')){
            //Set maximum php execution time
            ini_set('max_execution_time', 0);

            $request->validate([
                'products' => 'required|mimes:xls,xlsx',
            ]);

            $product_array = Excel::toArray(new ProductImport, $request->file('products'));

            $warehouses = Warehouse::where('deleted_at', null)->pluck('id')->toArray();

            $products = [];
            
            $code_array = [];
            foreach ($product_array[0] as $key => $value) {
                $code_array[] = $value['code'];

                //--Product name
                if($value['name'] != ''){
                    $row['name'] = $value['name'];
                }else{
                    return back()->with('error','Nom du produit n\'existe pas!');
                }

                //--Product code
                if($value['code'] != ''){
                    if (Product::where('code', $value['code'])->where('deleted_at', '=', null)->exists()) {
                        return back()->with('error','Code du produit'.' "'.$value['name'].'" '.'duplicate!');
                    }else{
                        $row['code'] = $value['code'];
                    }
                }else{
                    return back()->with('error','Code du produit'.' "'.$value['name'].'" '.'n\'existe pas!');
                }

                //--Product price
                if($value['price'] != '' && is_numeric($value['price'])){
                    $row['price'] = $value['price'];
                }else{
                    return back()->with('error','Price du produit'.' "'.$value['name'].'" '.'Incorrect or Null!');
                }

                //--Product cost
                if($value['cost'] != '' && is_numeric($value['cost'])){
                    $row['cost'] = $value['cost'];
                }else{
                    return back()->with('error','Cost du produit'.' "'.$value['name'].'" '.'Incorrect or Null!');
                }

                //--Product category_id
                $category = Category::where(['name' => $value['category']])->first();
                if($category){
                    $row['category_id'] = $category->id;
                }else{
                    return back()->with('error','Catégorie du produit'.' "'.$value['name'].'" '.'n\'existe pas!');
                }

                //--Product unit_id
                $unit = Unit::where(['ShortName' => $value['unit']])->orWhere(['name' => $value['unit']])->first();
                if($unit){
                    $row['unit_id'] = $unit->id;
                    $row['unit_sale_id'] = $unit->id;
                    $row['unit_purchase_id'] = $unit->id;
                }else{
                    return back()->with('error','Unit du produit'.' "'.$value['name'].'" '.'n\'existe pas!');
                }

                //--Product brand_id
                if ($value['brand'] != '') {
                    $brand = Brand::where(['name' => $value['brand']])->first();
                    if($brand){
                        $row['brand_id'] = $brand->id;
                    }else{
                        return back()->with('error','Brand du produit'.' "'.$value['name'].'" '.'n\'existe pas!');
                    }
                } else {
                    $row['brand_id'] = NULL;
                }
              
                //--Product qty_min
                if ($value['qty_min_sale'] != '' && is_numeric($value['qty_min_sale'])) {
                    $row['qty_min'] = $value['qty_min_sale'];
                } else {
                    $row['qty_min'] = 0;
                }

                //--Product stock_alert
                if ($value['stock_alert'] != '' && is_numeric($value['stock_alert'])) {
                    $row['stock_alert'] = $value['stock_alert'];
                } else {
                    $row['stock_alert'] = 0;
                }

                //--Product Note
                if ($value['note'] != '') {
                    $row['note'] = $value['note'];
                } else {
                    $row['note'] = NULL;
                }

                $products[]= $row;
            }

            $duplicate = false;

            if(count($product_array[0]) != count(array_unique($code_array))){
                $duplicate = true;
                return back()->with('error','le code produit est dupliqué');
            }

            foreach ($products as $key => $product_value) {
                $Product = new Product;

                $Product->name = $product_value['name'];
                $Product->qty_min = $product_value['qty_min'];
                $Product->code = $product_value['code'];
                $Product->price = $product_value['price'];
                $Product->cost = $product_value['cost'];
                $Product->category_id = $product_value['category_id'];
                $Product->brand_id = $product_value['brand_id'];
                $Product->note = $product_value['note'];
                $Product->unit_id =$product_value['unit_id'];
                $Product->unit_sale_id = $product_value['unit_sale_id'];
                $Product->unit_purchase_id = $product_value['unit_purchase_id'];
                $Product->stock_alert = $product_value['stock_alert'];
                
                //default value
                $Product->type = 'is_single';
                $Product->Type_barcode = 'CODE128';
                $Product->image = 'no_image.png';
                $Product->TaxNet = 0;
                $Product->tax_method = 1;
                $Product->is_variant = 0;
                $Product->is_imei = 0;
                $Product->not_selling = 0;
                $Product->is_active = 1;
                $Product->save();

                if ($warehouses) {
                    foreach ($warehouses as $warehouse) {
                        $product_warehouse[] = [
                            'product_id' => $Product->id,
                            'warehouse_id' => $warehouse,
                        ];
                    }
                }
            }
            
            if ($warehouses) {
                product_warehouse::insert($product_warehouse);
            }

            return redirect()->back()->with('success','Products Imported successfully!');
        }
        return abort('403', __('You are not authorized'));
    }

    public function generate_random_code()
    {
        $gen_code = substr(number_format(time() * mt_rand(), 0, '', ''), 0, 6);

        if (Product::where('code', $gen_code)->exists()) {
            $this->generate_random_code();
        } else {
            return $gen_code;
        }
    }

    public function print_labels()
    {
        $user_auth = auth()->user();
        if ($user_auth->can('print_labels')){
            //get warehouses assigned to user
            if($user_auth->is_all_warehouses){
                $warehouses = Warehouse::where('deleted_at', '=', null)->get(['id', 'name']);
            }else{
                $warehouses_id = UserWarehouse::where('user_id', $user_auth->id)->pluck('warehouse_id')->toArray();
                $warehouses = Warehouse::where('deleted_at', '=', null)->whereIn('id', $warehouses_id)->get(['id', 'name']);
            }

            return view('products.print_labels', compact('warehouses'));
        }
        return abort('403', __('You are not authorized'));
    }

    public function render_price_with_symbol_placement($amount) {
        if ($this->symbol_placement == 'before') {
            return $this->currency . ' ' . $amount;
        } else {
            return $amount . ' ' . $this->currency;
        }
    }

    public function toggleVisibility(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('products_edit')){
            $product = Product::findOrFail($request->product_id);
            $product->is_visible = $request->is_visible;
            $product->save();

            return response()->json(['success' => true, 'message' => __(key: 'Visibility Updated Successfully')]);
        }
        return abort('403', __('You are not authorized'));
    }



}