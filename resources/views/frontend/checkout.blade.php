@extends('layouts.frontendlinks')
@section('title', 'Checkout')
@section('content')
  <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Checkout</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Checkout</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->

        <!-- CHEKOUT SECTION START -->
        <div class="ul-cart-container">
            <h3 class="ul-checkout-title">Billing Details</h3>
            <form action="{{ route('checkout.placeorder') }}" method="POST" class="ul-checkout-form">
    @csrf

                <div class="row ul-bs-row row-cols-2 row-cols-xxs-1">
                    <!-- left side / checkout form -->
                    <div class="col">
                        <div class="row row-cols-lg-2 row-cols-1 ul-bs-row">
                            <!-- first name -->
                            <div class="form-group">
                                <label for="firstname">First Name*</label>
                                <input type="text" name="firstname" id="firstname" placeholder="Enter Your First Name">
                            </div>

                            <!-- last name -->
                            <div class="form-group">
                                <label for="lastname">Last Name*</label>
                                <input type="text" name="lastname" id="lastname" placeholder="Enter Your First Name">
                            </div>

                            <!-- company name -->
                            <div class="form-group">
                                <label for="companyname">Company Name</label>
                                <input type="text" name="companyname" id="companyname" placeholder="Enter Your Company Name">
                            </div>

                            <!-- country -->
                            <div class="form-group ul-checkout-country-wrapper">
                                <label for="ul-checkout-country">Country*</label>
                                <select name="country" id="ul-checkout-country">
                                    <option data-placeholder="true">Select Country</option>
                                    <option value="2">Pakistan</option>
                                    <!-- <option value="3">United Kingdom</option>
                                    <option value="4">Germany</option>
                                    <option value="5">France</option>
                                    <option value="6">India</option> -->
                                </select>
                            </div>

                            <!-- address 1 -->
                            <div class="form-group">
                                <label for="address1">Street Address*</label>
                                <input type="text" name="address1" id="address1" placeholder="1837 E Homer M Adams Pkwy">
                            </div>

                            <!-- address 2 -->
                            <div class="form-group">
                                <label for="address2">Address 2*</label>
                                <input type="text" name="address2" id="address2" placeholder="1837 E Homer M Adams Pkwy">
                            </div>

                            <!-- city -->
                            <div class="form-group">
                                <label for="city">City or Town*</label>
                                <input type="text" name="city" id="city" placeholder="Enter Your City or Town">
                            </div>

                            <!-- state -->
                            <div class="form-group">
                                <label for="state">State*</label>
                                <input type="text" name="state" id="state" placeholder="Enter Your State">
                            </div>

                            <!-- postcode -->
                            <div class="form-group">
                                <label for="zipcode">ZIP Code*</label>
                                <input type="text" name="zipcode" id="zipcode" placeholder="Enter Your Postcode">
                            </div>

                            <!-- phone -->
                            <div class="form-group">
                                <label for="phone">Phone*</label>
                                <input type="text" name="phone" id="phone" placeholder="Enter Your Phone Number">
                            </div>

                            <!-- email -->
                            <div class="form-group col-lg-12">
                                <label for="email">Email Address*</label>
                                <input type="email" name="email" id="email" placeholder="Enter Your Email">
                            </div>
                        </div>

                    </div>

                    <!-- right side section / different address -->
                    <div class="col">
                        <div class="form-group">
                            <label for="ul-checkout-different-address-field">Shift to A Different Address</label>
                            <textarea name="different-address" id="ul-checkout-different-address-field" placeholder="2801 Lafayette Blvd, Norfolk, Vermont 23509, united state"></textarea>
                        </div>

                        <!-- right side section / different address checkbox -->
                        <div class="ul-checkout-payment-methods">
                            <div class="form-group">
                                <label for="payment-option-1">
                                    <input type="radio" name="payment-methods" id="payment-option-1" hidden checked>
                                    <span class="ul-radio-wrapper"></span>
                                    <span class="ul-checkout-payment-method">
                                        <span class="title">Direct Bank Transfer</span>
                                        <span class="descr">After placing your order, you will receive our bank details. Please make the payment and share the receipt on WhatsApp or our Facebook page. Your order will be confirmed once the payment is verified.</span>
                                    </span>
                                </label>
                            </div>

                            <div class="form-group">
                                <label for="payment-option-2">
                                    <input type="radio" name="payment-methods" id="payment-option-2" hidden>
                                    <span class="ul-radio-wrapper"></span>
                                    <span class="ul-checkout-payment-method">
                                        <span class="title"> Want to send this order as a gift or to another location? Select this option and add the recipient’s delivery details at checkout.</span>
                                    </span>
                                </label>
                            </div>
                            <button type="submit" class="ul-checkout-form-btn">Place Your Order</button>
                        </div>
                    </div>
                </div>
            </form>

<!-- bill summary -->
<div class="row ul-bs-row row-cols-2 row-cols-xxs-1">
    <div class="ul-checkout-bill-summary">
        <h4 class="ul-checkout-bill-summary-title">Your Order</h4>

        <div class="ul-checkout-bill-summary-body">
            @php $total = 0; @endphp

            @foreach ($cartItems as $item)
                @php
                    $product = $item->product;
                    $subtotal = $item->price * $item->quantity;
                    $total += $subtotal;
                @endphp

                <div class="single-row d-flex align-items-center mb-3" style="gap: 10px;">
                    <div style="width: 70px; height: 70px; overflow: hidden; border-radius: 8px;">
                        <img src="{{ asset('images/products/' . $product->image) }}"
                             alt="{{ $product->title }}"
                             style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                    <div class="flex-grow-1">
                        <div style="font-weight: bold;">{{ $product->name }}</div>
                        <div>Quantity: {{ $item->quantity }}</div>
                        <div>Price: ${{ number_format($item->price, 2) }}</div>
                        <div>Subtotal: ${{ number_format($subtotal, 2) }}</div>
                    </div>
                </div>
            @endforeach

            <hr>

            <div class="single-row">
                <span class="left">Sub Total</span>
                <span class="right">${{ number_format($total, 2) }}</span>
            </div>

            <div class="single-row">
                <span class="left">Shipping</span>
                <span class="right">Free</span>
            </div>
        </div>

        <div class="ul-checkout-bill-summary-footer ul-checkout-bill-summary-header mt-3">
            <span class="left">Total</span>
            <span class="right">${{ number_format($total, 2) }}</span>
        </div>
    </div>
</div>


                    </div>
                </div>
            </div>
        </div>
        <!-- CHEKOUT SECTION END -->
    </main>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    $(document).ready(function () {
        @if ($errors->any())
            @foreach ($errors->all() as $error)
                toastr.error("{{ $error }}");
            @endforeach
        @endif

        @if (session('success'))
            toastr.success("{{ session('success') }}");
        @endif

        @if (session('error'))
            toastr.error("{{ session('error') }}");
        @endif
    });
</script>

@endsection


