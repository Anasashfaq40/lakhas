@extends('layouts.frontendlinks')

@section('title', 'Thank You')

@section('content')
<div class="container py-5">
    <div class="text-center">
        <h1 class="display-4 text-success">Thank You!</h1>
        <p class="lead mt-3">Your order has been placed successfully.</p>
        <p>We will contact you shortly and keep you updated.</p>

        @if(session('success'))
            <div class="alert alert-success mt-3">
                {{ session('success') }}
            </div>
        @endif

        <a href="{{ route('home') }}" class="btn btn-primary mt-4">Go Back to Home</a>
    </div>
</div>
@endsection
