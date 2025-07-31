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
public function track($orderId)
{
    $order = Order::with(['items.product'])->where('id', $orderId)->first();
    return view('frontend.ordertracking', compact('order'));
}




public function destroy(Order $order)
{
    $allowedRoles = [1, 2]; // 1 = admin, 2 = worker

    if (!in_array(auth()->user()->role_users_id, $allowedRoles)) {
        abort(403); // Unauthorized
    }

    $order->delete();

    return response()->json(['success' => true]);
}


}
