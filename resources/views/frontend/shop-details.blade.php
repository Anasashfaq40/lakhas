@extends('layouts.frontendlinks')
@section('title', 'Shop-Details')
@section('content')
<main>
    <!-- BREADCRUMB SECTION START -->
    <div class="ul-container">
        <div class="ul-breadcrumb">
            <h2 class="ul-breadcrumb-title">Shop Details</h2>
            <div class="ul-breadcrumb-nav">
                <a href="#"><i class="flaticon-home"></i> Home</a>
                <i class="flaticon-arrow-point-to-right"></i>
                <a href="#">Shop</a>
                <i class="flaticon-arrow-point-to-right"></i>
                <span class="current-page">{{ $product->name }}</span>
            </div>
        </div>
    </div>
    <!-- BREADCRUMB SECTION END -->

    <!-- MAIN CONTENT SECTION START -->
    <div class="ul-inner-page-container">
        <div class="ul-product-details">
            <div class="ul-product-details-top">
                <div class="row ul-bs-row row-cols-lg-2 row-cols-1 align-items-center">
                    <!-- img -->
                    <div class="col">
                        <div class="ul-product-details-img">
                            <div class="ul-product-details-img-slider swiper">
                                <div class="swiper-wrapper">
                                    <!-- main product image -->
                                    <div class="swiper-slide">
                                        <img src="{{ asset('images/products/'.$product->image) }}" alt="{{ $product->name }}">
                                    </div>
                                    
                                    <!-- additional product images -->
                                    @foreach($product->images as $image)
                                    <div class="swiper-slide">
                                        <img src="{{ asset('images/products/multiple/'.$image->image) }}" alt="{{ $product->name }}">
                                    </div>
                                    @endforeach
                                </div>

                                <div class="ul-product-details-img-slider-nav" id="ul-product-details-img-slider-nav">
                                    <button class="prev"><i class="flaticon-left-arrow"></i></button>
                                    <button class="next"><i class="flaticon-arrow-point-to-right"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- txt -->
                    <div class="col">
                        <div class="ul-product-details-txt">
                            <!-- product rating -->
                            <div class="ul-product-details-rating">
                                <span class="rating">
                                    <i class="flaticon-star"></i>
                                    <i class="flaticon-star"></i>
                                    <i class="flaticon-star"></i>
                                    <i class="flaticon-star"></i>
                                    <i class="flaticon-star"></i>
                                </span>
                                <span class="review-number">{{ $product->reviews->count() }} Customer Reviews</span>
                            </div>

                            <!-- price with data attributes -->
                            <span class="ul-product-details-price" 
                                  id="product-price"
                                  data-price="{{ $product->price }}"
                                  @if($product->is_promo && now()->between($product->promo_start_date, $product->promo_end_date))
                                      data-promo="true"
                                      data-promo-price="{{ $product->promo_price }}"
                                  @else
                                      data-promo="false"
                                  @endif>
                                PKR <span id="price-value">
                                    @if($product->is_promo && now()->between($product->promo_start_date, $product->promo_end_date))
                                        {{ number_format($product->promo_price, 2) }}
                                    @else
                                        {{ number_format($product->price, 2) }}
                                    @endif
                                </span>
                                @if($product->is_promo && now()->between($product->promo_start_date, $product->promo_end_date))
                                    <span class="old-price" id="old-price-value">PKR {{ number_format($product->price, 2) }}</span>
                                @endif
                            </span>

                            <!-- product title -->
                            <h3 class="ul-product-details-title">{{ $product->name }}</h3>

                            <!-- product description -->
                            <p class="ul-product-details-descr">{{ $product->note ?? 'No description available' }}</p>

                            <!-- product options -->
                            @if($product->isGarment())
                            <div class="ul-product-details-options">
                                @if($product->available_sizes)
                                <div class="ul-product-details-option ul-product-details-sizes">
                                    <span class="title">Size</span>
                                    <form action="#" class="variants">
                                        @foreach(json_decode($product->available_sizes) as $size)
                                        <label for="ul-product-details-size-{{ $loop->index }}">
                                            <input type="radio" name="product-size" id="ul-product-details-size-{{ $loop->index }}" {{ $loop->first ? 'checked' : '' }} hidden>
                                            <span class="size-btn">{{ $size }}</span>
                                        </label>
                                        @endforeach
                                    </form>
                                </div>
                                @endif

                                <div class="ul-product-details-option ul-product-details-colors">
                                    <span class="title">Color</span>
                                    <form action="#" class="variants">
                                        <label for="ul-product-details-color-1">
                                            <input type="radio" name="product-color" id="ul-product-details-color-1" checked hidden>
                                            <span class="color-btn green"></span>
                                        </label>
                                        <label for="ul-product-details-color-2">
                                            <input type="radio" name="product-color" id="ul-product-details-color-2" hidden>
                                            <span class="color-btn blue"></span>
                                        </label>
                                    </form>
                                </div>
                            </div>
                            @endif

                            <!-- product quantity -->
                            <div class="ul-product-details-option ul-product-details-quantity">
                                <span class="title">Quantity</span>
                                <form action="#" class="ul-product-quantity-wrapper">
                                    <input type="number" name="product-quantity" id="ul-product-details-quantity" class="ul-product-quantity" value="1" min="1" readonly>
                                    <div class="btns">
                                        <button type="button" class="quantityIncreaseButton"><i class="flaticon-plus"></i></button>
                                        <button type="button" class="quantityDecreaseButton"><i class="flaticon-minus-sign"></i></button>
                                    </div>
                                </form>
                            </div>

                            <!-- product actions -->
                            <div class="ul-product-details-actions">
                                <div class="left">
                                    <button class="add-to-cart" data-product-id="{{ $product->id }}">Add to Cart <span class="icon"><i class="flaticon-cart"></i></span></button>
                                    <button class="add-to-wishlist" data-product-id="{{ $product->id }}"><span class="icon"><i class="flaticon-heart"></i></span> Add to wishlist</button>
                                </div>
                                <div class="share-options">
                                    <button><i class="flaticon-facebook-app-symbol"></i></button>
                                    <button><i class="flaticon-twitter"></i></button>
                                    <button><i class="flaticon-linkedin-big-logo"></i></button>
                                    <a href="#"><i class="flaticon-youtube"></i></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ul-product-details-bottom">
                <!-- description -->
                <div class="ul-product-details-long-descr-wrapper">
                    <h3 class="ul-product-details-inner-title">Item Description</h3>
                    <p>{{ $product->note ?? 'No detailed description available' }}</p>
                    
                    @if($product->isGarment())
                    <h4>Measurement Details</h4>
                    @if($product->type === 'stitched_garment')
                        @if($product->garment_type === 'shalwar_suit')
                            <h5>Kameez Measurements</h5>
                            <ul>
                                <li>Length: {{ $product->kameez_length ?? 'N/A' }} inches</li>
                                <li>Shoulder: {{ $product->kameez_shoulder ?? 'N/A' }} inches</li>
                                <li>Sleeves: {{ $product->kameez_sleeves ?? 'N/A' }} inches</li>
                            </ul>
                            
                            <h5>Shalwar Measurements</h5>
                            <ul>
                                <li>Length: {{ $product->shalwar_length ?? 'N/A' }} inches</li>
                                <li>Waist: {{ $product->shalwar_waist ?? 'N/A' }} inches</li>
                            </ul>
                        @else
                            <h5>Shirt Measurements</h5>
                            <ul>
                                <li>Length: {{ $product->pshirt_length ?? 'N/A' }} inches</li>
                                <li>Shoulder: {{ $product->pshirt_shoulder ?? 'N/A' }} inches</li>
                            </ul>
                            
                            <h5>Pant Measurements</h5>
                            <ul>
                                <li>Length: {{ $product->pant_length ?? 'N/A' }} inches</li>
                                <li>Waist: {{ $product->pant_waist ?? 'N/A' }} inches</li>
                            </ul>
                        @endif
                    @elseif($product->type === 'unstitched_garment')
                        <ul>
                            <li>Thaan Length: {{ $product->thaan_length ?? 'N/A' }} meters</li>
                            <li>Suit Length: {{ $product->suit_length ?? 'N/A' }} meters</li>
                        </ul>
                    @endif
                    @endif
                </div>

                <!-- reviews -->
                <div class="ul-product-details-reviews">
           <h3 class="ul-product-details-inner-title">
    {{ $product->reviews->count() }} Customer Reviews
