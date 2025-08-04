    <!-- SIDEBAR SECTION START -->
    <div class="ul-sidebar">
        <!-- header -->
        <div class="ul-sidebar-header">
            <div class="ul-sidebar-header-logo">
                <a href="index.html">
     <img src="{{ asset('assets/img/newlogo.png') }}" alt="logo" class="logo">


                </a>
            </div>
            <!-- sidebar closer -->
            <button class="ul-sidebar-closer"><i class="flaticon-close"></i></button>
        </div>

        <div class="ul-sidebar-header-nav-wrapper d-block d-lg-none"></div>

        <div class="ul-sidebar-about d-none d-lg-block">
            <span class="title">About The Lakhas</span>
            <p class="mb-0">
                The Lakhas is where tradition meets tailored excellence. Specializing in gents' stitched and unstitched garments, we offer everything from premium shalwar kameez to modern formalwear and custom accessories. With expert craftsmanship and attention to every detail, we create clothing that’s made to fit, made to last, and made for you.
            .</p>
        </div>


        <!-- product slider -->
        <div class="ul-sidebar-products-wrapper d-none d-lg-flex">
            <div class="ul-sidebar-products-slider swiper">
                <div class="swiper-wrapper">
                    <!-- product card -->
                                          @foreach($products as $product)
    @if($product->stock_alert > 0) {{-- Sirf stock wale products show karo --}}
        <div class="swiper-slide">
            <div class="ul-product">
                <div class="ul-product-heading">
                    <span class="ul-product-price">Rs{{ $product->sale_price ?? $product->price }}</span>
                    @if($product->discount_percentage)
                        <span class="ul-product-discount-tag">{{ $product->discount_percentage }}% Off</span>
                    @endif
                </div>

                <div class="ul-product-img">
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
                        <a href="{{ route('shop.details', $product->id) }}">{{ $product->name }}</a>
                    </h4>
                    <h5 class="ul-product-category">
                        <a href="#">{{ $product->category->name ?? 'Uncategorized' }}</a>
                    </h5>
                    <div class="ul-stock-status" style="margin-top: 5px;">
                        <span class="badge badge-success">In Stock</span>
                    </div>
                </div>
            </div>
        </div>
    @endif
@endforeach

                 

                  
                </div>
            </div>

            <div class="ul-sidebar-products-slider-nav flex-shrink-0">
                <button class="prev"><i class="flaticon-left-arrow"></i></button>
                <button class="next"><i class="flaticon-arrow-point-to-right"></i></button>
            </div>
        </div>

        <div class="ul-sidebar-about d-none d-lg-block">
            <p class="mb-0">
                <p class="mb-0">
        <strong>The Lakhas</strong> brings timeless elegance to modern gents wear. From finely stitched 
        <em>shalwar kameez</em> to premium unstitched fabrics, we craft style that fits every occasion.  
        Our expert tailoring service ensures each outfit is made just for you — with precision, class, and comfort.  
        Explore classic designs, contemporary cuts, and traditional accessories, all under one roof.  
        Proudly based in Karachi, delivering style across Pakistan.
          </p>
        </div>

        <!-- sidebar footer -->
        <div class="ul-sidebar-footer">
            <span class="ul-sidebar-footer-title">Follow us</span>

            <div class="ul-sidebar-footer-social">
                <a href="index.html#"><i class="flaticon-facebook-app-symbol"></i></a>
                <a href="index.html#"><i class="flaticon-twitter"></i></a>
                <a href="index.html#"><i class="flaticon-instagram"></i></a>
                <a href="index.html#"><i class="flaticon-youtube"></i></a>
            </div>
        </div>
    </div>
    <!-- SIDEBAR SECTION END -->


    <!-- HEADER SECTION START -->
    <header class="ul-header">
        <!-- header top -->
        <div class="ul-header-top">
    <div class="ul-header-top-slider splide">
        <div class="splide__track">
            <ul class="splide__list">
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> New Arrivals – Stitched & Unstitched Gents Wear</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Custom Tailoring Available – Perfect Fit Guaranteed</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Exclusive Designs in Shalwar Kameez & Pant Coats</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Nationwide Delivery – From Karachi to All Over Pakistan</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Islamic Caps & Accessories Now in Stock</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Get 15% Off on First Custom Stitching Order</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Premium Fabric. Tailored Elegance. Only at The Lakhas</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Book Tailoring Online – Stitching Starts at PKR 1,499</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Follow Us on Facebook – Stay Updated on New Drops!</p>
                </li>
                <li class="splide__slide">
                    <p class="ul-header-top-slider-item"><i class="flaticon-sparkle"></i> Elegant Looks, Traditional Touch – Shop Now</p>
                </li>
            </ul>
        </div>
    </div>
