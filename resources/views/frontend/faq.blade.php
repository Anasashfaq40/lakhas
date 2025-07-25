@extends('layouts.frontend')
@section('title', 'Faq')
@section('content')
 <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Faq</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Faq</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <!-- FAQ SECTION START -->
        <section class="ul-faq">
            <div class="ul-inner-page-container">
                <div class="ul-accordion">
                    <!-- single question -->
                    <div class="ul-single-accordion-item">
                        <div class="ul-single-accordion-item__header">
                            <div class="left">
                                <h3 class="ul-single-accordion-item__title">Do you offer stitching services for unstitched fabric?</h3>
                            </div>
                            <span class="icon"><i class="flaticon-plus"></i></span>
                        </div>

                        <div class="ul-single-accordion-item__body">
                            <p class="mb-0">
                               Yes, The Lakhas provides professional tailoring services. You can bring your own fabric or select from our unstitched collection, and we'll stitch it to your desired size and style.
                            </p>
                        </div>
                    </div>

                    <!-- single question -->
                    <div class="ul-single-accordion-item open">
                        <div class="ul-single-accordion-item__header">
                            <div class="left">
                                <h3 class="ul-single-accordion-item__title">Do you offer delivery outside Karachi?</h3>
                            </div>
                            <span class="icon"><i class="flaticon-plus"></i></span>
                        </div>

                        <div class="ul-single-accordion-item__body">
                            <p class="mb-0">
                               Yes, we offer nationwide delivery across Pakistan. Delivery charges may vary depending on your location and the size of your order.
                            </p>
                        </div>
                    </div>

                    <!-- single question -->
                    <div class="ul-single-accordion-item">
                        <div class="ul-single-accordion-item__header">
                            <div class="left">
                                <h3 class="ul-single-accordion-item__title">How do I find my correct size?</h3>
                            </div>
                            <span class="icon"><i class="flaticon-plus"></i></span>
                        </div>

                        <div class="ul-single-accordion-item__body">
                            <p class="mb-0">
                                 We recommend referring to our size chart available on the product page. For stitched orders, you can also provide your custom measurements at the time of placing your order.
                                </p>
                        </div>
                    </div>

                    <!-- single question -->
                    <div class="ul-single-accordion-item">
                        <div class="ul-single-accordion-item__header">
                            <div class="left">
                                <h3 class="ul-single-accordion-item__title">Can I exchange or return my order?</h3>
                            </div>
                            <span class="icon"><i class="flaticon-plus"></i></span>
                        </div>

                        <div class="ul-single-accordion-item__body">
                            <p class="mb-0">
                               Unstitched items can be exchanged within 3 days if unused. Stitched garments are non-returnable but we do offer size adjustments where possible. Please contact us within 48 hours of delivery for any concerns.
                            </p>
                        </div>
                    </div>

                    <!-- single question -->
                    <div class="ul-single-accordion-item">
                        <div class="ul-single-accordion-item__header">
                            <div class="left">
                                <h3 class="ul-single-accordion-item__title">Do you restock sold-out designs?</h3>
                            </div>
                            <span class="icon"><i class="flaticon-plus"></i></span>
                        </div>

                        <div class="ul-single-accordion-item__body">
                            <p class="mb-0">
                               We restock popular designs regularly. For limited edition or seasonal items, availability may be limited. Follow us on Facebook to stay updated on new arrivals and restocks.
                            </p>
                        </div>
                    </div>

                    <!-- single question -->
                    <div class="ul-single-accordion-item">
                        <div class="ul-single-accordion-item__header">
                            <div class="left">
                                <h3 class="ul-single-accordion-item__title">Can I request custom embroidery or design?</h3>
                            </div>
                            <span class="icon"><i class="flaticon-plus"></i></span>
                        </div>

                        <div class="ul-single-accordion-item__body">
                            <p class="mb-0">
                               Absolutely! We welcome custom design requests including embroidery and styling changes. Share your idea or reference image with us and we’ll make it happen.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- FAQ SECTION END -->
    </main>
@endsection