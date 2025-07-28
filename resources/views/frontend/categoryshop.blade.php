@extends('layouts.frontendlinks')
@section('title', 'Shop')
@section('content')
   <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Shop Left Sidebar</h2>
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
                    <!-- left side bar -->
                    <div class="col-lg-3 col-md-4">
                        <div class="ul-products-sidebar">
                            <!-- single widget / search -->
                            <div class="ul-products-sidebar-widget ul-products-search">
                                <form action="shop.html#" class="ul-products-search-form">
                                    <input type="text" name="product-search" id="ul-products-search-field" placeholder="Search Items">
                                    <button><i class="flaticon-search-interface-symbol"></i></button>
                                </form>
                            </div>

                            <!-- single widget / price filter -->
                            <div class="ul-products-sidebar-widget ul-products-price-filter">
                                <h3 class="ul-products-sidebar-widget-title">Filter by price</h3>
                                <form action="shop.html#" class="ul-products-price-filter-form">
                                    <div id="ul-products-price-filter-slider"></div>
                                    <span class="filtered-price">$19 - $69</span>
                                </form>
                            </div>

                            <!-- single widget / categories -->
                            <!-- <div class="ul-products-sidebar-widget ul-products-categories">
                                <h3 class="ul-products-sidebar-widget-title">Categories</h3>

                                <div class="ul-products-categories-link">
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> Lifestyle</span></a>
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> Beauty &amp; Fashion</span></a>
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> Fitness &amp; Health</span></a>
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> Food &amp; Cooking</span></a>
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> Tech &amp; Gadgets</span></a>
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> Entertainment</span></a>
                                </div>
                            </div> -->

                            <!-- single widget / color filter -->
                            <div class="ul-products-sidebar-widget ul-products-color-filter">
                                <h3 class="ul-products-sidebar-widget-title">Filter By Color</h3>

                                <div class="ul-products-color-filter-colors">
                                    <a href="shop.html" class="black">
                                        <span class="left"><span class="color-prview"></span> Black</span>
                                        <span>14</span>
                                    </a>
                                    <a href="shop.html" class="green">
                                        <span class="left"><span class="color-prview"></span> Green</span>
                                        <span>14</span>
                                    </a>
                                    <a href="shop.html" class="blue">
                                        <span class="left"><span class="color-prview"></span> Blue</span>
                                        <span>14</span>
                                    </a>
                                    <a href="shop.html" class="red">
                                        <span class="left"><span class="color-prview"></span> Red</span>
                                        <span>14</span>
                                    </a>
                                    <a href="shop.html" class="yellow">
                                        <span class="left"><span class="color-prview"></span> Yellow</span>
                                        <span>14</span>
                                    </a>
                                    <a href="shop.html" class="brown">
                                        <span class="left"><span class="color-prview"></span> Brown</span>
                                        <span>14</span>
                                    </a>
                                    <a href="shop.html" class="white">
                                        <span class="left"><span class="color-prview"></span> White</span>
                                        <span>14</span>
                                    </a>
                                </div>
                            </div>

                            <!-- single widget /product status-->
                            <div class="ul-products-sidebar-widget">
                                <h3 class="ul-products-sidebar-widget-title">Product Status</h3>

                                <div class="ul-products-categories-link">
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> In stock</span></a>
                                    <a href="shop.html#"><span><i class="flaticon-arrow-point-to-right"></i> On Sale</span></a>
                                </div>
                            </div>

                            <!-- single widget / size filter -->
                            <div class="ul-products-sidebar-widget">
                                <h3 class="ul-products-sidebar-widget-title">Filter By Sizes</h3>

                                <div class="ul-products-color-filter-colors">
                                    <a href="shop.html"><span class="left">S</span><span>14</span></a>
                                    <a href="shop.html"><span class="left">L</span><span>14</span></a>
                                    <a href="shop.html"><span class="left">M</span><span>14</span></a>
                                    <a href="shop.html"><span class="left">XL</span><span>14</span></a>
                                    <a href="shop.html"><span class="left">XXL</span><span>14</span></a>
                                </div>
                            </div>

                            <!-- single widget / review -->
                            <div class="ul-products-sidebar-widget ul-products-rating-filter">
                                <h3 class="ul-products-sidebar-widget-title">Review Star</h3>

                                <div class="ul-products-rating-filter-ratings">
                                    <!-- single rating filter -->
                                    <div class="single-rating-wrapper">
                                        <label for="ul-products-review-5-star">
                                            <span class="left">
                                                <input type="checkbox" name="jo-checkout-agreement" id="ul-products-review-5-star" hidden>
                                                <span class="stars">
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                </span>
                                            </span>
                                            <span class="right">5 Only</span>
                                        </label>
                                    </div>

                                    <!-- single rating filter -->
                                    <div class="single-rating-wrapper">
                                        <label for="ul-products-review-4-star">
                                            <span class="left">
                                                <input type="checkbox" name="jo-checkout-agreement" id="ul-products-review-4-star" hidden>
                                                <span class="stars">
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                </span>
                                            </span>
                                            <span class="right">4 & up</span>
                                        </label>
                                    </div>

                                    <!-- single rating filter -->
                                    <div class="single-rating-wrapper">
                                        <label for="ul-products-review-3-star">
                                            <span class="left">
                                                <input type="checkbox" name="jo-checkout-agreement" id="ul-products-review-3-star" hidden>
                                                <span class="stars">
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                </span>
                                            </span>
                                            <span class="right">3 & up</span>
                                        </label>
                                    </div>

                                    <!-- single rating filter -->
                                    <div class="single-rating-wrapper">
                                        <label for="ul-products-review-2-star">
                                            <span class="left">
                                                <input type="checkbox" name="jo-checkout-agreement" id="ul-products-review-2-star" hidden>
                                                <span class="stars">
                                                    <span><i class="flaticon-star"></i></span>
                                                    <span><i class="flaticon-star"></i></span>
                                                </span>
                                            </span>
                                            <span class="right">2 & up</span>
                                        </label>
                                    </div>

                                    <!-- single rating filter -->
                                    <div class="single-rating-wrapper">
                                        <label for="ul-products-review-1-star">
                                            <span class="left">
                                                <input type="checkbox" name="jo-checkout-agreement" id="ul-products-review-1-star" hidden>
                                                <span class="stars">
                                                    <span><i class="flaticon-star"></i></span>
                                                </span>
                                            </span>
                                            <span class="right">1 & up</span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- right products container -->
                    <div class="col-lg-9 col-md-8">
                        <div class="row ul-bs-row row-cols-lg-3 row-cols-2 row-cols-xxs-1">
                          

                       @foreach($products as $product)
    <div class="col">
        <div class="ul-product">
            <div class="ul-product-heading">
                <span class="ul-product-price">${{ number_format($product->price, 2) }}</span>
                @if($product->is_promo)
                    <span class="ul-product-discount-tag">
                        {{ number_format(100 - ($product->promo_price / $product->price * 100), 0) }}% Off
                    </span>
                @endif
            </div>

            <div class="ul-product-img">
                <img src="{{ asset('images/products/' . $product->image) }}" alt="{{ $product->name }}">

                <div class="ul-product-actions">
                    <button><i class="flaticon-shopping-bag"></i></button>
                    <a href="#"><i class="flaticon-hide"></i></a>
                    <button><i class="flaticon-heart"></i></button>
                </div>
            </div>

            <div class="ul-product-txt">
                <h4 class="ul-product-title">    <a href="{{ route('shop.details', $product->id) }}">{{ $product->name }}</a></h4>
                <h5 class="ul-product-category"><a href="#">{{ $product->category?->name }}</a></h5>
            </div>
        </div>
    </div>
 

@endforeach



                   

                      

                      


                      

                  

                     

                     

                     


                        
                        </div>
                           <div class="ul-pagination">
    {{ $products->links('pagination::bootstrap-4') }}
</div>

                    </div>
                </div>
            </div>
        </div>
        <!-- MAIN CONTENT SECTION END -->
    </main>
@endsection