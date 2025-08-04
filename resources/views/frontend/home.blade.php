
@extends('layouts.frontendlinks')
@section('title', 'Home')
@section('content')
<style>
    .ul-review {
    overflow: hidden;
    word-wrap: break-word;
    max-width: 100%;
    padding: 20px;
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0,0,0,0.1);
    height: 100%; 
    display: flex;
    flex-direction: column;
    justify-content: space-between;
}
.swiper-slide {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); 
    border-radius: 8px;                      
    background-color: #fff;                   
    transition: transform 0.3s ease, box-shadow 0.3s ease; 
}

.swiper-slide:hover {
    transform: translateY(-5px);             
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15); 
}


.ul-review-descr {
    font-size: 14px;
    color: #333;
    margin: 15px 0;
    overflow-wrap: break-word;
    word-break: break-word;
    white-space: normal;
}
.swiper-slide {
    display: flex;
    height: auto;
}

.ul-review-rating i {
    color: #f5b50a;
}


.badge-success {
    background-color: #28a745;
    color: white;
    padding: 3px 10px;
    font-size: 12px;
    border-radius: 5px;
}
.ul-product-img img{
    height:100%;
}



</style>
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
                  @php $activeCategory = request('category'); @endphp
                @foreach($categories as $category)
                    <div class="col">
                       <a class="ul-category {{ $activeCategory == $category->id ? 'active' : '' }}" href="{{ route('category', ['category' => $category->id]) }}">

                            <div class="ul-category-img">
                             <img src="{{ asset('storage/images/categories/' . $category->image) }}" alt="{{ $category->name }}">

                            </div>
                            <div class="ul-category-txt">
                                <span>{{ $category->name }}</span>
                            </div>
                            <div class="ul-category-btn">
                                <span><i class="flaticon-arrow-point-to-right"></i></span>
                            </div>
                        </a>
                    </div>
                @endforeach
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
                <!-- <div class="col-lg-3 col-md-4 col-12">
                    <div class="ul-products-sub-banner">
                        <div class="ul-products-sub-banner-img">
                            <img src="{{ asset('assets/img/delivery/Gemini_Generated_Image_3bxfmv3bxfmv3bxf.png') }}" alt="Sub Banner Image">
                        </div>
                        <div class="ul-products-sub-banner-txt">
                            <h3 class="ul-products-sub-banner-title">Flash Offers on Shalwar Kameez & More!</h3>
                            <a href="#" class="ul-btn">Explore Collection<i class="flaticon-up-right-arrow"></i></a>
                        </div>
                    </div>
                </div> -->

           
                <div class="col-lg-9 col-md-8 col-12">
                    <div class="swiper ul-products-slider-1">
                        <div class="swiper-wrapper">
                        @foreach($products as $product)
    @if($product->stock_alert > 0) {{-- Sirf stock wale products show karo --}}
        <div  class="swiper-slide">
            <div class="ul-product">
                <div class="ul-product-heading">
                       <a style="color:black; font-weight:700;" href="{{ route('shop.details', $product->id) }}">{{ $product->name }}</a>
                    @if($product->discount_percentage)
                        <span class="ul-product-discount-tag">{{ $product->discount_percentage }}% Off</span>
                    @endif
                </div>

                <div  class="ul-product-img">
                    <a href="{{ route('shop.details', $product->id) }}">
                        <img src="{{ asset('images/products/' . $product->image) }}" alt="{{ $product->name }}">
                    </a>

                    <div class="ul-product-actions">
                        <button class="add-to-cart" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-shopping-bag"></i></span>
                            <span class="text"></span>
                        </button>
                        <a href="{{ route('shop.details', $product->id) }}"><i class="flaticon-hide"></i></a>
                        <button class="add-to-wishlist" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-heart"></i></span>
                        </button>
                    </div>
                </div>

                <div class="ul-product-txt">
                    <h4 class="ul-product-title">
                    
                         <span class="ul-product-price">Rs{{ $product->sale_price ?? $product->price }}</span>
                    </h4>
                    <h5 class="ul-product-category">
                        <a href="#">{{ $product->category->name ?? 'Uncategorized' }}</a>
                    </h5>
                    <div class="ul-stock-status" style="margin-top: 5px;">
                        <span style="color:black" class="badge ">In Stock</span>
                    </div>
                            <div class="ul-product-rating">
    @php
        $averageRating = round($product->reviews_avg_rating);
    @endphp

    @for ($i = 1; $i <= 5; $i++)
        <i class="{{ $i <= $averageRating ? 'flaticon-star' : 'flaticon-star-3' }}" style="color: #f5b50a;"></i>
    @endfor
