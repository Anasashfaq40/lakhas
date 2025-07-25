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

    // Define columns for filtering
    $columns = [0 => 'name', 1 => 'category_id', 2 => 'brand_id'];
    $param = [0 => 'like', 1 => '=', 2 => '='];

    // Define columns for ordering
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
        
        // Visibility toggle
        $item['visibility'] = '<div class="form-check form-switch">
            <input class="form-check-input toggle-visibility" type="checkbox" id="visibility_' . $product->id . '" 
            ' . ($product->is_visible ? 'checked' : '') . ' data-id="' . $product->id . '">
            </div>';

        // Product image
        $url = url("images/products/" . $product->image);
        $item['image'] = '<div class="avatar mr-2 avatar-md"><img src="' . $url . '" alt=""></div>';

        // Product type
        $item['type'] = $this->getProductTypeText($product->type);
        $item['name'] = $product->name;
        $item['code'] = $product->code;
        $item['category'] = $product->category->name ?? 'N/A';
        $item['brand'] = $product->brand->name ?? 'N/A';

        // Handle different product types
        if ($product->type == 'is_single') {
            $item['cost'] = $this->render_price_with_symbol_placement(number_format($product->cost, 2), $symbol_placement);
            $item['price'] = $this->render_price_with_symbol_placement(number_format($product->price, 2), $symbol_placement);
            $qty = product_warehouse::where('product_id', $product->id)
                ->whereIn('warehouse_id', $array_warehouses_id)
                ->where('deleted_at', '=', null)
                ->sum('qte');
            $item['quantity'] = $qty . ' ' . ($product->unit->ShortName ?? '');

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

                $item['quantity'] .= $qty . ' ' . ($product->unit->ShortName ?? '') . '<br>';
            }

        } elseif (in_array($product->type, ['stitched_garment', 'unstitched_garment'])) {
            // Handle stitched and unstitched garments
            $item['cost'] = $this->render_price_with_symbol_placement(number_format($product->cost, 2), $symbol_placement);
            $item['price'] = $this->render_price_with_symbol_placement(number_format($product->price, 2), $symbol_placement);
            
            $qty = product_warehouse::where('product_id', $product->id)
                ->whereIn('warehouse_id', $array_warehouses_id)
                ->where('deleted_at', '=', null)
                ->sum('qte');
            $item['quantity'] = $qty . ' ' . ($product->unit->ShortName ?? '');

        } else {
            // Handle services or other types
            $item['cost'] = '----';
            $item['quantity'] = '----';
            $item['price'] = $this->render_price_with_symbol_placement(number_format($product->price, 2), $symbol_placement);
        }

        $item['tax'] = $product->TaxNet . '% (' . ($product->tax_method == 1 ? 'Exclusive' : 'Inclusive') . ')';
        $item['unit'] = $product->unit->ShortName ?? 'N/A';
        $item['stock_alert'] = $product->stock_alert;
        $item['note'] = $product->note ?? 'N/A';

        // Garment specific fields
        $item['garment_type'] = $product->type == 'stitched_garment' ? ucfirst(str_replace('_', ' ', $product->garment_type)) : 'N/A';
        $item['measurements'] = $product->type == 'stitched_garment' ? $this->getGarmentMeasurements($product) : 'N/A';
        $item['thaan_length'] = $product->type == 'unstitched_garment' ? $product->thaan_length . ' m' : 'N/A';
        $item['suit_length'] = $product->type == 'unstitched_garment' ? $product->suit_length . ' m' : 'N/A';
        $item['available_sizes'] = $product->type == 'unstitched_garment' 
            ? implode(', ', json_decode($product->available_sizes ?? '[]', true))
            : 'N/A';

        // Action buttons
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
                $item['action'] .= '<a class="dropdown-item" href="'.route('products.view', $product->id).'">
    <i class="nav-icon i-Eye text-info font-weight-bold mr-3"></i>View Product</a>';
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
    if ($product->garment_type == 'shalwar_suit') {
        $measurements = [
            'Kameez' => [
                'Length' => $product->kameez_length,
                'Shoulder' => $product->kameez_shoulder,
                'Sleeves' => $product->kameez_sleeves,
                'Chest' => $product->kameez_chest,
                'Upper Waist' => $product->kameez_upper_waist,
                'Lower Waist' => $product->kameez_lower_waist,
                'Hip' => $product->kameez_hip,
                'Neck' => $product->kameez_neck,
                'Arms' => $product->kameez_arms,
                'Cuff' => $product->kameez_cuff,
                'Biceps' => $product->kameez_biceps
            ],
            'Shalwar' => [
                'Length' => $product->shalwar_length,
                'Waist' => $product->shalwar_waist,
                'Bottom' => $product->shalwar_bottom
            ]
        ];

        $result = [];
        foreach ($measurements as $garment => $values) {
            $garmentMeasurements = array_filter($values, function($value) {
                return $value !== null;
            });
            if (!empty($garmentMeasurements)) {
                $result[] = $garment . ': ' . implode(', ', array_map(
                    function ($k, $v) { return "$k: $v"; },
                    array_keys($garmentMeasurements),
                    $garmentMeasurements
                ));
            }
        }

        return implode(' | ', $result);

    } elseif ($product->garment_type == 'pant_shirt') {
        $measurements = [
            'Shirt' => [
                'Length' => $product->pshirt_length,
                'Shoulder' => $product->pshirt_shoulder,
                'Sleeves' => $product->pshirt_sleeves,
                'Chest' => $product->pshirt_chest,
                'Neck' => $product->pshirt_neck
            ],
            'Pant' => [
                'Length' => $product->pant_length,
                'Waist' => $product->pant_waist,
                'Hip' => $product->pant_hip,
                'Thai' => $product->pant_thai,
                'Knee' => $product->pant_knee,
                'Bottom' => $product->pant_bottom,
                'Fly' => $product->pant_fly
            ]
        ];

        $result = [];
        foreach ($measurements as $garment => $values) {
            $garmentMeasurements = array_filter($values, function($value) {
                return $value !== null;
            });
            if (!empty($garmentMeasurements)) {
                $result[] = $garment . ': ' . implode(', ', array_map(
                    function ($k, $v) { return "$k: $v"; },
                    array_keys($garmentMeasurements),
                    $garmentMeasurements
                ));
            }
        }

        return implode(' | ', $result);
    }
    return 'N/A';
}
 // end stitched and unstiched functionality

   public function create()
{
    $user_auth = auth()->user();
    if ($user_auth->can('products_add')) {
        // 👇 This is the fix: eager load subcategories
        $categories = Category::with('subcategories')
            ->whereNull('deleted_at')
            ->get(['id', 'name']);

        $brands = Brand::whereNull('deleted_at')->get(['id', 'name']);
        $units = Unit::whereNull('deleted_at')->whereNull('base_unit')->get();

        return view('products.create_product', compact('categories','brands','units'));
    }

    return abort('403', __('You are not authorized'));
}


    // Store new product with garment measurements
   public function store(Request $request)
{
    $user_auth = auth()->user();
    if ($user_auth->can('products_add')) {

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
            'name' => 'required',
            'category_id' => 'required',
            'type' => 'required',
            'tax_method' => 'required',
            'unit_id' => 'nullable|exists:units,id',
            'unit_sale_id' => 'nullable|exists:units,id',
            'unit_purchase_id' => 'nullable|exists:units,id',
            'cost' => Rule::requiredIf(in_array($request->type, ['is_single', 'stitched_garment', 'unstitched_garment'])),
            'price' => Rule::requiredIf($request->type != 'is_variant'),
            'multiple_images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ];

        // Additional validation for garment types
        if ($request->type == 'stitched_garment') {
            $productRules['garment_type'] = 'required';
            
            if ($request->garment_type == 'shalwar_suit') {
                $productRules += [
                    'kameez_length' => 'required|numeric',
                    'kameez_sleeves' => 'required|numeric',
                    'shalwar_length' => 'required|numeric',
                    'shalwar_waist' => 'required|numeric',
                ];
            } elseif ($request->garment_type == 'pant_shirt') {
                $productRules += [
                    'pshirt_length' => 'required|numeric',
                    'pshirt_sleeves' => 'required|numeric',
                    'pant_length' => 'required|numeric',
                    'pant_waist' => 'required|numeric',
                ];
            }
        } elseif ($request->type == 'unstitched_garment') {
            $productRules['available_sizes'] = 'required|array|min:1';
        }

        $request->validate($productRules);

        \DB::transaction(function () use ($request) {
            $Product = new Product;
            $Product->type = $request['type'];
            $Product->name = $request['name'];
            $Product->code = $request['code'];
            $Product->category_id = $request['category_id'];
            $Product->sub_category_id = $request['sub_category_id'];
            $Product->brand_id = $request['brand_id'];
            $Product->TaxNet = $request['TaxNet'] ?? 0;
            $Product->tax_method = $request['tax_method'];
            $Product->note = $request['note'];
            $Product->is_imei = 1;

            // Handle garment specific fields
            if ($request['type'] == 'stitched_garment') {
                $Product->garment_type = $request['garment_type'];
                
                if ($request['garment_type'] == 'shalwar_suit') {
                    // Shalwar/Suit measurements
                    $Product->kameez_length = $request['kameez_length'];
                    $Product->kameez_shoulder = $request['kameez_shoulder'];
                    $Product->kameez_sleeves = $request['kameez_sleeves'];
                    $Product->kameez_chest = $request['kameez_chest'];
                    $Product->kameez_upper_waist = $request['kameez_upper_waist'];
                    $Product->kameez_lower_waist = $request['kameez_lower_waist'];
                    $Product->kameez_hip = $request['kameez_hip'];
                    $Product->kameez_neck = $request['kameez_neck'];
                    $Product->kameez_arms = $request['kameez_arms'];
                    $Product->kameez_cuff = $request['kameez_cuff'];
                    $Product->kameez_biceps = $request['kameez_biceps'];
                    
                    // Shalwar measurements
                    $Product->shalwar_length = $request['shalwar_length'];
                    $Product->shalwar_waist = $request['shalwar_waist'];
                    $Product->shalwar_bottom = $request['shalwar_bottom'];
                    
                    // Collar types
                    $Product->collar_shirt = $request['collar_shirt'] ?? 0;
                    $Product->collar_sherwani = $request['collar_sherwani'] ?? 0;
                    $Product->collar_damian = $request['collar_damian'] ?? 0;
                    $Product->collar_round = $request['collar_round'] ?? 0;
                    $Product->collar_square = $request['collar_square'] ?? 0;
                } elseif ($request['garment_type'] == 'pant_shirt') {
                    // Pant/Shirt measurements
                    $Product->pshirt_length = $request['pshirt_length'];
                    $Product->pshirt_shoulder = $request['pshirt_shoulder'];
                    $Product->pshirt_sleeves = $request['pshirt_sleeves'];
                    $Product->pshirt_chest = $request['pshirt_chest'];
                    $Product->pshirt_neck = $request['pshirt_neck'];
                    
                    // Collar types
                    $Product->pshirt_collar_shirt = $request['pshirt_collar_shirt'] ?? 0;
                    $Product->pshirt_collar_round = $request['pshirt_collar_round'] ?? 0;
                    $Product->pshirt_collar_square = $request['pshirt_collar_square'] ?? 0;
                    
                    // Pant measurements
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
                $Product->available_sizes = json_encode($request['available_sizes']);
            }

            // Set pricing and units based on product type
            if (in_array($request['type'], ['is_single', 'stitched_garment', 'unstitched_garment'])) {
                $Product->price = $request['price'];
                $Product->cost = $request['cost'];
                $Product->unit_id = $request['unit_id'];
                $Product->unit_sale_id = $request['unit_sale_id'] ?? $request['unit_id'];
                $Product->unit_purchase_id = $request['unit_purchase_id'] ?? $request['unit_id'];
                $Product->stock_alert = $request['stock_alert'] ?? 0;
                $Product->qty_min = $request['qty_min'] ?? 0;
            } elseif ($request['type'] == 'is_variant') {
                // Handle variant products
                $Product->price = 0;
                $Product->cost = 0;
                $Product->unit_id = $request['unit_id'];
                $Product->unit_sale_id = $request['unit_sale_id'] ?? $request['unit_id'];
                $Product->unit_purchase_id = $request['unit_purchase_id'] ?? $request['unit_id'];
                $Product->stock_alert = $request['stock_alert'] ?? 0;
                $Product->qty_min = $request['qty_min'] ?? 0;
            } else { // is_service
                $Product->price = $request['price'];
                $Product->cost = 0;
                $Product->unit_id = null;
                $Product->unit_sale_id = null;
                $Product->unit_purchase_id = null;
                $Product->stock_alert = 0;
                $Product->qty_min = 0;
            }

            // Handle image upload
            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $filename = time().'.'.$image->extension();  
                $image->move(public_path('/images/products'), $filename);
                $Product->image = $filename;
            } else {
                $Product->image = 'no_image.png';
            }

            $Product->save();

            // Handle multiple images
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

            // Handle product variants if needed
            if ($request['type'] == 'is_variant') {
                $variants = json_decode($request->variants, true);
                $Product_variants_data = [];

                foreach ($variants as $variant) {
                    $Product_variants_data[] = [
                        'product_id' => $Product->id,
                        'name' => $variant['text'],
                        'cost' => $variant['cost'],
                        'price' => $variant['price'],
                        'code' => $variant['code'],
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                }
                ProductVariant::insert($Product_variants_data);
            }

            // Set up product warehouses
            $warehouses = Warehouse::where('deleted_at', null)->pluck('id')->toArray();
            if ($warehouses) {
                $product_warehouse = [];
                
                if ($request['type'] == 'is_variant') {
                    $variants = ProductVariant::where('product_id', $Product->id)->get();
                    foreach ($warehouses as $warehouse) {
                        foreach ($variants as $variant) {
                            $product_warehouse[] = [
                                'product_id' => $Product->id,
                                'warehouse_id' => $warehouse,
                                'product_variant_id' => $variant->id,
                                'manage_stock' => 1,
                                'created_at' => now(),
                                'updated_at' => now(),
                            ];
                        }
                    }
                } else {
                    foreach ($warehouses as $warehouse) {
                        $product_warehouse[] = [
                            'product_id' => $Product->id,
                            'warehouse_id' => $warehouse,
                            'manage_stock' => ($request['type'] != 'is_service') ? 1 : 0,
                            'qte' => $request['stock_alert'] ?? 0,
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }
                product_warehouse::insert($product_warehouse);
            }
        });

        return response()->json(['success' => true, 'message' => 'Product created successfully']);
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
    if ($user_auth->can('products_edit')) {
        $Product = Product::where('deleted_at', '=', null)->findOrFail($id);

        $item['id'] = $Product->id;
        $item['type'] = $Product->type;
        $item['garment_type'] = $Product->garment_type;
        $item['code'] = $Product->code;
        $item['name'] = $Product->name;
        $item['category_id'] = $Product->category_id;
        $item['sub_category_id'] = $Product->sub_category_id;
        $item['brand_id'] = $Product->brand_id;
        $item['unit_id'] = $Product->unit_id;
        $item['unit_sale_id'] = $Product->unit_sale_id;
        $item['unit_purchase_id'] = $Product->unit_purchase_id;
        $item['tax_method'] = $Product->tax_method;
        $item['price'] = $Product->price;
        $item['cost'] = $Product->cost;
        $item['stock_alert'] = $Product->stock_alert;
        $item['TaxNet'] = $Product->TaxNet;
        $item['note'] = $Product->note;
        $item['image'] = $Product->image;

        // Garment measurements
        if ($Product->type == 'stitched_garment') {
            if ($Product->garment_type == 'shalwar_suit') {
                $item['kameez_length'] = $Product->kameez_length;
                $item['kameez_shoulder'] = $Product->kameez_shoulder;
                $item['kameez_sleeves'] = $Product->kameez_sleeves;
                $item['kameez_chest'] = $Product->kameez_chest;
                $item['kameez_upper_waist'] = $Product->kameez_upper_waist;
                $item['kameez_lower_waist'] = $Product->kameez_lower_waist;
                $item['kameez_hip'] = $Product->kameez_hip;
                $item['kameez_neck'] = $Product->kameez_neck;
                $item['kameez_arms'] = $Product->kameez_arms;
                $item['kameez_cuff'] = $Product->kameez_cuff;
                $item['kameez_biceps'] = $Product->kameez_biceps;
                $item['shalwar_length'] = $Product->shalwar_length;
                $item['shalwar_waist'] = $Product->shalwar_waist;
                $item['shalwar_bottom'] = $Product->shalwar_bottom;
                $item['collar_shirt'] = $Product->collar_shirt;
                $item['collar_sherwani'] = $Product->collar_sherwani;
                $item['collar_damian'] = $Product->collar_damian;
                $item['collar_round'] = $Product->collar_round;
                $item['collar_square'] = $Product->collar_square;
            } elseif ($Product->garment_type == 'pant_shirt') {
                $item['pshirt_length'] = $Product->pshirt_length;
                $item['pshirt_shoulder'] = $Product->pshirt_shoulder;
                $item['pshirt_sleeves'] = $Product->pshirt_sleeves;
                $item['pshirt_chest'] = $Product->pshirt_chest;
                $item['pshirt_neck'] = $Product->pshirt_neck;
                $item['pshirt_collar_shirt'] = $Product->pshirt_collar_shirt;
                $item['pshirt_collar_round'] = $Product->pshirt_collar_round;
                $item['pshirt_collar_square'] = $Product->pshirt_collar_square;
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
            $item['available_sizes'] = json_decode($Product->available_sizes, true);
        }

        // Get existing multiple images
     $item['existing_images'] = DB::table('product_images')
    ->where('product_id', $id)
    ->get(['id', 'image'])
    ->toArray();

      $categories = Category::with('subcategories')->where('deleted_at', null)->get();
        $brands = Brand::where('deleted_at', null)->get(['id', 'name']);
        $units = Unit::where('deleted_at', null)->where('base_unit', null)->get();
        $units_sub = Unit::where('base_unit', $Product->unit_id)->where('deleted_at', null)->get();

        // Get variants if product is variant type
        $variants = [];
        if ($Product->type == 'is_variant') {
            $variants = ProductVariant::where('product_id', $id)
                ->where('deleted_at', null)
                ->get();
        }

        return view('products.edit_product', [
            'product' => $item,
            'categories' => $categories,
            //  'subcategories' => $subcategories, // Add this line
            'brands' => $brands,
            'units' => $units,
            'units_sub' => $units_sub,
            'variants' => $variants
        ]);
    }
    return abort('403', __('You are not authorized'));
}
  

public function update(Request $request, $id)
{
    $user_auth = auth()->user();
    if (!$user_auth->can('products_edit')) {
        return abort('403', __('You are not authorized'));
    }

    try {
        // Define validation rules
        $productRules = [
            'code' => [
                'required',
                Rule::unique('products')->ignore($id)->whereNull('deleted_at'),
                Rule::unique('product_variants')->ignore($id, 'product_id')->whereNull('deleted_at'),
            ],
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'tax_method' => 'required|in:1,2',
            'type' => 'required|in:is_single,is_service,stitched_garment,unstitched_garment,is_variant',
            'unit_id' => Rule::requiredIf(function () use ($request) {
                return $request->type != 'is_service';
            }),
            'cost' => [
                Rule::requiredIf(function () use ($request) {
                    return in_array($request->type, ['is_single', 'stitched_garment', 'unstitched_garment']);
                }),
                'numeric', 'min:0'
            ],
            'price' => [
                Rule::requiredIf(function () use ($request) {
                    return $request->type != 'is_variant';
                }),
                'numeric', 'min:0'
            ],
            'multiple_images.*' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ];

        // Garment specific validation
        if ($request->type == 'stitched_garment') {
            $productRules['garment_type'] = 'required|in:shalwar_suit,pant_shirt';
            
            if ($request->garment_type == 'shalwar_suit') {
                $productRules += [
                    'kameez_length' => 'required|numeric|min:0',
                    'kameez_sleeves' => 'required|numeric|min:0',
                    'shalwar_length' => 'required|numeric|min:0',
                    'shalwar_waist' => 'required|numeric|min:0',
                ];
            } elseif ($request->garment_type == 'pant_shirt') {
                $productRules += [
                    'pshirt_length' => 'required|numeric|min:0',
                    'pshirt_sleeves' => 'required|numeric|min:0',
                    'pant_length' => 'required|numeric|min:0',
                    'pant_waist' => 'required|numeric|min:0',
                ];
            }
        } elseif ($request->type == 'unstitched_garment') {
            $productRules['available_sizes'] = 'required|array|min:1';
            $productRules['available_sizes.*'] = 'in:S,M,L,XL';
        }

        // Variant validation
        if ($request->type == 'is_variant') {
            $productRules['variants'] = [
                'required',
                'array',
                'min:1',
                function ($attribute, $value, $fail) use ($id) {
                    $codes = [];
                    foreach ($value as $variant) {
                        if (empty($variant['text'])) {
                            $fail('Variant name cannot be empty.');
                            return;
                        }
                        if (empty($variant['code'])) {
                            $fail('Variant code cannot be empty.');
                            return;
                        }
                        if (empty($variant['cost'])) {
                            $fail('Variant cost cannot be empty.');
                            return;
                        }
                        if (empty($variant['price'])) {
                            $fail('Variant price cannot be empty.');
                            return;
                        }
                        
                        $codes[] = $variant['code'];
                    }

                    if (count($codes) !== count(array_unique($codes))) {
                        $fail('Duplicate variant codes found.');
                        return;
                    }

                    // Check for duplicate codes in database
                    $existingCodes = ProductVariant::where('product_id', '!=', $id)
                        ->whereIn('code', $codes)
                        ->whereNull('deleted_at')
                        ->pluck('code')
                        ->toArray();
                    
                    if (!empty($existingCodes)) {
                        $fail('These codes already exist: ' . implode(', ', $existingCodes));
                    }
                }
            ];
        }

        $validatedData = $request->validate($productRules, [
            'code.unique' => 'This product code is already in use.',
            'variants.required' => 'At least one variant is required for variant products.',
        ]);

        \DB::transaction(function () use ($request, $id) {
            $Product = Product::where('id', $id)->whereNull('deleted_at')->firstOrFail();

            // Update basic product info
            $Product->update([
                'name' => $request->name,
                'code' => $request->code,
                'category_id' => $request->category_id,
                 'sub_category_id' => $request->sub_category_id, 
                'brand_id' => $request->brand_id,
                'TaxNet' => $request->TaxNet ?? 0,
                'tax_method' => $request->tax_method,
                'note' => $request->note,
                'type' => $request->type,
                'is_imei' => $request->is_imei ? 1 : 0,
            ]);

            // Handle different product types
            if (in_array($request->type, ['is_single', 'stitched_garment', 'unstitched_garment'])) {
                $Product->update([
                    'cost' => $request->cost,
                    'price' => $request->price,
                ]);
            } elseif ($request->type == 'is_service') {
                $Product->update([
                    'price' => $request->price,
                    'cost' => 0,
                ]);
            }

            if ($request->type != 'is_service') {
                $Product->update([
                    'unit_id' => $request->unit_id,
                    'unit_sale_id' => $request->unit_sale_id ?? $request->unit_id,
                    'unit_purchase_id' => $request->unit_purchase_id ?? $request->unit_id,
                    'stock_alert' => $request->stock_alert ?? 0,
                    'qty_min' => $request->qty_min ?? 0,
                ]);
            }

            // Handle garment specific fields
            if ($request->type == 'stitched_garment') {
                $garmentData = ['garment_type' => $request->garment_type];
                
                if ($request->garment_type == 'shalwar_suit') {
                    $garmentData += [
                        'kameez_length' => $request->kameez_length,
                        'kameez_shoulder' => $request->kameez_shoulder,
                        'kameez_sleeves' => $request->kameez_sleeves,
                        'kameez_chest' => $request->kameez_chest,
                        'kameez_upper_waist' => $request->kameez_upper_waist,
                        'kameez_lower_waist' => $request->kameez_lower_waist,
                        'kameez_hip' => $request->kameez_hip,
                        'kameez_neck' => $request->kameez_neck,
                        'kameez_arms' => $request->kameez_arms,
                        'kameez_cuff' => $request->kameez_cuff,
                        'kameez_biceps' => $request->kameez_biceps,
                        'shalwar_length' => $request->shalwar_length,
                        'shalwar_waist' => $request->shalwar_waist,
                        'shalwar_bottom' => $request->shalwar_bottom,
                        'collar_shirt' => $request->collar_shirt ? 1 : 0,
                        'collar_sherwani' => $request->collar_sherwani ? 1 : 0,
                        'collar_damian' => $request->collar_damian ? 1 : 0,
                        'collar_round' => $request->collar_round ? 1 : 0,
                        'collar_square' => $request->collar_square ? 1 : 0,
                    ];
                } elseif ($request->garment_type == 'pant_shirt') {
                    $garmentData += [
                        'pshirt_length' => $request->pshirt_length,
                        'pshirt_shoulder' => $request->pshirt_shoulder,
                        'pshirt_sleeves' => $request->pshirt_sleeves,
                        'pshirt_chest' => $request->pshirt_chest,
                        'pshirt_neck' => $request->pshirt_neck,
                        'pant_length' => $request->pant_length,
                        'pant_waist' => $request->pant_waist,
                        'pant_hip' => $request->pant_hip,
                        'pant_thai' => $request->pant_thai,
                        'pant_knee' => $request->pant_knee,
                        'pant_bottom' => $request->pant_bottom,
                        'pant_fly' => $request->pant_fly,
                        'pshirt_collar_shirt' => $request->pshirt_collar_shirt ? 1 : 0,
                        'pshirt_collar_round' => $request->pshirt_collar_round ? 1 : 0,
                        'pshirt_collar_square' => $request->pshirt_collar_square ? 1 : 0,
                    ];
                }
                
                $Product->update($garmentData);
            } elseif ($request->type == 'unstitched_garment') {
                $Product->update([
                    'thaan_length' => 22.5,
                    'suit_length' => 4.5,
                    'available_sizes' => json_encode($request->available_sizes),
                ]);
            }

            // Handle image upload
            if ($request->hasFile('image')) {
                // Delete old image if exists
                if ($Product->image && $Product->image != 'no_image.png') {
                    $oldImagePath = public_path('images/products/' . $Product->image);
                    if (file_exists($oldImagePath)) {
                        unlink($oldImagePath);
                    }
                }

                $image = $request->file('image');
                $filename = time() . '.' . $image->extension();
                $image->move(public_path('images/products'), $filename);
                $Product->update(['image' => $filename]);
            }

            // Handle multiple images
            if ($request->has('removed_images')) {
                $removedImages = json_decode($request->removed_images, true);
                if (!empty($removedImages)) {
                    $imagesToDelete = DB::table('product_images')
                        ->whereIn('id', $removedImages)
                        ->where('product_id', $id)
                        ->pluck('image')
                        ->toArray();

                    DB::table('product_images')
                        ->whereIn('id', $removedImages)
                        ->where('product_id', $id)
                        ->delete();

                    foreach ($imagesToDelete as $image) {
                        $path = public_path('images/products/multiple/' . $image);
                        if (file_exists($path)) {
                            unlink($path);
                        }
                    }
                }
            }

            if ($request->hasFile('multiple_images')) {
                $productImages = [];
                foreach ($request->file('multiple_images') as $image) {
                    $filename = time() . '_' . uniqid() . '.' . $image->extension();
                    $image->move(public_path('images/products/multiple'), $filename);
                    $productImages[] = [
                        'product_id' => $Product->id,
                        'image' => $filename,
                        'created_at' => now(),
                        'updated_at' => now(),
                    ];
                }
                DB::table('product_images')->insert($productImages);
            }

            // Handle variants
            if ($request->type == 'is_variant') {
                $oldVariants = ProductVariant::where('product_id', $id)
                    ->whereNull('deleted_at')
                    ->get();

                $warehouses = Warehouse::whereNull('deleted_at')
                    ->pluck('id')
                    ->toArray();

                $newVariants = collect($request->variants);
                $newVariantIds = $newVariants->pluck('id')->filter()->toArray();

                // Delete removed variants
                $oldVariants->each(function ($variant) use ($newVariantIds) {
                    if (!in_array($variant->id, $newVariantIds)) {
                        $variant->update(['deleted_at' => now()]);
                        product_warehouse::where('product_variant_id', $variant->id)
                            ->update(['deleted_at' => now()]);
                    }
                });

                // Update or create variants
                foreach ($request->variants as $variant) {
                    $variantData = [
                        'product_id' => $id,
                        'code' => $variant['code'],
                        'name' => $variant['text'],
                        'cost' => $variant['cost'],
                        'price' => $variant['price'],
                    ];

                    if (!empty($variant['id'])) {
                        // Update existing variant
                        ProductVariant::where('id', $variant['id'])
                            ->update($variantData);
                    } else {
                        // Create new variant
                        $newVariant = ProductVariant::create($variantData);

                        // Create warehouse records for new variant
                        if (!empty($warehouses)) {
                            $warehouseData = array_map(function ($warehouse) use ($newVariant) {
                                return [
                                    'product_id' => $newVariant->product_id,
                                    'warehouse_id' => $warehouse,
                                    'product_variant_id' => $newVariant->id,
                                    'manage_stock' => 1,
                                    'created_at' => now(),
                                    'updated_at' => now(),
                                ];
                            }, $warehouses);

                            product_warehouse::insert($warehouseData);
                        }
                    }
                }
            } else {
                // Delete all variants if product is no longer a variant
                ProductVariant::where('product_id', $id)
                    ->whereNull('deleted_at')
                    ->update(['deleted_at' => now()]);
            }
        });

        return response()->json(['success' => true]);
    } catch (ValidationException $e) {
        return response()->json([
            'status' => 422,
            'msg' => 'error',
            'errors' => $e->errors(),
        ], 422);
    } catch (\Exception $e) {
        return response()->json([
            'status' => 500,
            'msg' => 'error',
            'error' => $e->getMessage(),
        ], 500);
    }
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

    public function Products_by_Warehouse(Request $request, $id)
{
    try {
        $data = [];
        $product_warehouse_data = product_warehouse::with('warehouse', 'product.unitSale', 'product.unitPurchase', 'productVariant')
            ->where('warehouse_id', $id)
            ->where('deleted_at', '=', null)
            ->where(function ($query) use ($request) {
                if ($request->stock == '1' && $request->product_service == '1') {
                    return $query->where('qte', '>', 0)->orWhere('manage_stock', false);
                } elseif ($request->stock == '1' && $request->product_service == '0') {
                    return $query->where('qte', '>', 0)->orWhere('manage_stock', true);
                } else {
                    return $query->where('manage_stock', true);
                }
            })->get();

        foreach ($product_warehouse_data as $product_warehouse) {
            $item = [];

            $product = $product_warehouse->product;
            $variant = $product_warehouse->productVariant;
            $unitSale = $product->unitSale ?? null;
            $unitPurchase = $product->unitPurchase ?? null;

            if ($variant) {
                $item['product_variant_id'] = $product_warehouse->product_variant_id;
                $item['code'] = $variant->code ?? '';
                $item['Variant'] = '[' . ($variant->name ?? '') . '] ' . ($product->name ?? '');
                $item['name'] = '[' . ($variant->name ?? '') . '] ' . ($product->name ?? '');
                $item['barcode'] = $variant->code ?? '';
                $product_price = $variant->price ?? 0;
            } else {
                $item['product_variant_id'] = null;
                $item['Variant'] = null;
                $item['code'] = $product->code ?? '';
                $item['name'] = $product->name ?? '';
                $item['barcode'] = $product->code ?? '';
                $product_price = $product->price ?? 0;
            }

            $item['id'] = $product_warehouse->product_id;
            $item['product_type'] = $product->type ?? '';
            $item['qty_min'] = $product->qty_min ?? 0;
            $item['Type_barcode'] = $product->Type_barcode ?? '';
            $item['image'] = $product->image ?? '';

            // Sale Quantity Calculation
            if ($unitSale) {
                if ($unitSale->operator == '/') {
                    $item['qte_sale'] = $product_warehouse->qte * $unitSale->operator_value;
                    $price = $product_price / $unitSale->operator_value;
                } else {
                    $item['qte_sale'] = $product_warehouse->qte / $unitSale->operator_value;
                    $price = $product_price * $unitSale->operator_value;
                }
            } else {
                $item['qte_sale'] = $product_warehouse->qte;
                $price = $product_price;
            }

            // Purchase Quantity Calculation
            if ($unitPurchase) {
                if ($unitPurchase->operator == '/') {
                    $item['qte_purchase'] = round($product_warehouse->qte * $unitPurchase->operator_value, 5);
                } else {
                    $item['qte_purchase'] = round($product_warehouse->qte / $unitPurchase->operator_value, 5);
                }
            } else {
                $item['qte_purchase'] = $product_warehouse->qte;
            }

            $item['manage_stock'] = $product_warehouse->manage_stock;
            $item['qte'] = $product_warehouse->qte;
            $item['unitSale'] = $unitSale->ShortName ?? '';
            $item['unitPurchase'] = $unitPurchase->ShortName ?? '';

            // Tax Calculation
            if (!empty($product->TaxNet) && $product->TaxNet != 0.0) {
                if ($product->tax_method == '1') {
                    $tax_price = $price * $product->TaxNet / 100;
                    $item['Net_price'] = $price + $tax_price;
                } else {
                    $item['Net_price'] = $price;
                }
            } else {
                $item['Net_price'] = $price;
            }

            $data[] = $item;
        }

        return response()->json($data);

    } catch (\Exception $e) {
        \Log::error('Warehouse Product Fetch Error: ' . $e->getMessage());
        return response()->json([
            'error' => 'Internal Server Error',
            'message' => $e->getMessage()
        ], 500);
    }
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
public function showdetail($id)
{
    $user_auth = auth()->user();
    if ($user_auth->can('products_view')){
        $product = Product::with([
            'category', 
            'brand', 
            'unit',
            'variants',
            'images'
        ])->findOrFail($id);
        
        return view('products.view_product', compact('product'));
    }
    return abort('403', __('You are not authorized'));
}

public function showProducts()
{
   $products = Product::latest()->get(); 
    return view('frontend.home', compact('products'));
}

public function showdetails($id)
{
    $product = Product::with(['category', 'brand', 'images'])->findOrFail($id);

    return view('frontend.shop-details', compact('product'));
}




}