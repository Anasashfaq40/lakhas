<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Wishlist;

class WishlistController extends Controller
{
    public function add(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
        ]);

        // Check if product already in wishlist
        $existingWishlist = Wishlist::where('user_id', auth()->id())
                                  ->where('product_id', $request->product_id)
                                  ->first();

        if (!$existingWishlist) {
            Wishlist::create([
                'user_id' => auth()->id(),
                'product_id' => $request->product_id
            ]);
        }

        return response()->json([
            'success' => true,
            'wishlist_count' => Wishlist::where('user_id', auth()->id())->count(),
            'message' => 'Product added to wishlist successfully'
        ]);
    }

    public function index()
{
    $wishlists = Wishlist::with('product') // eager load product
                  ->where('user_id', auth()->id())
                  ->get();

    return view('frontend.wishlist', compact('wishlists'));
}
}