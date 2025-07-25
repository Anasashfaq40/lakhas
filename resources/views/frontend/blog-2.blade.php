@extends('layouts.frontend')
@section('title', 'Blog-2')
@section('content')
  <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Blog Standard</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Blog Standard</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <!-- BLOG SECTION START -->
        <section>
            <div class="ul-inner-page-container">
                <div class="row ul-bs-row">
                    <div class="col-xxxl-9 col-lg-8 col-md-7">
                        <!-- blogs -->
                        <div>
                            <!-- single blog -->
                            <div class="ul-blog ul-blog-big">
                                <div class="ul-blog-img">
                                    <img src="assets/img/blog-big-img-1.jpg" alt="Blog Image">

                                    <div class="date">
                                        <span class="number">15</span>
                                        <span class="txt">July</span>
                                    </div>
                                </div>

                                <div class="ul-blog-txt">
                                    <div class="ul-blog-infos flex gap-x-[30px] mb-[16px]">
                                        <!-- single info -->
                                        <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-user-2"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">By Admin</span>
                                        </div>
                                        <!-- single info -->
                                        <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-calendar"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">Jun 12, 2024</span>
                                        </div>
                                    </div>

                                   <h3 class="ul-blog-title"><a href="blog-details.html">Why Tailored Outfits Still Rule Men’s Fashion in 2025</a></h3>
                                    <p class="ul-blog-descr">
                                        In an age of fast fashion, tailored clothing still stands out for its class and fit. Discover why a custom-stitched suit or a perfectly tailored shalwar kameez from The Lakhas offers more than just style — it offers personality.
                                     </p>

                                    <a href="blog-details.html" class="ul-blog-btn ul-blog-big-btn">Read More <span class="icon"><i class="flaticon-up-right-arrow"></i></span></a>
                                </div>
                            </div>

                            <!-- single blog -->
                            <div class="ul-blog ul-blog-big">
                                <div class="ul-blog-img">
                                    <img src="assets/img/blog-big-img-2.jpg" alt="Blog Image">

                                    <div class="date">
                                        <span class="number">15</span>
                                        <span class="txt">July</span>
                                    </div>
                                </div>

                                <div class="ul-blog-txt">
                                    <div class="ul-blog-infos flex gap-x-[30px] mb-[16px]">
                                        <!-- single info -->
                                        <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-user-2"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">By Admin</span>
                                        </div>
                                        <!-- single info -->
                                        <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-calendar"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">Jun 12, 2025</span>
                                        </div>
                                    </div>

                                    <h3 class="ul-blog-title"><a href="blog-details.html">Unstitched or Stitched: What’s Right for Your Style?</a></h3>
                                    <p class="ul-blog-descr">
                                        Whether you're going traditional or modern, the choice between stitched and unstitched wear makes a big difference. Explore how The Lakhas helps you decide the perfect fabric, cut, and fit for every occasion.
                                     </p>

                                    <a href="blog-details.html" class="ul-blog-btn ul-blog-big-btn">Read More <span class="icon"><i class="flaticon-up-right-arrow"></i></span></a>
                                </div>
                            </div>

                            <!-- single blog -->
                            <div class="ul-blog ul-blog-big">
                                <div class="ul-blog-img">
                                    <img src="assets/img/blog-big-img-3.jpg" alt="Blog Image">

                                    <div class="date">
                                        <span class="number">15</span>
                                        <span class="txt">July</span>
                                    </div>
                                </div>

                                <div class="ul-blog-txt">
                                    <div class="ul-blog-infos flex gap-x-[30px] mb-[16px]">
                                        <!-- single info -->
                                        <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-user-2"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">By Admin</span>
                                        </div>
                                        <!-- single info -->
                                        <div class="ul-blog-info">
                                            <span class="icon"><i class="flaticon-calendar"></i></span>
                                            <span class="text font-normal text-[14px] text-etGray">Jun 12, 2025</span>
                                        </div>
                                    </div>

                                    <h3 class="ul-blog-title"><a href="blog-details.html">Top 5 Must-Have Gents Accessories for 2025</a></h3>
                                    <p class="ul-blog-descr"> 
                                        It's not just about the outfit — it’s about the details. From Islamic caps to subtle touches like cufflinks and collar buttons, here's how to complete your look like a true gentleman with The Lakhas' latest accessories.
                                         </p>

                                    <a href="blog-details.html" class="ul-blog-btn ul-blog-big-btn">Read More <span class="icon"><i class="flaticon-up-right-arrow"></i></span></a>
                                </div>
                            </div>
                        </div>

                        <!-- pagination -->
                        <div class="ul-pagination pt-0 border-0">
                            <ul class="justify-content-start">
                                <li><a href="blog-2.html#"><i class="flaticon-left-arrow"></i></a></li>
                                <li class="pages">
                                    <a href="blog-2.html#" class="active">01</a>
                                    <a href="blog-2.html#">02</a>
                                    <a href="blog-2.html#">03</a>
                                    <a href="blog-2.html#">04</a>
                                    <a href="blog-2.html#">05</a>
                                </li>
                                <li><a href="blog-2.html#"><i class="flaticon-arrow-point-to-right"></i></a></li>
                            </ul>
                        </div>
                    </div>

                    <!-- sidebar -->
                    <div class="col-xxxl-3 col-lg-4 col-md-5">
                        <div class="ul-blog-sidebar">
                            <!-- single widget /search -->
                            <div class="ul-blog-sidebar-widget ul-blog-sidebar-search">
                                <div class="ul-blog-sidebar-widget-content">
                                    <form action="blog-2.html#" class="ul-blog-search-form">
                                        <input type="search" name="blog-search" id="ul-blog-search" placeholder="Search Here">
                                        <button type="submit"><span class="icon"><i class="flaticon-search-interface-symbol"></i></span></button>
                                    </form>
                                </div>
                            </div>

                            <!-- single widget / Recent Posts -->
                            <div class="ul-blog-sidebar-widget ul-blog-sidebar-recent-post">
                                <h3 class="ul-blog-sidebar-widget-title">Recent Posts</h3>
                                <div class="ul-blog-sidebar-widget-content">
                                    <div class="ul-blog-recent-posts">
                                        <!-- single post -->
                                        <div class="ul-blog-recent-post">
                                            <div class="img">
                                                <img src="assets/img/blog-2.jpg" alt="Post Image">
                                            </div>

                                            <div class="txt">
                                                <span class="date">
                                                    <span class="icon"><i class="flaticon-calendar"></i></span>
                                                    <span>May 12, 2025</span>
                                                </span>

                                                <h4 class="title"><a href="blog-details.html">How to Choose the Right Shalwar Kameez for Every Occasion</a></h4>
                                            </div>
                                        </div>

                                        <!-- single post -->
                                        <div class="ul-blog-recent-post">
                                            <div class="img">
                                                <img src="assets/img/blog-3.jpg" alt="Post Image">
                                            </div>

                                            <div class="txt">
                                                <span class="date">
                                                    <span class="icon"><i class="flaticon-calendar"></i></span>
                                                    <span>May 12, 2025</span>
                                                </span>

                                                <h4 class="title"><a href="blog-details.html">5 Style Tips Every Gentleman Should Know</a></h4>
                                            </div>
                                        </div>

                                        <!-- single post -->
                                        <div class="ul-blog-recent-post">
                                            <div class="img">
                                                <img src="assets/img/blog-1.jpg" alt="Post Image">
                                            </div>

                                            <div class="txt">
                                                <span class="date">
                                                    <span class="icon"><i class="flaticon-calendar"></i></span>
                                                    <span>May 12, 2025</span>
                                                </span>

                                                <h4 class="title"><a href="blog-details.html">Tailoring Guide: Turning Unstitched into Style</a></h4>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- single widget / Recommended Topics -->
                            <div class="ul-blog-sidebar-widget ul-blog-sidebar-recent-post">
                                <h3 class="ul-blog-sidebar-widget-title">Recommended Topics</h3>
                                <div class="ul-blog-sidebar-widget-content">
                                    <div class="ul-blog-tags">
                                        <a href="blog-2.html">Accessories</a>
                                        <a href="blog-2.html">Fashion</a>
                                        <a href="blog-2.html">Blog</a>
                                        <a href="blog-2.html">Lifestyle</a>
                                        <a href="blog-2.html">Tadatheme</a>
                                    </div>
                                </div>
                            </div>

                            <div class="ul-blog-sidebar-widget ad-banner">
                                <a href="shop.html"><img src="assets/img/gallery-item-4.jpg" alt="ad banner"></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- BLOG SECTION END -->
    </main>
@endsection