</div>
 <div class="mt-3 d-flex justify-content-between">
                    <!-- Add to Cart Button -->
                 
                        <button class="add-to-cart" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-shopping-bag"></i></span>
                            <span class="text"></span>
                        </button>
                        <a href="{{ route('shop.details', $product->id) }}"><i class="flaticon-hide"></i></a>
                        <button class="add-to-wishlist" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-heart"></i></span>
                        </button>
                 
                </div>
                </div>
            </div>
        </div>
    @endif
@endforeach


         
                        </div>
     
                    </div>
                                                          <div class="pagination-wrapper">
    {{ $products->links('pagination::bootstrap-4') }}
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
                                    @php $activeCategory = request('category'); @endphp
             @foreach($categories as $category)
    <button type="button" data-filter=".category-{{ $category->id }}">{{ $category->name }}</button>
@endforeach

                           
                            </div>
                        </div>
                    </div>


                    <!-- products grid -->
                    <div class="ul-bs-row row row-cols-xl-4 row-cols-lg-3 row-cols-sm-2 row-cols-1 ul-filter-products-wrapper">
                        <!-- product card -->
                     @foreach ($products as $product)
    <div class="mix col category-{{ $product->category_id }}">
        <div class="ul-product-horizontal">
            <div class="ul-product-horizontal-img">
                <img src="{{ asset('images/products/' . $product->image) }}" alt="{{ $product->name }}">
            </div>
            <div class="ul-product-horizontal-txt">
                <span class="ul-product-price">Rs{{ $product->price }}</span>
                <h4 class="ul-product-title"><a href="{{ route('shop.details', $product->id) }}">{{ $product->name }}</a></h4>
                <h5 class="ul-product-category"><a href="{{ route('shop.details', $product->id) }}">{{ $product->category->name }}</a></h5>
             <div class="ul-product-rating">
    @php
        $averageRating = round($product->reviews_avg_rating);
    @endphp

    @for ($i = 1; $i <= 5; $i++)
        <i class="{{ $i <= $averageRating ? 'flaticon-star' : 'flaticon-star-3' }}" style="color: #f5b50a;"></i>
    @endfor
</div>

            </div>
        </div>
    </div>
@endforeach


             

                     
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
                                        <a href="{{ route('shop.stitched') }}" class="ul-sub-banner-btn1">Shop Now <i class="flaticon-up-right-arrow"></i></a>
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
                                        <a href="{{ route('shop.unstitched') }}" class="ul-sub-banner-btn">Explore Fabrics <i class="flaticon-up-right-arrow"></i></a>
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
                                        <h3 class="ul-sub-banner-title">All Items</h3>
                                        <p class="ul-sub-banner-descr">Custom Fits | Fast Delivery</p>
                                    </div>

                                    <div class="bottom">
                                        <a href="/shop" class="ul-sub-banner-btn1">Get Items <i class="flaticon-up-right-arrow"></i></a>
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
                       @foreach($latestproduct as $products)

    <div class="swiper-slide">
        <div class="ul-product">
            <div class="ul-product-heading">
                <span class="ul-product-price">
               PKR{{ $products->price }}
                </span>
                @if($products->discount_percentage)
                    <span class="ul-product-discount-tag">
                        {{ $products->discount_percentage }}% Off
                    </span>
                @endif
            </div>

            <div class="ul-product-img">
                <img src="{{  asset('images/products/' . $products->image) }}" alt="Product Image">
                <div class="ul-product-actions">
               
                         <button class="add-to-cart" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-shopping-bag"></i></span>
                            <span class="text"></span>
                        </button>
                
                   <a href="{{ route('shop.details', $product->id) }}"><i class="flaticon-hide"></i></a>
                 
                     <button class="add-to-wishlist" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-heart"></i></span>
                        </button>
                  
                </div>
            </div>

            <div class="ul-product-txt">
                <h4 class="ul-product-title">
                    <a href="">
                        {{ $products->name }}
                    </a>
                </h4>
                <h5 class="ul-product-category">
                    <a href="{{ route('category', ['category' => $products->category_id]) }}">
                        {{ $products->category->name ?? 'Uncategorized' }}
                    </a>
                </h5>
                 <div class="mt-3 d-flex justify-content-between">
                    <!-- Add to Cart Button -->
                 
                        <button class="add-to-cart" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-shopping-bag"></i></span>
                            <span class="text"></span>
                        </button>
                        <a href="{{ route('shop.details', $product->id) }}"><i class="flaticon-hide"></i></a>
                        <button class="add-to-wishlist" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-heart"></i></span>
                        </button>
                 
                </div>
            </div>
        </div>
    </div>
