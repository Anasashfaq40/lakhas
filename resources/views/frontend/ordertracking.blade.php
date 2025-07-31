@extends('layouts.frontendlinks')

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

            <hr>

            <h4>Order Items:</h4>
            <div class="table-responsive">
                <table class="table table-bordered mt-3">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Quantity</th>
                            <th>Price (Each)</th>
                            <th>Total</th>
                            @if($order->status === 'Delivered')
                                <th>Review</th>
                            @endif
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($order->items as $item)
                            <tr>
                                <td>{{ $item->product->name ?? 'Product Deleted' }}</td>
                                <td>{{ $item->quantity }}</td>
                                <td>Rs{{ number_format($item->price, 2) }}</td>
                                <td>Rs{{ number_format($item->price * $item->quantity, 2) }}</td>
                                @if($order->status === 'Delivered')
                                    <td>
                                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#reviewModal{{ $item->id }}">
                                            Review
                                        </button>

                                        <!-- Review Modal -->
                                        <div class="modal fade" id="reviewModal{{ $item->id }}" tabindex="-1" aria-labelledby="reviewModalLabel" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content text-start">
                                                    <form method="POST" action="{{ route('review.store') }}">
                                                        @csrf
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="reviewModalLabel">Leave a Review</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <input type="hidden" name="product_id" value="{{ $item->product->id }}">
                                                            <input type="hidden" name="user_id" value="{{ auth()->id() }}">
                                                            <div class="mb-3">
                                                                <label for="rating" class="form-label">Rating</label>
                                                                <select class="form-control" name="rating" required>
                                                                    <option value="5">5 - Excellent</option>
                                                                    <option value="4">4 - Good</option>
                                                                    <option value="3">3 - Average</option>
                                                                    <option value="2">2 - Poor</option>
                                                                    <option value="1">1 - Bad</option>
                                                                </select>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label for="comment" class="form-label">Comment</label>
                                                                <textarea name="comment" class="form-control" required></textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="submit" class="btn btn-success">Submit Review</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- End Modal -->
                                    </td>
                                @endif
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>

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
