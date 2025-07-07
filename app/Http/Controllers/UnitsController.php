<?php

namespace App\Http\Controllers;

use App\Models\Unit;
use App\Models\Product;
use Carbon\Carbon;
use DataTables;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;

class UnitsController extends Controller
{
    public function index(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('unit')) {
            if ($request->ajax()) {
                $data = Unit::where('deleted_at', '=', null)->orderBy('id', 'desc')->get();

                return Datatables::of($data)->addIndexColumn()
                    ->addColumn('base_unit_name', function($row) {
                        return $row->base_unit ? Unit::where('id', $row->base_unit)->first()->name ?? 'N/A' : 'N/A';
                    })
                    ->addColumn('action', function($row) {
                        $btn = '<a id="'.$row->id.'" class="edit cursor-pointer ul-link-action text-success" title="Edit"><i class="i-Edit"></i></a>';
                        $btn .= '&nbsp;&nbsp;<a id="'.$row->id.'" class="delete cursor-pointer ul-link-action text-danger" title="Delete"><i class="i-Close-Window"></i></a>';
                        return $btn;
                    })
                    ->rawColumns(['action'])
                    ->make(true);
            }
            return view('products.units');
        }
        return abort('403', __('You are not authorized'));
    }

    public function create()
    {
        $user_auth = auth()->user();
        if ($user_auth->can('unit')) {
            $units_base = Unit::where('base_unit', null)
                ->where('deleted_at', null)
                ->orderBy('id', 'DESC')
                ->get(['id', 'name']);
                
            return response()->json(['units_base' => $units_base]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function store(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('unit')) {
            $request->validate([
                'name' => 'required|string|max:255',
                'ShortName' => 'nullable|string|max:50',
                'operator_value' => 'required_if:base_unit,!=,null|numeric',
            ]);

            $base_unit = $request->base_unit ?: null;
            $operator = $request->base_unit ? $request->operator : '*';
            $operator_value = $request->base_unit ? $request->operator_value : 1;

            Unit::create([
                'name' => $request->name,
                'ShortName' => $request->ShortName,
                'base_unit' => $base_unit,
                'operator' => $operator,
                'operator_value' => $operator_value,
            ]);

            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function edit($id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('unit')) {
            $unit = Unit::where('deleted_at', '=', null)->findOrFail($id);
            $units_base = Unit::where('id', '!=', $id)
                ->where('base_unit', null)
                ->where('deleted_at', null)
                ->orderBy('id', 'DESC')
                ->get(['id', 'name']);
                
            return response()->json([
                'unit' => $unit,
                'units_base' => $units_base,
            ]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function update(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('unit')) {
            $request->validate([
                'name' => 'required|string|max:255',
                'ShortName' => 'nullable|string|max:50',
                'operator_value' => 'required_if:base_unit,!=,null|numeric',
            ]);

            $base_unit = $request->base_unit ?: null;
            $operator = $request->base_unit ? $request->operator : '*';
            $operator_value = $request->base_unit ? $request->operator_value : 1;

            Unit::whereId($id)->update([
                'name' => $request->name,
                'ShortName' => $request->ShortName,
                'base_unit' => $base_unit,
                'operator' => $operator,
                'operator_value' => $operator_value,
            ]);

            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    public function destroy($id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('unit')) {
            $Sub_Unit_exist = Unit::where('base_unit', $id)->where('deleted_at', null)->exists();
            $Product_exist = Product::where('unit_id', $id)->orWhere('unit_sale_id', $id)->exists();
            
            if (!$Sub_Unit_exist && !$Product_exist) {
                Unit::whereId($id)->update(['deleted_at' => Carbon::now()]);
                return response()->json(['success' => true]);
            } else {
                return response()->json([
                    'success' => false,
                    'message' => __('Unit is linked with products or sub-units and cannot be deleted')
                ]);
            }
        }
        return abort('403', __('You are not authorized'));
    }

    public function Get_Units_SubBase(request $request)
    {
        $units = Unit::where(function ($query) use ($request) {
            return $query->when($request->filled('id'), function ($query) use ($request) {
                return $query->where('id', $request->id)
                    ->orWhere('base_unit', $request->id);
            });
        })->get();

        return response()->json($units);
    }

    public function Get_sales_units(request $request)
    {
        $product_unit_id = Product::with('unit')
            ->where(function ($query) use ($request) {
                return $query->when($request->filled('id'), function ($query) use ($request) {
                    return $query->where('id', $request->id);
                });
            })->first();

        $units = Unit::where('base_unit', $product_unit_id->unit_id)
            ->orWhere('id', $product_unit_id->unit_id)
            ->get();
        
        return response()->json($units);
    }
}