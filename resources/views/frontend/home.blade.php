
@extends('layouts.frontendlinks')
@section('title', 'Home')
@section('content')
 <main>
        <!-- BANNER SECTION START -->
        <div class="overflow-hidden">
            <div class="ul-container">
                <section class="ul-banner">
                    <div class="ul-banner-slider-wrapper">
                        <div class="ul-banner-slider swiper">
                            <div class="swiper-wrapper">
                                <!-- single slide -->
                                <div class="swiper-slide ul-banner-slide">
                                    <div class="ul-banner-slide-img">
                                        <img src="assets/img/delivery/banner3.jpg" alt="Banner Image">
                                    </div>
                                    <div class="ul-banner-slide-txt">
                                        <span class="ul-banner-slide-sub-title">From Fabric to Finish</span>
                                        <h1 class="ul-banner-slide-title">Expert Tailoring Flawless Fit Timeless Style..</h1>
                                        <p class="ul-banner-slide-price">Starting From <span class="price">3,200</span></p>
                                        <a href="shop.html" class="ul-btn">VIEW COLLECTION <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div>

                                <!-- single slide -->
                                <div class="swiper-slide ul-banner-slide ul-banner-slide--2">
                                    <div class="ul-banner-slide-img">
                                        <img src="assets/img/delivery/banner2.jpg" alt="Banner Image">
                                    </div>
                                    <div class="ul-banner-slide-txt">
                                        <span class="ul-banner-slide-sub-title">Define Your Presence</span>
                                        <h1 class="ul-banner-slide-title">Suits That Demand Respect</h1>
                                        <p class="ul-banner-slide-price">Starting From <span class="price">8,900</span></p>
                                        <a href="shop.html" class="ul-btn">VIEW COLLECTION <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div>

                                <!-- single slide -->
                                <div class="swiper-slide ul-banner-slide ul-banner-slide--3">
                                    <div class="ul-banner-slide-img">
                                        <img src="assets/img/delivery/banner1.jpg" alt="Banner Image">
                                    </div>
                                    <div class="ul-banner-slide-txt">
                                        <span class="ul-banner-slide-sub-title">For Men Who Set Standards</span>
                                        <h1 class="ul-banner-slide-title">Tailored Style. Premium Fabric.</h1>
                                        <p class="ul-banner-slide-price">Starting From <span class="price">2,500</span></p>
                                        <a href="shop.html" class="ul-btn">VIEW COLLECTION <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div>

                                <!-- single slide -->
                                <!-- <div class="swiper-slide ul-banner-slide">
                                    <div class="ul-banner-slide-img">
                                        <img src="assets/img/banner-slide-1.jpg" alt="Banner Image">
                                    </div>
                                    <div class="ul-banner-slide-txt">
                                        <span class="ul-banner-slide-sub-title">Perfect for Summer Evenings</span>
                                        <h1 class="ul-banner-slide-title">Casual and Stylish for All Seasons</h1>
                                        <p class="ul-banner-slide-price">Starting From <span class="price">$129</span></p>
                                        <a href="shop.html" class="ul-btn">SHOP NOW <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div> -->
                            </div>

                            <!-- slider navigation -->
                            <div class="ul-banner-slider-nav-wrapper">
                                <div class="ul-banner-slider-nav">
                                    <button class="prev"><span class="icon"><i class="flaticon-down"></i></span></button>
                                    <button class="next"><span class="icon"><i class="flaticon-down"></i></span></button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="ul-banner-img-slider-wrapper">
                        <div class="ul-banner-img-slider swiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <img src="assets/img/delivery/Frame10.jpg" alt="Banner Image">
                                </div>
                                <div class="swiper-slide">
                                    <img src="assets/img/delivery/Frame2.jpg" alt="Banner Image">
                                </div>
                                <div class="swiper-slide">
                                    <img src="assets/img/delivery/Frame11.jpg" alt="Banner Image">
                                </div>
                                <!-- <div class="swiper-slide">
                                    <img src="assets/img/banner-img-slide-1.jpg" alt="Banner Image">
                                </div> -->
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
        <!-- BANNER SECTION END -->


        <!-- CATEGORY SECTION START -->
        <div class="ul-container">
            <section class="ul-categories">
                <div class="ul-inner-container">
                    <div class="row row-cols-lg-4 row-cols-md-3 row-cols-2 row-cols-xxs-1 ul-bs-row">
                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-1.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Men</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-2.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Kids</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-3.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Pants</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-1.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Men</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-4.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Women</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-5.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Jeans</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-6.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Sweater</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>

                        <!-- single category -->
                        <div class="col">
                            <a class="ul-category" href="shop.html">
                                <div class="ul-category-img">
                                    <img src="assets/img/category-7.jpg" alt="Category Image">
                                </div>
                                <div class="ul-category-txt">
                                    <span>Shoe</span>
                                </div>
                                <div class="ul-category-btn">
                                    <span><i class="flaticon-arrow-point-to-right"></i></span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!-- CATEGORY SECTION END -->


 <!-- PRODUCTS SECTION START -->
