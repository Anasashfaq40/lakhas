@extends('layouts.frontendlinks')
<!-- Example Bootstrap CDN (for Bootstrap 4) -->

@section('title', 'Track Your Order')

@section('content')


<div class="container py-5">
    <div class="text-center">
        <h1 style="color:#ca9a30;" class="display-4">Track Your Order</h1>

        @if($order)
            <p class="lead mt-3">Order ID: <strong>{{ $order->id }}</strong></p>
            <p><strong>Name:</strong> {{ $order->first_name }} {{ $order->last_name }}</p>
            <p><strong>Email:</strong> {{ $order->email }}</p>
            <p><strong>Phone:</strong> {{ $order->phone }}</p>
          <p><strong>Order Status:</strong>
    @if($order->status === 'pending')
        <span class="badge bg-warning text-dark">Pending</span>
    @elseif($order->status === 'Shipped')
        <span class="badge bg-info text-dark">Shipped</span>
    @elseif($order->status === 'Delivered')
        <span class="badge bg-success">Delivered</span>
    @else
        <span class="badge bg-secondary">{{ $order->status }}</span>
    @endif
</p>


            <p class="mt-3">We’ll notify you as the status updates.</p>
        @else
            <div class="alert alert-danger mt-4">
                Order not found. Please check your order ID or try again later.
            </div>
        @endif

        <a style="background-color:black;" href="/home" class="btn btn-primary mt-4">Back to Home</a>
    </div>
</div>
@endsection
