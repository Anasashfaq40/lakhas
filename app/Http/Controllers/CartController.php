<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Cart;

class CartController extends Controller
{
    public function add(Request $request)
    {
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
    if (!auth()->user()->hasRole(['admin', 'worker'])) {
        abort(403);
    }

    $cart->delete();
    return response()->json(['success' => true]);
}

}