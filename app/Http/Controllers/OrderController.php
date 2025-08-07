<?php

namespace App\Http\Controllers;
use App\Models\Order;
use App\Models\OrderItem;

use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function index()
{
    $orders = Order::with(['items', 'items.product'])
                ->orderBy('created_at', 'desc')
                ->get();
                
    return view('orders.orders', compact('orders'));
}

public function show(Order $order)
{
    $order->load(['items', 'items.product']);
    return view('orders.show', compact('order'));
}
// public function track($orderId)
// {
//     $order = Order::with(['items.product'])->where('id', $orderId)->first();
//     return view('frontend.ordertracking', compact('order'));
// }
public function track($id = null)
{
    if (!auth()->check()) {
        return redirect()->route('login')->with('error', 'Please login to view your orders');
    }

    $orders = Order::with(['items.product', 'items.review'])
        ->whereHas('items', function ($query) {
            $query->where('user_id', auth()->id());
        })
        ->orderBy('created_at', 'desc')
        ->get();

    return view('frontend.ordertracking', compact('orders'));
}







public function destroy(Order $order)
{
    $allowedRoles = [1, 2];

    if (!in_array(auth()->user()->role_users_id, $allowedRoles)) {
        abort(403); // Unauthorized
    }

    $order->delete();

    return response()->json(['success' => true]);
}


}
