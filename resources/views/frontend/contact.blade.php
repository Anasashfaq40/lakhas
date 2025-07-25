@extends('layouts.frontendlinks')
@section('title', 'Contact')
@section('content')
  <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Contact Us</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Contact Us</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <!-- CONTACT INFO SECTION START -->
        <section class="ul-contact-infos">
            <!-- single contact info -->
            <div class="ul-contact-info">
                <div class="icon"><i class="flaticon-location"></i></div>
                <div class="txt">
                    <h6 class="title">Our Address</h6>
                    <p class="descr mb-0">Shop No. UG 29-A Upper Ground Floor. Silk Mall, Near Bahadurabad Main Shaheed-e-Milat Road,, Karachi, Pakistan</p>
                </div>
            </div>

            <!-- single contact info -->
            <div class="ul-contact-info">
                <div class="icon"><i class="flaticon-email"></i></div>
                <div class="txt">
                    <h6 class="title">Email Address</h6>
                    <p class="descr mb-0">
                        <a href="mailto:info@ticstube.com">thelakhas2@gmail.com</a>
                        <a href="mailto:contact@ticstube.com">thelakhas2@gmail.com</a>
                    </p>
                </div>
            </div>

            <!-- single contact info -->
            <div class="ul-contact-info">
                <div class="icon"><i class="flaticon-stop-watch-1"></i></div>
                <div class="txt">
                    <h6 class="title">Hours of Operation</h6>
                    <p class="descr mb-0">
                        <span>Saturday: 11 AM – 9 PM</span><br>
                        <span>Sunday: Closed</span>
                    </p>
                </div>
            </div>
        </section>
        <!-- CONTACT INFO SECTION END -->


        <!-- MAP AREA START -->
        <div class="ul-contact-map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3618.250006381354!2d67.0669915145402!3d24.88272285021192!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3eb33ee7e5407e13%3A0x3e6ac2151bd788d2!2sBahadurabad%2C%20Karachi%2C%20Pakistan!5e0!3m2!1sen!2s!4v1654960123456!5m2!1sen!2s" 
            allowfullscreen loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
        <!-- MAP AREA END -->

        <div class="ul-contact-from-section">
            <div class="ul-contact-form-container">
                <h3 class="ul-contact-form-container__title">Get in Touch</h3>
                <form action="contact.html#" class="ul-contact-form">
                    <div class="grid">
                        <!-- firstname -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="text" name="firstname" id="firstname" placeholder="First Name">
                                <span class="field-icon"><i class="flaticon-user"></i></span>
                            </div>
                        </div>

                        <!-- lastname -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="text" name="lastname" id="lastname" placeholder="Last Name">
                                <span class="field-icon"><i class="flaticon-user"></i></span>
                            </div>
                        </div>

                        <!-- phone -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="tel" name="phone-number" id="phone-number" placeholder="Phone Number">
                                <span class="field-icon"><i class="flaticon-user"></i></span>
                            </div>
                        </div>
                        <!-- email -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="email" name="email" id="email" placeholder="Enter Email Address">
                                <span class="field-icon"><i class="flaticon-email"></i></span>
                            </div>
                        </div>
                        <!-- message -->
                        <div class="form-group">
                            <div class="position-relative">
                                <textarea name="message" id="message" placeholder="Write Message..."></textarea>
                                <span class="field-icon"><i class="flaticon-edit"></i></span>
                            </div>
                        </div>
                    </div>
                    <!-- submit btn -->
                    <button type="submit">Send Message</button>
                </form>
            </div>
        </div>
    </main>
@endsection