@extends('layouts.frontendlinks')
@section('title', 'Shop-no-Sidebar')
@section('content')
  <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Shop Without Sidebar</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Shop</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->

        <!-- MAIN CONTENT SECTION START -->
        <div class="ul-inner-page-container">
            <div class="ul-inner-products-wrapper">
                <div class="row ul-bs-row flex-column-reverse flex-md-row">
                    <!-- right products container -->
                    <div class="col-12">
                        <div class="row ul-bs-row row-cols-lg-4 row-cols-sm-3 row-cols-2 row-cols-xxs-1">
                            <!-- product card -->
   @foreach($products as $product)
    @if($product->type == 'unstitched_garment')
        <div class="col">
            <a style="color:black;" href="{{ route('shop.details', $product->id) }}" class="ul-product d-block text-decoration-none">
                <div class="ul-product-heading">
                    <span class="ul-product-price">${{ $product->price }}</span>
                    @if($product->promo_price)
                        <span class="ul-product-discount-tag">
                            {{ number_format((($product->price - $product->promo_price) / $product->price) * 100, 0) }}% Off
                        </span>
                    @endif
                </div>

                <div class="ul-product-img">
                    <img src="{{ asset('images/products/' . $product->image) }}" alt="Product Image">
                    <div class="ul-product-actions">
                        <button type="button"><i class="flaticon-shopping-bag"></i></button>
                        <span><i class="flaticon-hide"></i></span>
                        <button type="button"><i class="flaticon-heart"></i></button>
                    </div>
                </div>

                <div class="ul-product-txt">
                    <h4 class="ul-product-title">{{ $product->name }}</h4>
                    <h5 class="ul-product-category">{{ $product->category->name ?? 'N/A' }}</h5>
                </div>
            </a>
        </div>
    @endif
@endforeach





                           

                          

                         
                        </div>

                        <!-- pagination -->
                        <!-- <div class="ul-pagination">
                            <ul>
                                <li><a href="shop-no-sidebar.html#"><i class="flaticon-left-arrow"></i></a></li>
                                <li class="pages">
                                    <a href="shop-no-sidebar.html#" class="active">01</a>
                                    <a href="shop-no-sidebar.html#">02</a>
                                    <a href="shop-no-sidebar.html#">03</a>
                                    <a href="shop-no-sidebar.html#">04</a>
                                    <a href="shop-no-sidebar.html#">05</a>
                                </li>
                                <li><a href="shop-no-sidebar.html#"><i class="flaticon-arrow-point-to-right"></i></a></li>
                            </ul>
                        </div> -->
                    </div>
                </div>
            </div>
        </div>
        <!-- MAIN CONTENT SECTION END -->
    </main>
@endsection