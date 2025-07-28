<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Wishlist;
use Illuminate\Support\Facades\Auth;

class WishlistController extends Controller
{
  public function add(Request $request)
{
    if (!Auth::check()) {
        return response()->json([
            'success' => false,
            'message' => 'Please login first to add items to wishlist.'
        ], 401); 
    }

    $request->validate([
        'product_id' => 'required|exists:products,id',
    ]);


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
    $wishlists = Wishlist::with('product') 
                  ->where('user_id', auth()->id())
                  ->get();

    return view('frontend.wishlist', compact('wishlists'));
}

public function destroy($id)
{
    $wishlist = Wishlist::findOrFail($id);
    
    // Get count before deletion for the response
    $wishlistCount = Wishlist::where('user_id', auth()->id())->count();
    
    $wishlist->delete();

    return response()->json([
        'success' => true,
        'message' => 'Item removed from wishlist successfully',
        'wishlist_count' => $wishlistCount - 1 // Updated count after deletion
    ]);
}

}