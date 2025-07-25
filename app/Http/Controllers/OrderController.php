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
}
