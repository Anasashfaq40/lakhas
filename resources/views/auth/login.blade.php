@extends('layouts.frontendlinks')
@section('title', __('translate.Sign_in'))
@section('content')

<main>
    <!-- BREADCRUMB SECTION START -->
    <div class="ul-container">
        <div class="ul-breadcrumb">
            <h2 class="ul-breadcrumb-title">{{ __('translate.Sign_in') }}</h2>
            <div class="ul-breadcrumb-nav">
                <a href="{{ url('/') }}"><i class="flaticon-home"></i> Home</a>
                <i class="flaticon-arrow-point-to-right"></i>
                <span class="current-page">{{ __('translate.Sign_in') }}</span>
            </div>
        </div>
    </div>
    <!-- BREADCRUMB SECTION END -->

    <!-- LOGIN SECTION -->
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
                        <form class="theme-form ul-contact-form" id="form_login" method="POST" action="{{ route('login') }}">
                            @csrf
                            <h4>{{ __('translate.Sign_in_to_account') }}</h4>
                            <p>{{ __('translate.Enter_your_email_password_to_login') }}</p>

                            <!-- Email -->
                            <div class="form-group m-b-10">
                                <label class="col-form-label">{{ __('translate.Email_Address') }}</label>
                                <input class="form-control @error('email') is-invalid @enderror" type="email" placeholder="Example@Example.com"
                                       name="email" value="{{ old('email') }}" autocomplete="email" autofocus>
                                @if ($errors->has('email'))
                                    <span class="text-danger">{{ $errors->first('email') }}</span>
                                @elseif ($errors->has('status'))
                                    <span class="text-danger">{{ $errors->first('status') }}</span>
                                @endif
                            </div>

                            <!-- Password -->
                            <div class="form-group m-b-10">
    <label class="col-form-label">{{ __('translate.Password') }}</label>
    <div class="form-input position-relative">
        <input id="passwordField" class="form-control @error('password') is-invalid @enderror" 
               type="password" placeholder="*********" name="password" required autocomplete="current-password">

        <!-- Eye Icon Button -->
        <span class="position-absolute" onclick="togglePassword()" 
              style="top: 50%; right: 10px; transform: translateY(-50%); cursor: pointer;">
            <i id="eyeIcon" class="fa fa-eye"></i>
        </span>

        @if ($errors->has('password'))
            <span class="text-danger">{{ $errors->first('password') }}</span>
        @endif
    </div>
</div>

<!-- JS for toggling password visibility -->
<script>
    function togglePassword() {
        const passwordField = document.getElementById("passwordField");
        const eyeIcon = document.getElementById("eyeIcon");

        if (passwordField.type === "password") {
            passwordField.type = "text";
            eyeIcon.classList.remove("fa-eye");
            eyeIcon.classList.add("fa-eye-slash");
        } else {
            passwordField.type = "password";
            eyeIcon.classList.remove("fa-eye-slash");
            eyeIcon.classList.add("fa-eye");
        }
    }
</script>


                            <!-- Remember Me -->
                            <div class="form-group mb-0">
                                <div class="checkbox p-0">
                                    <input id="checkbox1" type="checkbox" name="remember">
                                    <label class="text-muted" for="checkbox1">{{ __('translate.Remember_password') }}</label>
                                </div> -->

                                <!-- Submit Button -->
                                <div class="mt-3">
                                    <button id="btn_submit" class="btn btn-primary w-100">{{ __('translate.Sign_in') }}</button>
                                </div>

                                <!-- Forgot & Register Links -->
                                <div class="mt-3 text-center">
                                    <a href="{{ route('password.request') }}" class="link text-danger">{{ __('translate.Forgot_Password') }}</a>
                                </div>

                                <p class="text-center mt-2">
                                    <a href="/register">Create Account</a>
                                </p>

                                <!-- <div class="mt-5 text-center">
                                    <h5 class="fw-bold text-primary">© Copyright by Driestech</h5>
                                </div> -->
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Scripts -->
@push('scripts')
<script src="{{ asset('/assets/js/jquery.js') }}"></script>
<script src="{{ asset('/assets/js/popper.min.js') }}"></script>
<script src="{{ asset('/assets/js/bootstrap.min.js') }}"></script>
<script src="{{ asset('/assets/js/scripts.js') }}"></script>
<script src="{{ asset('/assets/js/custom.js') }}"></script>

<script>
    $(function () {
        $("#form_login").one("submit", function () {
            $("#btn_submit").prop('disabled', true);
        });
    });
</script>
@endpush

@endsection
