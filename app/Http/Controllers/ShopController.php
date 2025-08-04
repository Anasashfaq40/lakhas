<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\Review;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ShopController extends Controller
{
    public function index(Request $request)
    {
        // Start base query
        $query = Product::where('is_visible', true)
                        ->where('is_active', true);

        // Search by name
        if ($request->filled('search')) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        // Price filtering
        if ($request->filled('min_price')) {
            $query->where('price', '>=', $request->min_price);
        }
        if ($request->filled('max_price')) {
            $query->where('price', '<=', $request->max_price);
        }

        // Stock status based on stock_alert
        if ($request->status == 'stock') {
            $query->where('stock_alert', '>', 0);
        }

        // Promo/sale
        if ($request->status == 'sale') {
            $query->where('is_promo', true);
        }

        // Size filtering — if sizes are comma separated
        if ($request->filled('size')) {
            $query->where('available_sizes', 'like', '%' . $request->size . '%');
        }

        // Rating: filter products with average review >= requested rating
        if ($request->filled('rating')) {
            $productIds = Review::select('product_id', DB::raw('AVG(rating) as avg_rating'))
                ->groupBy('product_id')
                ->havingRaw('AVG(rating) >= ?', [$request->rating])
                ->pluck('product_id');

            $query->whereIn('id', $productIds);
        }

        // Paginate with query preserved
        $products = $query->latest()->paginate(9)->appends($request->query());

        return view('frontend.shop', compact('products'));
    }
}
