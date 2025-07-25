@extends('layouts.frontend')
@section('title', 'Our-Store')
@section('content')
 <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Our Store</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Our Store</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <!-- STORE SECTION START -->
        <section class="ul-store">
            <div class="ul-inner-page-container">
                <div class="row g-lg-5 g-4 row-cols-sm-2 row-cols-1 align-items-center">
                    <!-- txt -->
                    <div class="col">
                        <div class="ul-store-txt">
                            <span class="ul-section-sub-title">Main Outlet</span>
                            <h2 class="ul-section-title">Visit The Lakhas - Karachi Store</h2>
                            <div class="ul-store-infos">
                                <div class="ul-store-info">
                                    <span class="key">Address: </span>
                                    <span>Shop No. UG 29-A Upper Ground Floor. Silk Mall, Near Bahadurabad Main Shaheed-e-Milat Road,, Karachi, Pakistan</span>
                                </div>

                                <div class="ul-store-info">
                                    <span class="key">Opening Hour's: </span>
                                    <span>Monday – Saturday: 11:00 AM – 9:00 PM<br>Sunday: Closed</span>
                                </div>

                                <div class="ul-store-info">
                                    <span class="key">Phone number: </span>
                                    <a href="tel:+12365478009">+92 300 3774062</a>
                                </div>
                            </div>

                            <a href="our-store.html#" class="ul-store-btn">View Location</a>
                        </div>
                    </div>

                    <!-- img -->
                    <div class="col">
                        <div class="ul-store-img">
                            <img src="assets/img/delivery/store.png" alt="store image">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- STORE SECTION END -->


        <!-- STORE SECTION START -->
        
        <!-- STORE SECTION END -->


        <!-- GALLERY SECTION START -->
        <div class="ul-gallery ul-inner-page-gallery overflow-hidden mx-auto">
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
@endsection