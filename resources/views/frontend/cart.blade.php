@extends('layouts.frontendlinks')
@section('title', 'Cart')
@section('content')
  <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Cart List</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Cart List</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <div class="ul-cart-container">
            <div class="cart-top">
                <div class="table-responsive">
                    <table class="ul-cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Remove</th>
                            </tr>
                        </thead>

                   <tbody>
@php
    $subtotal = 0;
@endphp

@forelse ($cartItems as $item)
    @php
        $product = $item->product;
        $totalPrice = $item->price * $item->quantity;
        $subtotal += $totalPrice;
    @endphp

    <tr>
        <td>
            <div class="ul-cart-product">
                <a href="#" class="ul-cart-product-img">
                    <img src="{{ asset('images/products/' . $product->image) }}" alt="{{ $product->title }}">
                </a>
                <a href="#" class="ul-cart-product-title">
                    {{ $product->title }}
                </a>
            </div>
        </td>
        <td><span class="ul-cart-item-price">${{ number_format($item->price, 2) }}</span></td>
        <td>
            <div class="ul-product-details-quantity mt-0">
                <form action="#" class="ul-product-quantity-wrapper">
 <input type="number" name="quantities[{{ $item->id }}]" value="{{ $item->quantity }}" min="1" class="ul-product-quantity" readonly>
                    <div class="btns">
                        <button type="button" class="quantityIncreaseButton" data-id="{{ $item->id }}"><i class="flaticon-plus"></i></button>
                        <button type="button" class="quantityDecreaseButton" data-id="{{ $item->id }}"><i class="flaticon-minus-sign"></i></button>
                    </div>
                </form>
            </div>
        </td>
        <td><span class="ul-cart-item-subtotal">${{ number_format($totalPrice, 2) }}</span></td>
        <td>
            <div class="ul-cart-item-remove">
               <form class="removeCartItemForm" data-id="{{ $item->id }}">
    @csrf
    @method('DELETE')
    <button type="submit"><i class="flaticon-close"></i></button>
</form>

            </div>
        </td>
    </tr>
@empty
    <tr><td colspan="5">Your cart is empty.</td></tr>
@endforelse
</tbody>

                    </table>
                </div>

                <div>
                    <div class="ul-cart-actions">
                        <!-- <div class="ul-cart-coupon-code-form-wrapper">
                            <span class="title">Coupon:</span>
                            <form action="cart.html#" class="ul-cart-coupon-code-form">
                                <input name="coupon-code" placeholder="Enter Coupon Code" type="text">
                                <button class="mb-btn">Apply</button>
         

                    </div> -->
                </div>
            </div>

            <div class="cart-bottom">
                <div class="ul-cart-expense-overview">
                    <h3 class="ul-cart-expense-overview-title">Total</h3>
                    <div class="middle">
                        <div class="single-row">
                            <span class="inner-title">Subtotal</span>
                          <span class="number">${{ number_format($subtotal, 2) }}</span> <!-- Subtotal -->
                        </div>

                        <!-- <div class="single-row">
                            <span class="inner-title">Shipping Fee</span>
                            <span class="number">$15.00</span>
                        </div> -->
                    </div>
                    <div class="bottom">
                        <div class="single-row">
                            <span class="inner-title">Total</span>
                        <span class="number">${{ number_format($subtotal, 2) }}</span> <!-- Total -->
                        </div>

        
    <a href="{{ route('checkout.store') }}" class="ul-cart-checkout-direct-btn">CHECKOUT</a>



                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
    // Increase quantity
    $('.quantityIncreaseButton').click(function () {
        let id = $(this).data('id');
        updateQuantity(id, 'increase');
    });

    // Decrease quantity
    $('.quantityDecreaseButton').click(function () {
        let id = $(this).data('id');
        updateQuantity(id, 'decrease');
    });

    function updateQuantity(id, type) {
        $.ajax({
            url: type === 'increase' ? '{{ route('cart.increase') }}' : '{{ route('cart.decrease') }}',
            type: 'POST',
            data: {
                _token: '{{ csrf_token() }}',
                id: id
            },
            success: function (response) {
                location.reload(); // Reload page to reflect price changes (can be made dynamic too)
            },
            error: function (xhr) {
                alert('Something went wrong!');
            }
        });
    }
});
</script>


<script>
$(document).ready(function () {
 
    $('.removeCartItemForm').submit(function (e) {
        e.preventDefault();
        let id = $(this).data('id');
        $.ajax({
            url: '{{ route('cart.remove') }}',
            type: 'DELETE',
            data: {
                _token: '{{ csrf_token() }}',
                id: id
            },
            success: function () {
                location.reload();
            },
            error: function () {
                alert('Failed to remove item.');
            }
        });
    });
});
</script>


@endsection