<div class="ul-container">
    <section class="ul-products">
        <div class="ul-inner-container">
            <div class="ul-section-heading">
                <div class="left">
                    <span class="ul-section-sub-title">Latest in Men's Fashion</span>
                    <h2 class="ul-section-title">Discover The Lakhas Signature Collection</h2>
                </div>
                <div class="right">
                    <a href="#" class="ul-btn">More Collection <i class="flaticon-up-right-arrow"></i></a>
                </div>
            </div>

            <div class="row ul-bs-row">
                <!-- Left Sub-Banner -->
                <div class="col-lg-3 col-md-4 col-12">
                    <div class="ul-products-sub-banner">
                        <div class="ul-products-sub-banner-img">
                            <img src="{{ asset('assets/img/delivery/Gemini_Generated_Image_3bxfmv3bxfmv3bxf.png') }}" alt="Sub Banner Image">
                        </div>
                        <div class="ul-products-sub-banner-txt">
                            <h3 class="ul-products-sub-banner-title">Flash Offers on Shalwar Kameez & More!</h3>
                            <a href="#" class="ul-btn">Explore Collection<i class="flaticon-up-right-arrow"></i></a>
                        </div>
                    </div>
                </div>

                <!-- Dynamic Products -->
                <div class="col-lg-9 col-md-8 col-12">
                    <div class="swiper ul-products-slider-1">
                        <div class="swiper-wrapper">
                            @foreach($products as $product)
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">${{ $product->sale_price ?? $product->price }}</span>
                                            @if($product->discount_percentage)
                                                <span class="ul-product-discount-tag">{{ $product->discount_percentage }}% Off</span>
                                            @endif
                                        </div>

                                        <div class="ul-product-img">
                                            <a href="{{ route('shop.details', $product->id) }}">
                                                <img src="{{ asset('images/products/' . $product->image) }}" alt="{{ $product->name }}">
                                            </a>

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="{{ route('shop.details', $product->id) }}"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title">
                                                <a href="{{ route('shop.details', $product->id) }}">{{ $product->name }}</a>
                                            </h4>
                                            <h5 class="ul-product-category">
                                                <a href="#">{{ $product->category->name ?? 'Uncategorized' }}</a>
                                            </h5>
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>

                    <!-- Slider Navigation -->
                    <div class="ul-products-slider-nav ul-products-slider-1-nav">
                        <button class="prev"><i class="flaticon-left-arrow"></i></button>
                        <button class="next"><i class="flaticon-arrow-point-to-right"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>