@endforeach


     
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
                     @foreach ($reviews as $review)
        <div class="swiper-slide">
            <div style="width:100%;" class="ul-review">
                <!-- Stars -->
                <div class="ul-review-rating">
                    @for ($i = 1; $i <= 5; $i++)
                        <i class="{{ $i <= $review->rating ? 'flaticon-star' : 'flaticon-star-3' }}"></i>
                    @endfor
                </div>

                <!-- Review Text -->
                <p class="ul-review-descr">{{ $review->comment }}</p>

                <!-- Reviewer Info -->
                <div class="ul-review-bottom">
                    <div class="ul-review-reviewer">
                        <div class="reviewer-image">
                              <i class="fas fa-user-circle" style="font-size: 40px; color: #999;"></i>
                        </div>
                        <div>
                            <h3 class="reviewer-name">{{ $review->user->username ?? 'Anonymous' }}</h3>
                            <span class="reviewer-role">{{ $review->user->city ?? 'Costemer' }}</span>
                        </div>
                    </div>

                    <div class="ul-review-icon"><i class="flaticon-left"></i></div>
                </div>
            </div>
        </div>
    @endforeach

               
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
                      <form action="{{ route('newsletter.subscribe') }}" method="POST" class="ul-nwsltr-subs-form">
    @csrf
    <input type="email" name="email" id="nwsltr-subs-email" placeholder="Enter Your Email" required>
    <button type="submit">Subscribe Now <i class="flaticon-up-right-arrow"></i></button>
</form>

@if(session('success'))
    <p style="color: #28a745; text-align:center;">{{ session('success') }}</p>
@endif

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
        <div class="ul-gallery overflow-hidden mx-auto mt-5">
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
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

<script>
$(document).ready(function() {
    // Initialize Toastr (if not already initialized elsewhere)
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "timeOut": "3000"
    };

    // Add to Cart AJAX - Better with loading states and error handling
    $(document).on('click', '.add-to-cart', function(e) {
        e.preventDefault();
        var button = $(this);
        var productId = button.data('product-id');
        var quantity = $('#ul-product-details-quantity').val() || 1; // Default to 1 if empty
        var size = $('input[name="product-size"]:checked').next('.size-btn').text();
        var color = $('input[name="product-color"]:checked').next('.color-btn').attr('class')?.split(' ')[1] || null;

        // Disable button during AJAX call
        button.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Adding...');

        $.ajax({
            url: '{{ route("cart.add") }}',
            type: 'POST',
            data: {
                product_id: productId,
                quantity: quantity,
                size: size,
                color: color,
                _token: '{{ csrf_token() }}'
            },
            success: function(response) {
                if(response.success) {
                    $('.cart-count').text(response.cart_count).fadeOut(100).fadeIn(100);
                    toastr.success(response.message || 'Product added to cart!');
                } else {
                    toastr.warning(response.message || 'Could not add to cart');
                }
            },
            error: function(xhr) {
                let errorMsg = xhr.responseJSON?.message || 'Something went wrong!';
                toastr.error(errorMsg);
            },
            complete: function() {
                button.prop('disabled', false).html(' <i class="flaticon-cart"></i>');
            }
        });
    });

$(document).on('click', '.add-to-wishlist', function(e) {
    e.preventDefault();
    console.log('Wishlist button clicked'); // Check if event fires
    
    var button = $(this);
    var productId = button.data('product-id');
    console.log('Product ID:', productId); // Verify product ID
    
    // Show loading state
    button.find('i').removeClass('flaticon-heart').addClass('fa fa-spinner fa-spin');
    console.log('Button state changed'); // Check if DOM manipulation works

    $.ajax({
        url: '{{ route("wishlist.add") }}',
        type: 'POST',
        data: {
            product_id: productId,
            _token: '{{ csrf_token() }}'
        },
        success: function(response) {
            console.log('AJAX Success:', response); // Inspect response
            if(response.success) {
                $('.wishlist-count').text(response.wishlist_count).fadeOut(100).fadeIn(100);
                toastr.success(response.message || 'Added to wishlist!');
                button.find('i').removeClass('fa-spinner fa-spin').addClass('flaticon-heart text-danger');
            } else {
                toastr.warning(response.message || 'Could not add to wishlist');
                button.find('i').removeClass('fa-spinner fa-spin').addClass('flaticon-heart');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error); // Detailed error logging
            console.error('Response:', xhr.responseJSON);
            let errorMsg = xhr.responseJSON?.message || 'Error processing request';
            toastr.error(errorMsg);
            button.find('i').removeClass('fa-spinner fa-spin').addClass('flaticon-heart');
        }
    });
});
});
</script>

    <script src="https://cdn.jsdelivr.net/npm/mixitup/dist/mixitup.min.js"></script>
<script>
    var containerEl = document.querySelector('.ul-filter-products-wrapper');
    var mixer = mixitup(containerEl);

</script>




@endsection