</h3>

@forelse($product->reviews as $review)
    <div class="ul-product-details-review">
        <div class="ul-product-details-review-reviewer-img">
          <i class="fas fa-user-circle" style="font-size: 40px; color: #999;"></i>


        </div>

        <div class="ul-product-details-review-txt">
            <div class="header">
                <div class="left">
                    <h4 class="reviewer-name">{{ $review->user->username ?? 'Anonymous' }}</h4>
                    <h5 class="review-date">{{ $review->created_at->format('F d, Y \a\t h:i A') }}</h5>
                </div>
                <div class="right">
                    <div class="rating">
                        @for ($i = 1; $i <= 5; $i++)
                            <i class="{{ $i <= $review->rating ? 'flaticon-star' : 'flaticon-star-3' }}"></i>
                        @endfor
                    </div>
                </div>
            </div>

            <p>{{ $review->comment }}</p>

            <!-- <button class="ul-product-details-review-reply-btn">Reply</button> -->
        </div>
    </div>
@empty
    <p>No reviews yet. Be the first to review this product!</p>
@endforelse


                    <!-- review form -->
                    <div class="ul-product-details-review-form-wrapper">
                        <h3 class="ul-product-details-inner-title">Write A Review</h3>
                        <span class="note">Your email address will not be published.</span>

                        <form class="ul-product-details-review-form">
                            <!-- ... existing review form code ... -->
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- MAIN CONTENT SECTION END -->
</main>

