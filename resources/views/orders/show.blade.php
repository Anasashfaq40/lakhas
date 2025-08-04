<!-- views/admin/orders/show.blade.php -->
@extends('layouts.master')
@section('main-content')
<div class="breadcrumb">
  <h1>Order #{{ $order->id }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row">
  <div class="col-md-6">
    <div class="card mb-4">
      <div class="card-body">
        <h4 class="card-title">Customer Information</h4>
        <p><strong>Name:</strong> {{ $order->first_name }} {{ $order->last_name }}</p>
        <p><strong>Email:</strong> {{ $order->email }}</p>
        <p><strong>Phone:</strong> {{ $order->phone }}</p>
        <p><strong>Company:</strong> {{ $order->company_name ?? 'N/A' }}</p>
   <p><strong>Order Status:</strong>
  @if($order->status === 'pending')
    <span class="badge badge-warning">Pending</span>
    <form action="{{ route('admin.orders.updateStatus', [$order->id, 'Shipped']) }}" method="POST" class="mt-2">
      @csrf
      @method('PUT')
      <button type="submit" class="btn btn-primary btn-sm">Mark as Shipped</button>
    </form>
  @elseif($order->status === 'Shipped')
    <span class="badge badge-info">Shipped</span>
    <form action="{{ route('admin.orders.updateStatus', [$order->id, 'Delivered']) }}" method="POST" class="mt-2">
      @csrf
      @method('PUT')
      <button type="submit" class="btn btn-success btn-sm">Mark as Delivered</button>
    </form>
  @elseif($order->status === 'Delivered')
    <span class="badge badge-success">Delivered</span>
  @endif
</p>


        
      </div>
    </div>
    
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Shipping Address</h4>
        <p>{{ $order->address1 }}</p>
        @if($order->address2)
        <p>{{ $order->address2 }}</p>
        @endif
        <p>{{ $order->city }}, {{ $order->state }} {{ $order->zipcode }}</p>
        <p>{{ $order->country }}</p>
      </div>
    </div>
  </div>
  
  <div class="col-md-6">
    <div class="card mb-4">
      <div class="card-body">
        <h4 class="card-title">Order Details</h4>
        <p><strong>Order Date:</strong> {{ $order->created_at->format('F j, Y') }}</p>
        <p><strong>Payment Method:</strong> {{ $order->payment_method }}</p>
        <p><strong>Order Status:</strong> <span class="badge badge-primary">{{$order->status}}</span></p>
      </div>
    </div>
    
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Order Items</h4>
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
                <th>Product</th>
                <th>Price</th>
                <th>Qty</th>
                <th>Total</th>
              </tr>
            </thead>
            <tbody>
              @foreach($order->items as $item)
              <tr>
                <td>
                  <div class="d-flex align-items-center">
                    <img src="{{ asset('images/products/'.$item->product->image) }}" class="img-thumbnail me-2" width="60" alt="">
                    <span>{{ $item->product->name }}</span>
                  </div>
                </td>
                <td>{{ $item->price }}</td>
                <td>{{ $item->quantity }}</td>
                <td>{{ $item->price * $item->quantity }}</td>
              </tr>
              @endforeach
            </tbody>
            <tfoot>
              <tr>
                <td colspan="3" class="text-end"><strong>Subtotal:</strong></td>
                <td>{{ $order->total }}</td>
              </tr>
              <tr>
                <td colspan="3" class="text-end"><strong>Shipping:</strong></td>
                <td>{{ 0 }}</td>
              </tr>
              <tr>
                <td colspan="3" class="text-end"><strong>Total:</strong></td>
                <td>{{ $order->total }}</td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection