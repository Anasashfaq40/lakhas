@extends('layouts.frontendlinks')
@section('title', 'Wishlist')
@section('content')
   <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Wishlist</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Wishlist</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <div class="ul-cart-container">
            <div class="cart-top">
                <div class="text-center">
                    <!-- cart header -->
                    <div class="ul-cart-header ul-wishlist-header">
                        <div>Product</div>
                        <div>Price</div>
                        <div>Stock</div>
                        <div>Remove</div>
                    </div>

                    <!-- cart body -->
                    <div>
                        <!-- single wishlist item -->
                    @forelse ($wishlists as $wishlist)
    @if ($wishlist->product)
        <div class="ul-cart-item">
            <!-- product -->
            <div class="ul-cart-product">
                <a href="#" class="ul-cart-product-img">
                    <img src="{{ asset('images/products/' . $wishlist->product->image) }}" alt="{{ $wishlist->product->title }}">
                </a>
                <a href="#" class="ul-cart-product-title">
                    {{ $wishlist->product->title }}
                </a>
            </div>

            <!-- price -->
            <span class="ul-cart-item-price">
                ${{ number_format($wishlist->product->price, 2) }}
            </span>

            <!-- stock -->
            <span class="ul-cart-item-subtotal ul-wislist-item-stock {{ $wishlist->product->stock_alert > 0 ? 'green' : 'red' }}">
                {{ $wishlist->product->stock_alert > 0 ? 'In Stock' : 'Out of Stock' }}
            </span>

            <!-- remove -->
            <div class="ul-cart-item-remove">
                <form action="{{ route('wishlist.remove', $wishlist->id) }}" method="POST">
                    @csrf
                    @method('DELETE')
                    <button><i class="flaticon-close"></i></button>
                </form>
            </div>
        </div>
    @endif
@empty
    <p>Your wishlist is empty.</p>
@endforelse


                    

                     

                   
                    </div>
                </div>
            </div>
        </div>
    </main>
@endsection