<!-- JavaScript Section -->

<link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<script>
$(document).ready(function() {
    // Initialize price on page load
    // updateTotalPrice();

$(document).off('click', '.quantityIncreaseButton').on('click', '.quantityIncreaseButton', function () {
    let quantityInput = $('#ul-product-details-quantity');
    let currentVal = parseInt(quantityInput.val()) || 1;
    // quantityInput.val(currentVal + 1);
    updateTotalPrice();
});

    // Quantity decrease button
    $(document).on('click', '.quantityDecreaseButton', function() {
        let quantityInput = $('#ul-product-details-quantity');
        let currentVal = parseInt(quantityInput.val()) || 1;
        if (currentVal >= 1) {
            // quantityInput.val(currentVal - 1);
            updateTotalPrice();
        }
    });

    // Function to update total price
function updateTotalPrice() {
    const priceBox = $('#product-price');
    const isPromo = priceBox.data('promo') === true || priceBox.data('promo') === 'true';
    const unitPrice = isPromo ? parseFloat(priceBox.data('promo-price')) : parseFloat(priceBox.data('price'));

    let qty = parseInt($('#ul-product-details-quantity').val()) || 1;

    const totalPrice = (unitPrice * qty).toFixed(2);
    $('#price-value').text(totalPrice);

    if (isPromo) {
        const originalTotal = (parseFloat(priceBox.data('price')) * qty).toFixed(2);
        $('#old-price-value').text('PKR ' + originalTotal);
    }
}

    // Add to Cart AJAX
    $('.add-to-cart').click(function(e) {
        e.preventDefault();
        var productId = $(this).data('product-id');
        var quantity = $('#ul-product-details-quantity').val();
        var size = $('input[name="product-size"]:checked').next('.size-btn').text();
        var colorElement = $('input[name="product-color"]:checked').next('.color-btn');
        var colorClass = colorElement.attr('class');
        var color = (typeof colorClass !== 'undefined') ? colorClass.split(' ')[1] : null;
        
        $.ajax({
            url: '{{ route("cart.add") }}',
            type: 'POST',
            data: {
                product_id: productId,
                quantity: quantity,
                size: size,
                color: color,
                _token: '{{ csrf_token() }}'
            },
            success: function(response) {
                if(response.success) {
                    $('.cart-count').text(response.cart_count);
                    toastr.success('Product added to cart successfully!');
                } else {
                    toastr.warning(response.message);
                }
            },
            error: function(xhr) {
                toastr.error(xhr.responseJSON.message || 'Something went wrong!');
            }
        });
    });

    // Add to Wishlist AJAX
    $('.add-to-wishlist').click(function(e) {
        e.preventDefault();
        var productId = $(this).data('product-id');
        
        $.ajax({
            url: '{{ route("wishlist.add") }}',
            type: 'POST',
            data: {
                product_id: productId,
                _token: '{{ csrf_token() }}'
            },
            success: function(response) {
                if(response.success) {
                    $('.wishlist-count').text(response.wishlist_count);
                    toastr.success('Product added to wishlist successfully!');
                } else {
                    toastr.warning(response.message);
                }
            },
            error: function(xhr) {
                toastr.error(xhr.responseJSON.message || 'Something went wrong!');
            }
        });
    });
});
</script>
@endsection