<!-- PRODUCTS SECTION END -->



        <!-- AD SECTION START -->
        <div class="ul-container">
            <section class="ul-ad">
                <div class="ul-inner-container">
                    <div class="ul-ad-content">
                        <div class="ul-ad-txt">
                            <span class="ul-ad-sub-title">Exclusive Offer</span>
                            <h2 class="ul-section-title">Flat 30% OFF on Shalwar Kameez & Tailoring!</h2>
                            <div class="ul-ad-categories">
                                <span class="category"><span><i class="flaticon-check-mark"></i></span>Unstitched Fabrics</span>
                                <span class="category"><span><i class="flaticon-check-mark"></i></span>Stitched Outfits</span>
                                <span class="category"><span><i class="flaticon-check-mark"></i></span>Pant Coats</span>
                                <span class="category"><span><i class="flaticon-check-mark"></i></span>Islamic Caps</span>
                                <span class="category"><span><i class="flaticon-check-mark"></i></span>Custom Tailoring</span>
                            </div>
                        </div>

                        <div class="ul-ad-img">
                            <img src="assets/img/delivery/ad.png" alt="Ad Image">
                        </div>

                        <a href="shop.html" class="ul-btn">Grab the Discount <i class="flaticon-up-right-arrow"></i></a>
                    </div>
                </div>
            </section>
        </div>
        <!-- AD SECTION END -->


        <!-- MOST SELLING START -->
        <div class="ul-container">
            <section class="ul-products ul-most-selling-products">
                <div class="ul-inner-container">
                    <div class="ul-section-heading flex-lg-row flex-column text-md-start text-center">
                        <div class="left">
                            <span class="ul-section-sub-title">most selling items</span>
                            <h2 class="ul-section-title">Top selling Categories This Week</h2>
                        </div>

                        <div class="right">
                            <div class="ul-most-sell-filter-navs">
                                <button type="button" data-filter="all">All Products</button>
                                <button type="button" data-filter=".best-selling">Best Selling</button>
                                <button type="button" data-filter=".on-selling">On Selling</button>
                                <button type="button" data-filter=".top-rating">Top Rating</button>
                            </div>
                        </div>
                    </div>


                    <!-- products grid -->
                    <div class="ul-bs-row row row-cols-xl-4 row-cols-lg-3 row-cols-sm-2 row-cols-1 ul-filter-products-wrapper">
                        <!-- product card -->
                        <div class="mix col best-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-1.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col on-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-2.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col top-rating">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-3.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col top-rating">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-4.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col on-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-5.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col best-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-6.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col on-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-7.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col top-rating">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-8.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col on-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-9.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col best-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-10.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col best-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-11.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- product card -->
                        <div class="mix col on-selling">
                            <div class="ul-product-horizontal">
                                <div class="ul-product-horizontal-img">
                                    <img src="assets/img/product-img-sm-12.jpg" alt="Product Image">
                                </div>

                                <div class="ul-product-horizontal-txt">
                                    <span class="ul-product-price">$99.00</span>
                                    <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                    <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                    <div class="ul-product-rating">
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                        <span class="star"><i class="flaticon-star"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!-- MOST SELLING END -->


        <!-- VIDEO SECTION START -->
        <div class="ul-container">
            <div class="ul-video">
                <div>
                    <img src="assets/img/delivery/video-banner.png" alt="Video Banner" class="ul-video-cover">
                </div>
                <a href="https://youtu.be/cNOKQIw81SE?si=iwUyBvpTD3h8DpFK" data-fslightbox="video" class="ul-video-btn"><i class="flaticon-play-button-arrowhead"></i></a>
            </div>
        </div>
        <!-- VIDEO SECTION END -->


        <!-- SUB BANNER SECTION START -->
        <div class="ul-container">
            <section class="ul-sub-banners">
                <div class="ul-inner-container">
                    <div class="row ul-bs-row row-cols-md-3 row-cols-sm-2 row-cols-1">
                        <!-- single sub banner -->
                        <div class="col">
                            <div class="ul-sub-banner ">
                                <div class="ul-sub-banner-txt">
                                    <div class="top">
                                        <span class="ul-ad-sub-title">Ready to Wear</span>
                                        <h3 class="ul-sub-banner-title">Stitched Garments</h3>
                                        <p class="ul-sub-banner-descr">Coats, Shalwar Kameez & More</p>
                                    </div>

                                    <div class="bottom">
                                        <a href="shop.html" class="ul-sub-banner-btn1">Shop Now <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div>

                                <div class="ul-sub-banner-img">
                                    <img src="assets/img/delivery/threebanners1.png" alt="Sub Banner Image">
                                </div>
                            </div>
                        </div>

                        <!-- single sub banner -->
                        <div class="col">
                            <div class="ul-sub-banner ul-sub-banner--2">
                                <div class="ul-sub-banner-txt">
                                    <div class="top">
                                        <span class="ul-ad-sub-title">Premium Fabrics</span>
                                        <h3 class="ul-sub-banner-title">Unstitched Collection</h3>
                                        <p class="ul-sub-banner-descr">Top Quality Fabrics for Every Season</p>
                                    </div>

                                    <div class="bottom">
                                        <a href="shop.html" class="ul-sub-banner-btn">Explore Fabrics <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div>

                                <div class="ul-sub-banner-img">
                                    <img src="assets/img/delivery/threebanners2.png" alt="Sub Banner Image">
                                </div>
                            </div>
                        </div>

                        <!-- single sub banner -->
                        <div class="col">
                            <div class="ul-sub-banner ul-sub-banner--3">
                                <div class="ul-sub-banner-txt">
                                    <div class="top">
                                        <span class="ul-ad-sub-title">Tailored Just for You</span>
                                        <h3 class="ul-sub-banner-title">Stitching Services</h3>
                                        <p class="ul-sub-banner-descr">Custom Fits | Fast Delivery</p>
                                    </div>

                                    <div class="bottom">
                                        <a href="shop.html" class="ul-sub-banner-btn1">Get Stitched <i class="flaticon-up-right-arrow"></i></a>
                                    </div>
                                </div>

                                <div class="ul-sub-banner-img">
                                    <img src="assets/img/delivery/threebanners3.png" alt="Sub Banner Image">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!-- SUB BANNER SECTION END -->


        <!-- FLASH SALE SECTION START -->
        <div class="overflow-hidden">
            <div class="ul-container">
                <div class="ul-flash-sale">
                    <div class="ul-inner-container">
                        <!-- heading -->
                        <div class="ul-section-heading ul-flash-sale-heading">
                            <div class="left">
                                <span class="ul-section-sub-title">Latest Arrivals</span>
                                <h2 class="ul-section-title">Flash Deals on Gents Wear</h2>
                            </div>

                            <div class="ul-flash-sale-countdown-wrapper">
                                <div class="ul-flash-sale-countdown">
                                    <div class="days-wrapper">
                                        <div class="days number">00</div>
                                        <span class="txt">Days</span>
                                    </div>
                                    <div class="hours-wrapper">
                                        <div class="hours number">00</div>
                                        <span class="txt">Hours</span>
                                    </div>
                                    <div class="minutes-wrapper">
                                        <div class="minutes number">00</div>
                                        <span class="txt">Min</span>
                                    </div>
                                    <div class="seconds-wrapper">
                                        <div class="seconds number">00</div>
                                        <span class="txt">Sec</span>
                                    </div>
                                </div>
                            </div>

                            <a href="shop.html" class="ul-btn">View All Collection <i class="flaticon-up-right-arrow"></i></a>
                        </div>

                        <!-- produtcs slider -->
                        <div class="ul-flash-sale-slider swiper">
                            <div class="swiper-wrapper">
                                <!-- single product -->
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">PKR 5,200<span>
                                            <span class="ul-product-discount-tag">20% Off</span>
                                        </div>

                                        <div class="ul-product-img">
                                            <img src="assets/img/product-img-1.jpg" alt="Product Image">

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="index.html#"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title"><a href="shop-details.html">Classic White Shalwar Kameez</a></h4>
                                            <h5 class="ul-product-category"><a href="shop.html">Stitched Collection</a></h5>
                                        </div>
                                    </div>
                                </div>

                                <!-- single product -->
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">PKR 7,800</span>
                                            <span class="ul-product-discount-tag">15% Off</span>
                                        </div>

                                        <div class="ul-product-img">
                                            <img src="assets/img/product-img-2.jpg" alt="Product Image">

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="index.html#"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title"><a href="shop-details.html">Formal Pant Coat Set</a></h4>
                                            <h5 class="ul-product-category"><a href="shop.html">Winter Collection</a></h5>
                                        </div>
                                    </div>
                                </div>

                                <!-- single product -->
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">PKR 2,500</span>
                                            <span class="ul-product-discount-tag">10% Off</span>
                                        </div>

                                        <div class="ul-product-img">
                                            <img src="assets/img/product-img-3.jpg" alt="Product Image">

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="index.html#"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title"><a href="shop-details.html">Embroidered Islamic Cap</a></h4>
                                            <h5 class="ul-product-category"><a href="shop.html">Accessories</a></h5>
                                        </div>
                                    </div>
                                </div>

                                <!-- single product -->
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">$99.00</span>
                                            <span class="ul-product-discount-tag">25% Off</span>
                                        </div>

                                        <div class="ul-product-img">
                                            <img src="assets/img/product-img-4.jpg" alt="Product Image">

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="index.html#"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                            <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                        </div>
                                    </div>
                                </div>

                                <!-- single product -->
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">$99.00</span>
                                            <span class="ul-product-discount-tag">25% Off</span>
                                        </div>

                                        <div class="ul-product-img">
                                            <img src="assets/img/product-img-5.jpg" alt="Product Image">

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="index.html#"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                            <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                        </div>
                                    </div>
                                </div>

                                <!-- single product -->
                                <div class="swiper-slide">
                                    <div class="ul-product">
                                        <div class="ul-product-heading">
                                            <span class="ul-product-price">$99.00</span>
                                            <span class="ul-product-discount-tag">25% Off</span>
                                        </div>

                                        <div class="ul-product-img">
                                            <img src="assets/img/product-img-1.jpg" alt="Product Image">

                                            <div class="ul-product-actions">
                                                <button><i class="flaticon-shopping-bag"></i></button>
                                                <a href="index.html#"><i class="flaticon-hide"></i></a>
                                                <button><i class="flaticon-heart"></i></button>
                                            </div>
                                        </div>

                                        <div class="ul-product-txt">
                                            <h4 class="ul-product-title"><a href="shop-details.html">Orange Airsuit</a></h4>
                                            <h5 class="ul-product-category"><a href="shop.html">Fashion Bag</a></h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- FLASH SALE SECTION END -->


        <!-- REVIEWS SECTION START -->
        <section class="ul-reviews overflow-hidden">
            <div class="ul-section-heading text-center justify-content-center">
                <div>
                    <span class="ul-section-sub-title">Customer Reviews</span>
                    <h2 class="ul-section-title">What Our Clients Say</h2>
                    <p class="ul-reviews-heading-descr">Real feedback from our satisfied customers — because your trust is our true success..</p>
                </div>
            </div>

            <!-- slider -->
            <div class="ul-reviews-slider swiper">
                <div class="swiper-wrapper">
                    <!-- single review -->
                    <div class="swiper-slide">
                        <div class="ul-review">
                            <div class="ul-review-rating">
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star-3"></i>
                            </div>
                            <p class="ul-review-descr">The stitched shalwar kameez I received from The Lakhas was absolutely perfect! Quality fabric, great fitting, and fast delivery. Highly recommended.</p>
                            <div class="ul-review-bottom">
                                <div class="ul-review-reviewer">
                                    <div class="reviewer-image"><img src="assets/img/review-author-1.png" alt="reviewer image"></div>
                                    <div>
                                        <h3 class="reviewer-name">Ahmed Raza</h3>
                                        <span class="reviewer-role">Karachi</span>
                                    </div>
                                </div>

                                <!-- icon -->
                                <div class="ul-review-icon"><i class="flaticon-left"></i></div>
                            </div>
                        </div>
                    </div>

                    <!-- single review -->
                    <div class="swiper-slide">
                        <div class="ul-review">
                            <div class="ul-review-rating">
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star-3"></i>
                            </div>
                            <p class="ul-review-descr">I ordered an unstitched suit and got it stitched through their tailoring service. The measurements were on point and the look turned out classy!</p>
                            <div class="ul-review-bottom">
                                <div class="ul-review-reviewer">
                                    <div class="reviewer-image"><img src="assets/img/review-author-2.png" alt="reviewer image"></div>
                                    <div>
                                        <h3 class="reviewer-name">Bilal Khan</h3>
                                        <span class="reviewer-role">Karachi</span>
                                    </div>
                                </div>

                                <!-- icon -->
                                <div class="ul-review-icon"><i class="flaticon-left"></i></div>
                            </div>
                        </div>
                    </div>

                    <!-- single review -->
                    <div class="swiper-slide">
                        <div class="ul-review">
                            <div class="ul-review-rating">
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star-3"></i>
                            </div>
                            <p class="ul-review-descr"> Loved the fabric and neat stitching! I also got a traditional Islamic cap and it completed the outfit perfectly. Great service by The Lakhas.</p>
                            <div class="ul-review-bottom">
                                <div class="ul-review-reviewer">
                                    <div class="reviewer-image"><img src="assets/img/review-author-3.png" alt="reviewer image"></div>
                                    <div>
                                        <h3 class="reviewer-name">Saad Mehmood</h3>
                                        <span class="reviewer-role">Online Buyer</span>
                                    </div>
                                </div>

                                <!-- icon -->
                                <div class="ul-review-icon"><i class="flaticon-left"></i></div>
                            </div>
                        </div>
                    </div>

                    <!-- single review -->
                    <div class="swiper-slide">
                        <div class="ul-review">
                            <div class="ul-review-rating">
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star-3"></i>
                            </div>
                            <p class="ul-review-descr">The Lakhas delivers what it promises — stylish designs, comfortable fit, and top-tier tailoring. Will definitely shop again for Eid outfits!</p>
                            <div class="ul-review-bottom">
                                <div class="ul-review-reviewer">
                                    <div class="reviewer-image"><img src="assets/img/review-author-4.png" alt="reviewer image"></div>
                                    <div>
                                        <h3 class="reviewer-name">Usman Tariq</h3>
                                        <span class="reviewer-role">Karachi</span>
                                    </div>
                                </div>

                                <!-- icon -->
                                <div class="ul-review-icon"><i class="flaticon-left"></i></div>
                            </div>
                        </div>
                    </div>

                    <!-- single review -->
                    <div class="swiper-slide">
                        <div class="ul-review">
                            <div class="ul-review-rating">
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star"></i>
                                <i class="flaticon-star-3"></i>
                            </div>
                            <p class="ul-review-descr"> The fabric quality and detailing are excellent. I got a custom pant coat stitched and it exceeded expectations. Great customer service too!</p>
                            <div class="ul-review-bottom">
                                <div class="ul-review-reviewer">
                                    <div class="reviewer-image"><img src="assets/img/review-author-2.png" alt="reviewer image"></div>
                                    <div>
                                        <h3 class="reviewer-name">Fahad Sheikh</h3>
                                        <span class="reviewer-role">Sales Executive</span>
                                    </div>
                                </div>

                                <!-- icon -->
                                <div class="ul-review-icon"><i class="flaticon-left"></i></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- REVIEWS SECTION END -->


        <!-- NEWSLETTER SUBSCRIPTION SECTION START -->
        <div class="ul-container">
            <section class="ul-nwsltr-subs">
                <div class="ul-inner-container">
                    <!-- heading -->
                    <div class="ul-section-heading justify-content-center text-center">
                        <div>
                            <span class="ul-section-sub-title text-white">GET NEWSLETTER</span>
                            <h2 class="ul-section-title text-white text-white">Sign Up to Newsletter</h2>
                        </div>
                    </div>

                    <!-- form -->
                    <div class="ul-nwsltr-subs-form-wrapper">
                        <div class="icon"><i class="flaticon-airplane"></i></div>
                        <form action="index.html#" class="ul-nwsltr-subs-form">
                            <input type="email" name="nwsltr-subs-email" id="nwsltr-subs-email" placeholder="Enter Your Email">
                            <button type="submit">Subscribe Now <i class="flaticon-up-right-arrow"></i></button>
                        </form>
                    </div>
                </div>
            </section>
        </div>
        <!-- NEWSLETTER SUBSCRIPTION SECTION END -->


        <!-- BLOG SECTION START -->
        <!--<div class="ul-container">  -->
             <!-- <section class="ul-blogs">
                <div class="ul-inner-container">
                    <!- heading -->
                     <!-- <div class="ul-section-heading">
                        <div class="left">
                            <span class="ul-section-sub-title">News & Blog</span>
                            <h2 class="ul-section-title">Latest News & Blog</h2>
                        </div>

                        <div>
                            <a href="blog.html" class="ul-blogs-heading-btn">View All BLog <i class="flaticon-up-right-arrow"></i></a>
                        </div>
                    </div>

                    <!- blog grid -->
                  <!--    <div class="row ul-bs-row row-cols-md-3 row-cols-2 row-cols-xxs-1">
                        <!- single blog -->
                         <!-- <div class="col">
                            <div class="ul-blog">
                                <div class="ul-blog-img">
                                    <img src="assets/img/blog-1.jpg" alt="Article Image">

                                    <div class="date">
                                        <span class="number">15</span>
                                        <span class="txt">Dec</span>
                                    </div>
                                </div>

                                <div class="ul-blog-txt">
                                    <div class="ul-blog-infos flex gap-x-[30px] mb-[16px]">
                                         single info -->
                                        <!--  <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-user-2"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">By Admin</span>
                                        </div>
                                    </div>

                                    <h3 class="ul-blog-title"><a href="blog-details.html">Cuticle Pushers & Trimmers</a></h3>
                                    <p class="ul-blog-descr">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration</p>

                                    <a href="blog-details.html" class="ul-blog-btn">Read More <span class="icon"><i class="flaticon-up-right-arrow"></i></span></a>
                                </div>
                            </div>
                        </div>

                        <! single blog -->
                        <!--  <div class="col">
                            <div class="ul-blog">
                                <div class="ul-blog-img">
                                    <img src="assets/img/blog-2.jpg" alt="Article Image">

                                    <div class="date">
                                        <span class="number">15</span>
                                        <span class="txt">Dec</span>
                                    </div>
                                </div>

                                <div class="ul-blog-txt">
                                    <div class="ul-blog-infos flex gap-x-[30px] mb-[16px]">
                                        <!- single info -->
                                          <!--<div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-user-2"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">By Admin</span>
                                        </div>
                                    </div>

                                    <h3 class="ul-blog-title"><a href="blog-details.html">Cuticle Pushers & Trimmers</a></h3>
                                    <p class="ul-blog-descr">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration</p>

                                    <a href="blog-details.html" class="ul-blog-btn">Read More <span class="icon"><i class="flaticon-up-right-arrow"></i></span></a>
                                </div>
                            </div>
                        </div>

                        <!- single blog -->
                         <!-- <div class="col">
                            <div class="ul-blog">
                                <div class="ul-blog-img">
                                    <img src="assets/img/blog-3.jpg" alt="Article Image">

                                    <div class="date">
                                        <span class="number">15</span>
                                        <span class="txt">Dec</span>
                                    </div>
                                </div>

                                <div class="ul-blog-txt">
                                    <div class="ul-blog-infos flex gap-x-[30px] mb-[16px]">
                                        <!- single info -->
                                         <!-- <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-user-2"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">By Admin</span>
                                        </div>
                                    </div>

                                    <h3 class="ul-blog-title"><a href="blog-details.html">Cuticle Pushers & Trimmers</a></h3>
                                    <p class="ul-blog-descr">There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration</p>

                                    <a href="blog-details.html" class="ul-blog-btn">Read More <span class="icon"><i class="flaticon-up-right-arrow"></i></span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <!- BLOG SECTION END -->


        <!-- GALLERY SECTION START -->
        <div class="ul-gallery overflow-hidden mx-auto">
            <div class="ul-gallery-slider swiper">
                <div class="swiper-wrapper">
                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-1.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-1.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-2.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-2.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-3.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-3.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-4.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-4.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-5.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-5.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-6.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-6.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-1.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="https://glamics.temptics.com/assets/img/gallery-1.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>

                    <!-- single gallery item -->
                    <div class="ul-gallery-item swiper-slide">
                        <img src="assets/img/gallery-item-2.jpg" alt="Gallery Image">
                        <div class="ul-gallery-item-btn-wrapper">
                            <a href="assets/img/gallery-item-2.jpg" data-fslightbox="gallery"><i class="flaticon-instagram"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- GALLERY SECTION END -->
    </main>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        // Slider 1
        new Swiper(".ul-products-slider-1", {
            slidesPerView: 3,
            spaceBetween: 20,
            navigation: {
                nextEl: ".ul-products-slider-1-nav .next",
                prevEl: ".ul-products-slider-1-nav .prev",
            },
            breakpoints: {
                992: {
                    slidesPerView: 3, // Desktop
                },
                768: {
                    slidesPerView: 2, // Tablet
                },
                0: {
                    slidesPerView: 1, // Mobile
                }
            }
        });

        // Slider 2
        new Swiper(".ul-products-slider-2", {
            slidesPerView: 3,
            spaceBetween: 20,
            navigation: {
                nextEl: ".ul-products-slider-2-nav .next",
                prevEl: ".ul-products-slider-2-nav .prev",
            },
            breakpoints: {
                992: {
                    slidesPerView: 3,
                },
                768: {
                    slidesPerView: 2,
                },
                0: {
                    slidesPerView: 1,
                }
            }
        });
    });
