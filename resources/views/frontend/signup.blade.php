@extends('layouts.frontend')
@section('title', 'Signup')
@section('content')
  <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Sign Up</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i>Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Sign Up</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <div class="ul-container">
            <div class="ul-inner-page-container">
                <div class="row justify-content-evenly align-items-center flex-column-reverse flex-md-row">
                    <div class="col-md-5">
                        <div class="ul-login-img text-center">
                            <img src="assets/img/delivery/login.jpg" alt="Login Image">
                        </div>
                    </div>

                    <div class="col-xl-4 col-md-7">
                        <form action="signup.html#" class="ul-contact-form">
                            <div class="row">
                                <!-- firstname -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="text" name="firstname" id="firstname" placeholder="First Name">
                                    </div>
                                </div>

                                <!-- lastname -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="text" name="lastname" id="lastname" placeholder="Last Name">
                                    </div>
                                </div>

                                <!-- phone -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="tel" name="phone-number" id="phone-number" placeholder="Phone Number">
                                    </div>
                                </div>

                                <!-- email -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="email" name="email" id="email" placeholder="Enter Email Address">
                                        <span class="field-icon"><i class="flaticon-email"></i></span>
                                    </div>
                                </div>

                                <!-- password -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="password" name="password" id="password" placeholder="Enter Password">
                                        <span class="field-icon"><i class="flaticon-lock"></i></span>
                                    </div>
                                </div>

                                <!-- CONFIRM PASSWORD -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="password" name="confirm-password" id="confirm-password" placeholder="Confirm Password">
                                        <span class="field-icon"><i class="flaticon-lock"></i></span>
                                    </div>
                                </div>
                            </div>
                            <!-- submit btn -->
                            <button type="submit">Sign Up</button>
                        </form>

                        <p class="text-center mt-4 mb-0">Already have an account? <a href="login.html">Log In</a></p>
                    </div>
                </div>
            </div>
        </div>
    </main>
@endsection