<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Cart;
use App\Models\Wishlist;
use Illuminate\Support\Facades\Auth;

class CartController extends Controller
{
   public function add(Request $request)
{
    if (!Auth::check()) {
        return response()->json([
            'success' => false,
            'message' => 'Please login first to add items to cart.'
        ], 401); // 401 Unauthorized
    }

    $request->validate([
        'product_id' => 'required|exists:products,id',
        'quantity' => 'required|integer|min:1',
    ]);

    $product = Product::findOrFail($request->product_id);

    // Check if product already in cart
    $existingCart = Cart::where('user_id', auth()->id())
                        ->where('product_id', $request->product_id)
                        ->first();

    if ($existingCart) {
        $existingCart->quantity += $request->quantity;
        $existingCart->save();
    } else {
        Cart::create([
            'user_id' => auth()->id(),
            'product_id' => $request->product_id,
            'quantity' => $request->quantity,
            'size' => $request->size,
            'color' => $request->color,
            'price' => $product->is_promo ? $product->promo_price : $product->price
        ]);
    }

    return response()->json([
        'success' => true,
        'cart_count' => Cart::where('user_id', auth()->id())->count(),
        'message' => 'Product added to cart successfully'
    ]);
}
    public function index()
{
    $cartItems = Cart::with('product')
                ->where('user_id', auth()->id())
                ->get();

    return view('frontend.cart', compact('cartItems'));
}
public function increaseQuantity(Request $request)
{
    $cart = Cart::findOrFail($request->id);
    $cart->quantity += 1;
    $cart->save();

    return response()->json(['success' => true]);
}

public function decreaseQuantity(Request $request)
{
    $cart = Cart::findOrFail($request->id);
    if ($cart->quantity > 1) {
        $cart->quantity -= 1;
        $cart->save();
    }
    return response()->json(['success' => true]);
}


public function removeItem(Request $request)
{
    $cart = Cart::findOrFail($request->id);
    $cart->delete();

    return response()->json(['success' => true]);
}


public function adminIndex()
{
    // if (!auth()->user()->hasRole(['admin', 'worker'])) {
    //     abort(403);
    // }

    $allCarts = Cart::with(['user', 'product'])->get();
    $grandTotal = $allCarts->sum(function($item) {
        return $item->price * $item->quantity;
    });
    
    return view('orders.carts', compact('allCarts', 'grandTotal'));
}

public function destroy(Cart $cart)
{
    $allowedRoles = [1, 2]; // 1 = admin, 2 = worker

    if (!in_array(auth()->user()->role_users_id, $allowedRoles)) {
        abort(403); // Unauthorized
    }

    $cart->delete();

    return response()->json(['success' => true]);
}


public function addToCart(Request $request)
{
    $request->validate([
        'product_id' => 'required|exists:products,id',
        'quantity' => 'nullable|integer|min:1',
    ]);

    $product = Product::find($request->product_id);

    // Add to cart
    $cart = Cart::updateOrCreate(
        [
            'user_id' => auth()->id(),
            'product_id' => $product->id,
        ],
        [
            'quantity' => $request->quantity ?? 1,
            'size' => $request->size,
            'color' => $request->color,
            'price' => $product->price ?? $product->price,
        ]
    );

    // Remove from wishlist if wishlist_id is passed
    if ($request->wishlist_id) {
        Wishlist::where('id', $request->wishlist_id)->where('user_id', auth()->id())->delete();
    }

    // Count cart items
    $cartCount = Cart::where('user_id', auth()->id())->count();

    return response()->json([
        'success' => true,
        'cart_count' => $cartCount,
        'message' => 'Product added to cart and removed from wishlist.',
    ]);
}


}