</div>


        <!-- header bottom -->
        <div class="ul-header-bottom">
            <div class="ul-container">
                <div class="ul-header-bottom-wrapper">
                    <!-- header left -->
                    <div class="header-bottom-left">
                        <div class="logo-container">
                            <a href="index.html" class="d-inline-block"><img src="{{ asset('assets/img/newlogo.png') }}" alt="logo" class="logo">
</a>
                        </div>

                        <!-- search form -->
                        <div class="ul-header-search-form-wrapper flex-grow-1 flex-shrink-0">
                            <!-- <form action="index.html#" class="ul-header-search-form"> -->
                                <div class="dropdown-wrapper">
            <!-- <select name="search-category" id="ul-header-search-category">
    <option value="" disabled selected>Select Category</option>
    @foreach ($categories as $category)
        <option value="{{ $category->id }}">{{ $category->name }}</option>
    @endforeach
</select> -->


                                </div>
                                <!-- <div class="ul-header-search-form-right">
                                    <input type="search" name="header-search" id="ul-header-search" placeholder="Search Here">
                                    <button type="submit"><span class="icon"><i class="flaticon-search-interface-symbol"></i></span></button>
                                </div> -->
                            </form>

                            <button class="ul-header-mobile-search-closer d-xxl-none"><i class="flaticon-close"></i></button>
                        </div>
                    </div>

                    <!-- header nav -->
                    <div class="ul-header-nav-wrapper">
                        <div class="to-go-to-sidebar-in-mobile">
            <nav class="ul-header-nav">
    <a href="/home">Home</a>
    <a href="/shop">Shop</a>
    <a href="/about">About</a>
    <a href="/contact">Contact</a>
    <a href="/blog">Blogs</a>

    @php
    $orderId = session('order_id');
@endphp

@if($orderId)
    <a href="{{ route('order.track', ['id' => $orderId]) }}">Track Your Order</a>
@endif



   <form action="{{ route('shop') }}" method="GET" class="ul-category-dropdown-form">
    <select 
        name="category" 
        onchange="this.form.submit()" 
        style="border: none; outline: none; box-shadow: none;  font-size: 16px;  cursor: pointer;"
    >
        <option value="" disabled selected>Select Category</option>
        @foreach ($categories as $category)
            <form action="{{ route('category') }}" method="GET">
                <input type="hidden" name="category" value="{{ $category->id }}">
                <button type="submit" class="dropdown-item">{{ $category->name }}</button>
            </form>
        @endforeach
    </div>
</div>
<style>
    .ul-category-dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-trigger {
    padding: 0px 5px 0px 0px;
    font-size: 16px;
    cursor: pointer;
    display: inline-block;
    color: black;
    background-color: transparent;
}

.dropdown-menu {
    display: none;
    position: absolute;
    top: 100%;
    left: 0;
    min-width: 200px;
    background-color: #fff;
    /* box-shadow: 0 4px 10px rgba(0,0,0,0.1); */
    border-radius: 5px;
    z-index: 999;
    padding: 0px 0;
}

.ul-category-dropdown:hover .dropdown-menu {
    display: block;
}

.dropdown-item {
    width: 100%;
    text-align: left;
    background: none;
    border: none;
    padding: 0px 20px;
    font-size: 14px;
    cursor: pointer;
    color: #333;
}

.dropdown-item:hover {
    background-color: #f0f0f0;
}