</script>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    new Swiper(".ul-flash-sale-slider", {
      slidesPerView: 3,
      spaceBetween: 20,
      loop: true,
      autoplay: {
        delay: 2500, // Slide will change every 2.5 seconds
        disableOnInteraction: false, // Keep autoplay even after user interaction
      },
      navigation: {
        nextEl: ".ul-flash-sale-next",
        prevEl: ".ul-flash-sale-prev",
      },
      breakpoints: {
        992: {
          slidesPerView: 3
        },
        768: {
          slidesPerView: 2
        },
        0: {
          slidesPerView: 1
        }
      }
    });
  });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var swiper = new Swiper(".ul-gallery-slider", {
            slidesPerView: 4,
            spaceBetween: 20,
            loop: true,
            autoplay: {
                delay: 2500,
                disableOnInteraction: false,
            },
            breakpoints: {
                0: {
                    slidesPerView: 1
                },
                768: {
                    slidesPerView: 4
                },
                1024: {
                    slidesPerView: 6
                }
            }
        });
    });
</script>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        new Swiper(".ul-reviews-slider", {
            slidesPerView: 3,
            spaceBetween: 30,
            loop: true,
            autoplay: {
                delay: 3000,
                disableOnInteraction: false,
            },
            breakpoints: {
                0: {
                    slidesPerView: 1
                },
                768: {
                    slidesPerView: 2
                },
                1024: {
                    slidesPerView: 4
                }
            }
        });
    });
</script>




@endsection