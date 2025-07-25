@extends('layouts.frontendlinks')
@section('title', 'Login')
@section('content')
<main>
    <!-- BREADCRUMB SECTION START -->
    <div class="ul-container">
        <div class="ul-breadcrumb">
            <h2 class="ul-breadcrumb-title">Log In</h2>
            <div class="ul-breadcrumb-nav">
                <a href="{{ url('/') }}"><i class="flaticon-home"></i> Home</a>
                <i class="flaticon-arrow-point-to-right"></i>
                <span class="current-page">Log In</span>
            </div>
        </div>
    </div>
    <!-- BREADCRUMB SECTION END -->

    <div class="ul-container">
        <div class="ul-login">
            <div class="ul-inner-page-container">
                <div class="row justify-content-evenly align-items-center flex-column-reverse flex-md-row">
                    <div class="col-md-5">
                        <div class="ul-login-img text-center">
                            <img src="{{ asset('assets/img/delivery/login.jpg') }}" alt="Login Image">
                        </div>
                    </div>

                    <div class="col-xl-4 col-md-7">
                        <form method="POST" action="{{ route('login') }}" class="ul-contact-form">
                            @csrf

                            <div class="row">
                                <!-- Email -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="email" name="email" id="email" value="{{ old('email') }}"
                                            placeholder="Enter Email Address"
                                            class="@error('email') is-invalid @enderror">
                                        @error('email')
                                            <small class="text-danger d-block mt-1">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="form-group">
                                    <div class="position-relative">
                                        <input type="password" name="password" id="password"
                                            placeholder="Enter Password"
                                            class="@error('password') is-invalid @enderror">
                                        @error('password')
                                            <small class="text-danger d-block mt-1">{{ $message }}</small>
                                        @enderror
                                    </div>
                                </div>
                            </div>

                            <!-- Submit Button -->
                            <button type="submit">Log In</button>
                        </form>

                     

                        <p class="text-center mt-2">
                            <a href="{{ route('password.request') }}">Forgot your password?</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
@endsection
