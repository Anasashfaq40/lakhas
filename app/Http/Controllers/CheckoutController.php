<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Unit;
use App\Models\product_warehouse;
use App\Mail\OrderPlacedMail;
use App\Mail\OrderStatusUpdatedMail;
use Illuminate\Support\Facades\Mail;



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
   
//  public function store(Request $request)
// {
//     $request->validate([
//         'firstname' => 'required',
//         'lastname' => 'required',
//         'email' => 'required|email',
//         'phone' => 'required',
//         'address1' => 'required',
//         'city' => 'required',
//         'state' => 'required',
//         'zipcode' => 'required',
//         'country' => 'required',
//         'payment-methods' => 'required',
//     ]);

//     $cartItems = Cart::with('product')->where('user_id', auth()->id())->get();

//     if ($cartItems->isEmpty()) {
//         return redirect()->back()->with('error', 'Your cart is empty.');
//     }

//     $total = $cartItems->sum(function ($item) {
//         return $item->price * $item->quantity;
//     });

//     $order = Order::create([
//         'first_name' => $request->firstname,
//         'last_name' => $request->lastname,
//         'company_name' => $request->companyname,
//         'country' => $request->country,
//         'address1' => $request->address1,
//         'address2' => $request->address2,
//         'city' => $request->city,
//         'state' => $request->state,
//         'zipcode' => $request->zipcode,
//         'phone' => $request->phone,
//         'email' => $request->email,
//         'different_address' => $request->input('different-address'),
//         'payment_method' => $request->input('payment-methods'),
//         'total' => $total,
//         'status' => 'pending',
//     ]);

//     foreach ($cartItems as $item) {
//         OrderItem::create([
//             'order_id' => $order->id,
//             'product_id' => $item->product_id,
//             'quantity' => $item->quantity,
//             'price' => $item->price,
//             'user_id'    => auth()->id(),
//         ]);
//     }

//  Cart::where('user_id', auth()->id())->delete();
//     session(['order_id' => $order->id]);


//     Mail::to($order->email)->send(new OrderPlacedMail($order));

//     return redirect()->route('thankyou')->with('success', 'Order placed successfully!');
// }

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

    if ($cartItems->isEmpty()) {
        return redirect()->back()->with('error', 'Your cart is empty.');
    }

    $total = $cartItems->sum(function ($item) {
        return $item->price * $item->quantity;
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
        'status' => 'pending',
    ]);

    foreach ($cartItems as $item) {
        $product = $item->product;

        // 🟡 Unit conversion
        $convertedQty = $item->quantity;
        if ($product->unit_sale_id && $product->unit_id && $product->unit_sale_id != $product->unit_id) {
            $unit = Unit::find($product->unit_sale_id);
            if ($unit) {
                $convertedQty = $unit->operator === '*'
                    ? $item->quantity * $unit->operator_value
                    : $item->quantity / $unit->operator_value;
            }
        }

        // Save order item
        OrderItem::create([
            'order_id' => $order->id,
            'product_id' => $item->product_id,
            'quantity' => $item->quantity,
            'price' => $item->price,
            'user_id' => auth()->id(),
        ]);

        // ✅ Stock Update with unit-based quantity
        $productWarehouse = product_warehouse::where('deleted_at', null)
            ->where('product_id', $item->product_id)
            ->first();

        if ($productWarehouse && $productWarehouse->qte >= $convertedQty) {
            $productWarehouse->qte -= $convertedQty;
            $productWarehouse->save();
        } else {
            // Rollback order if not enough stock
            $order->delete();
            return redirect()->back()->with('error', 'Not enough stock for ' . $product->name);
        }
    }

    Cart::where('user_id', auth()->id())->delete();
    session(['order_id' => $order->id]);

    Mail::to($order->email)->send(new OrderPlacedMail($order));

    return redirect()->route('thankyou')->with('success', 'Order placed successfully!');
}


public function updateStatus($id, $status)
{
    $validStatuses = ['Shipped', 'Delivered'];

    if (!in_array($status, $validStatuses)) {
        return redirect()->back()->with('error', 'Invalid status.');
    }

    $order = Order::findOrFail($id);
    $order->status = $status;
    $order->save();

    // Send status updated email
    Mail::to($order->email)->send(new OrderStatusUpdatedMail($order));

    return redirect()->back()->with('success', "Order marked as {$status}.");
}



}
