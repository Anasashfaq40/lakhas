@extends('layouts.frontendlinks')
@section('title', 'Signup')
@section('content')
<main>
    <!-- BREADCRUMB SECTION START -->
    <div class="ul-container">
        <div class="ul-breadcrumb">
            <h2 class="ul-breadcrumb-title">Sign Up</h2>
            <div class="ul-breadcrumb-nav">
                <a href="{{ url('/') }}"><i class="flaticon-home"></i>Home</a>
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
                        <img src="{{ asset('assets/img/delivery/login.jpg') }}" alt="Login Image">
                    </div>
                </div>

                <div class="col-xl-4 col-md-7">
                    <form action="{{ route('signup.store') }}" method="POST" class="ul-contact-form">
                        @csrf

                        <!-- firstname -->
                        <div class="form-group">
                            <input type="text" name="firstname" placeholder="First Name" value="{{ old('firstname') }}">
                        </div>

                        <!-- lastname -->
                        <div class="form-group">
                            <input type="text" name="lastname" placeholder="Last Name" value="{{ old('lastname') }}">
                        </div>

                        <!-- email -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="email" name="email" placeholder="Enter Email Address" value="{{ old('email') }}">
                                <span class="field-icon"><i class="flaticon-email"></i></span>
                            </div>
                        </div>

                        <!-- password -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="password" name="password" placeholder="Enter Password">
                                <span class="field-icon"><i class="flaticon-lock"></i></span>
                            </div>
                        </div>

                        <!-- confirm password -->
                        <div class="form-group">
                            <div class="position-relative">
                                <input type="password" name="password_confirmation" placeholder="Confirm Password">
                                <span class="field-icon"><i class="flaticon-lock"></i></span>
                            </div>
                        </div>

                        <!-- submit btn -->
                        <button type="submit">Sign Up</button>
                    </form>

                    <p class="text-center mt-4 mb-0">Already have an account? <a href="/login">Log In</a></p>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Toast alerts -->
@if (session('success'))
<script>
    setTimeout(() => {
        alert("{{ session('success') }}");
    }, 500);
</script>
@endif

@if ($errors->any())
<script>
    setTimeout(() => {
        alert("{{ $errors->first() }}");
    }, 500);
</script>
@endif
@endsection
