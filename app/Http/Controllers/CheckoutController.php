<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;

class CheckoutController extends Controller
{

     public function getdata(Request $request)
    {
        // Get current user's cart items
        $cartItems = Cart::with('product')->where('user_id', auth()->id())->get();

        if ($cartItems->isEmpty()) {
            return redirect()->back()->with('error', 'Cart is empty!');
        }

        // You can now pass this to a checkout view or store in session
        return view('frontend.checkout', compact('cartItems'));
    }
   
        public function store(Request $request)
    {
        $request->validate([
            'firstname' => 'required',
            'lastname' => 'required',
            'email' => 'required|email',
            'phone' => 'required',
            'address1' => 'required',
            'city' => 'required',
            'state' => 'required',
            'zipcode' => 'required',
            'country' => 'required',
            'payment-methods' => 'required',
        ]);

        $cartItems = Cart::with('product')->where('user_id', auth()->id())->get();

        if (empty($cartItems)) {
            return redirect()->back()->with('error', 'Your cart is empty.');
        }

        $total = collect($cartItems)->sum(function ($item) {
            return $item['price'] * $item['quantity'];
        });

        $order = Order::create([
            'first_name' => $request->firstname,
            'last_name' => $request->lastname,
            'company_name' => $request->companyname,
            'country' => $request->country,
            'address1' => $request->address1,
            'address2' => $request->address2,
            'city' => $request->city,
            'state' => $request->state,
            'zipcode' => $request->zipcode,
            'phone' => $request->phone,
            'email' => $request->email,
            'different_address' => $request->input('different-address'),
            'payment_method' => $request->input('payment-methods'),
            'total' => $total,
        ]);

        foreach ($cartItems as $item) {
            OrderItem::create([
                'order_id' => $order->id,
                'product_id' => $item['product_id'],
                'quantity' => $item['quantity'],
                'price' => $item['price'],
            ]);
        }

        session()->forget('cart');

       return redirect()->route('thankyou')->with('success', 'Order placed successfully!');

    }
}