</style>




                                <div class="has-sub-menu has-mega-menu">
                                    <!-- <a role="button">Pages</a> -->

                                    <div class="ul-header-submenu ul-header-megamenu">
                                        <div class="single-col">
                                            <span class="single-col-title">Inner Pages</span>
                                            <ul>
                                                <li><a href="/about">About</a></li>
                                                <li><a href="blog.html">Blogs</a></li>
                                                <li><a href="blog-2.html">Blogs Layout 2</a></li>
                                                <li><a href="blog-details.html">Blog Details</a></li>
                                                <li><a href="contact.html">Contact</a></li>
                                                <li><a href="faq.html">FAQ</a></li>
                                                <li><a href="our-store.html">Our Store</a></li>
                                                <li><a href="reviews.html">Reviews</a></li>
                                                <li><a href="/login">Log In</a></li>
                                                <li><a href="signup.html">Sign Up</a></li>
                                            </ul>
                                        </div>

                                        <div class="single-col">
                                            <span class="single-col-title">Shop Pages</span>
                                            <ul>
                                                <li><a href="shop.html">Shop Left Sidebar</a></li>
                                                <li><a href="shop-right-sidebar.html">Shop Right Sidebar</a></li>
                                                <li><a href="shop-no-sidebar.html">Shop Full Width</a></li>
                                                <li><a href="shop-details.html">Shop Details</a></li>
                                                <li><a href="wishlist.html">Wishlist</a></li>
                                                <li><a href="cart.html">Cart</a></li>
                                                <li><a href="checkout.html">Checkout</a></li>
                                            </ul>
                                        </div>

                                        <div class="single-col">
                                            <span class="single-col-title">Men's</span>
                                            <ul>
                                                <li><a href="index.html#">Clothing</a></li>
                                                <li><a href="index.html#">Footwear</a></li>
                                                <li><a href="index.html#">Accessories</a></li>
                                                <li><a href="index.html#">Activewear</a></li>
                                                <li><a href="index.html#">Grooming</a></li>
                                                <li><a href="index.html#">Ethnic Wear</a></li>
                                            </ul>
                                        </div>

                                        <div class="single-col">
                                            <span class="single-col-title">Women's</span>
                                            <ul>
                                                <li><a href="index.html#">Clothing</a></li>
                                                <li><a href="index.html#">Footwear</a></li>
                                                <li><a href="index.html#">Bags & Accessories</a></li>
                                                <li><a href="index.html#">Activewear</a></li>
                                                <li><a href="index.html#">Beauty & Grooming</a></li>
                                                <li><a href="index.html#">Ethnic Wear</a></li>
                                            </ul>
                                        </div>

                                        <div class="single-col">
                                            <span class="single-col-title">Children's</span>
                                            <ul>
                                                <li><a href="index.html#">Clothing</a></li>
                                                <li><a href="index.html#">Footwear</a></li>
                                                <li><a href="index.html#">Accessories</a></li>
                                                <li><a href="index.html#">Toys & Games</a></li>
                                                <li><a href="index.html#">Baby Essentials</a></li>
                                            </ul>
                                        </div>

                                        <div class="single-col">
                                            <span class="single-col-title">Jewellery</span>
                                            <ul>
                                                <li><a href="index.html#">Ethnic & Traditional Jewellery</a></li>
                                                <li><a href="index.html#">Bridal Jewellery</a></li>
                                                <li><a href="index.html#">Bracelets</a></li>
                                                <li><a href="index.html#">Rings</a></li>
                                                <li><a href="index.html#">Earrings</a></li>
                                                <li><a href="index.html#">Chains & Pendants</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </nav>
                        </div>
                    </div>

                    <!-- actions -->
                    <div class="ul-header-actions">
                        <button class="ul-header-mobile-search-opener d-xxl-none"><i class="flaticon-search-interface-symbol"></i></button>
                        
                       @auth
<div class="dropdown">
    <a href="#" class="dropdown-toggle d-flex align-items-center gap-1" data-bs-toggle="dropdown" aria-expanded="false">
        <i class="flaticon-user"></i>
        <span>{{ Auth::user()->username }}</span>
    </a>
    <ul class="dropdown-menu dropdown-menu-end">
        <!-- <li>
            <a class="dropdown-item" href="/profile">{{ Auth::user()->name }}</a>
        </li> -->
        <li>
            <form method="POST" action="{{ route('logout') }}">
                @csrf
                <button class="dropdown-item" type="submit">Logout</button>
            </form>
        </li>
    </ul>
</div>
@else
<a href="/login"><i class="flaticon-user"></i></a>
@endauth

                     <a href="/wishlist" class="wishlist-link">
    <i class="flaticon-heart"></i>
    <span class="wishlist-count">{{ \App\Models\Wishlist::getCount() }}</span>
</a>
<a href="/cart" class="cart-link">
    <i class="flaticon-shopping-bag"></i>
    <span class="cart-count">{{ \App\Models\Cart::getCount() }}</span>
</a>
                    </div>

                    <!-- sidebar opener -->
                    <div class="d-inline-flex">
                        <button class="ul-header-sidebar-opener"><i class="flaticon-hamburger"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!-- HEADER SECTION END -->







  