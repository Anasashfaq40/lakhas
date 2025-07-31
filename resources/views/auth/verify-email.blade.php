@extends('layouts.frontendlinks')

@section('content')
<div class="container">
    <h2>Please Verify Your Email Address</h2>
    <p>We’ve sent a verification link to your email. Please check and verify before continuing.</p>

    @if (session('message'))
        <div class="alert alert-success mt-3">
            {{ session('message') }}
        </div>
    @endif

    <form method="POST" action="{{ route('verification.send') }}">
        @csrf
        <button type="submit">Resend Verification Email</button>
    </form>
</div>
@endsection
