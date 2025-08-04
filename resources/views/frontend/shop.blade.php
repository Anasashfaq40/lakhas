@extends('layouts.frontendlinks')

@section('title', 'Shop')

@section('content')
<main class="py-4">
     <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Shop Right Sidebar</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Shop</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->
    <div class="container">
        <div class="mb-4">
        
        </div>

        <div class="row">
            <!-- Sidebar Filters -->
            <div class="col-lg-3 mb-4">
                <div class="card">
                    <div style="background-color: #ca9a30;" class="card-header  text-white">
                        Filters
                    </div>
                    <div class="card-body">
                        <form method="GET" action="{{ route('shop') }}">
                            <!-- Search -->
                            <div class="mb-3">
                                <label class="form-label">Search</label>
                                <input type="text" name="search" value="{{ request('search') }}" class="form-control" placeholder="Search Items">
                            </div>

                            <!-- Price -->
                            <div class="mb-3">
                                <label class="form-label">Price Range</label>
                                <div class="d-flex gap-2">
                                    <input type="number" name="min_price" class="form-control" placeholder="Min" value="{{ request('min_price') }}">
                                    <input type="number" name="max_price" class="form-control" placeholder="Max" value="{{ request('max_price') }}">
                                </div>
                            </div>

                            <!-- Product Status -->
                            <div class="mb-3">
                                <label class="form-label">Product Status</label>
                                <select name="status" class="form-select">
                                    <option value="">All</option>
                                    <option value="stock" {{ request('status') == 'stock' ? 'selected' : '' }}>In Stock</option>
                                    <option value="sale" {{ request('status') == 'sale' ? 'selected' : '' }}>On Sale</option>
                                </select>
                            </div>

                            <!-- Size -->
                            <div class="mb-3">
                                <label class="form-label">Size</label>
                                <select name="size" class="form-select">
                                    <option value="">All</option>
                                    <option value="S" {{ request('size') == 'S' ? 'selected' : '' }}>S</option>
                                    <option value="M" {{ request('size') == 'M' ? 'selected' : '' }}>M</option>
                                    <option value="L" {{ request('size') == 'L' ? 'selected' : '' }}>L</option>
                                    <option value="XL" {{ request('size') == 'XL' ? 'selected' : '' }}>XL</option>
                                    <option value="XXL" {{ request('size') == 'XXL' ? 'selected' : '' }}>XXL</option>
                                </select>
                            </div>

                            <!-- Rating -->
                            <div class="mb-3">
                                <label class="form-label">Rating</label>
                                <select name="rating" class="form-select">
                                    <option value="">All</option>
                                    <option value="5" {{ request('rating') == '5' ? 'selected' : '' }}>5 Star</option>
                                    <option value="4" {{ request('rating') == '4' ? 'selected' : '' }}>4 & up</option>
                                    <option value="3" {{ request('rating') == '3' ? 'selected' : '' }}>3 & up</option>
                                    <option value="2" {{ request('rating') == '2' ? 'selected' : '' }}>2 & up</option>
                                    <option value="1" {{ request('rating') == '1' ? 'selected' : '' }}>1 & up</option>
                                </select>
                            </div>

                            <button style="background-color: #ca9a30;" type="submit" class="btn  w-100">Apply Filters</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Products -->
            <div class="col-lg-9">
                <div class="row g-4">
                  @forelse($products as $product)
    <div class="col-md-4 col-sm-6 mb-4">
        <div class="card h-100">
            <img src="{{ asset('images/products/' . $product->image) }}" class="card-img-top" alt="{{ $product->name }}">
            <div class="card-body d-flex flex-column justify-content-between">
                <div>
                    <h5 class="card-title">
                        <a style="color: black;" href="{{ route('shop.details', $product->id) }}">{{ $product->name }}</a>
                    </h5>
                    <p class="card-text mb-1"><strong>Price:</strong> ${{ number_format($product->price, 2) }}</p>
                    @if($product->is_promo)
                        <p class="text-danger">
                            <strong>{{ number_format(100 - ($product->promo_price / $product->price * 100), 0) }}% Off</strong>
                        </p>
                    @endif
                    <p class="text-muted mb-0"><strong>Category:</strong> {{ $product->category?->name }}</p>

                    @php
                        $avgRating = $product->reviews->avg('rating');
                    @endphp

                    @if($avgRating)
                        <div class="rating mt-1">
                            ⭐ {{ number_format($avgRating, 1) }} / 5
                        </div>
                    @endif
                </div>

                <div class="mt-3 d-flex justify-content-between">
                    <!-- Add to Cart Button -->
                 
                        <button class="add-to-cart" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-shopping-bag"></i></span>
                            <span class="text"></span>
                        </button>
                        <a href="{{ route('shop.details', $product->id) }}"><i class="flaticon-hide"></i></a>
                        <button class="add-to-wishlist" data-product-id="{{ $product->id }}">
                            <span class="icon"><i class="flaticon-heart"></i></span>
                        </button>
                 
                </div>
            </div>
        </div>
    </div>
@empty
    <div class="col-12">
        <p class="text-center">No products found.</p>
    </div>
@endforelse

                </div>

                <!-- Pagination -->
                <div class="mt-4">
                    {{ $products->appends(request()->query())->links('pagination::bootstrap-4') }}
                </div>
            </div>
        </div>
    </div>
</main>

<script>
$(document).ready(function() {
    // Initialize Toastr (if not already initialized elsewhere)
    toastr.options = {
        "closeButton": true,
        "progressBar": true,
        "positionClass": "toast-top-right",
        "timeOut": "3000"
    };

    // Add to Cart AJAX - Better with loading states and error handling
    $(document).on('click', '.add-to-cart', function(e) {
        e.preventDefault();
        var button = $(this);
        var productId = button.data('product-id');
        var quantity = $('#ul-product-details-quantity').val() || 1; // Default to 1 if empty
        var size = $('input[name="product-size"]:checked').next('.size-btn').text();
        var color = $('input[name="product-color"]:checked').next('.color-btn').attr('class')?.split(' ')[1] || null;

        // Disable button during AJAX call
        button.prop('disabled', true).html('<i class="fa fa-spinner fa-spin"></i> Adding...');

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
                    $('.cart-count').text(response.cart_count).fadeOut(100).fadeIn(100);
                    toastr.success(response.message || 'Product added to cart!');
                } else {
                    toastr.warning(response.message || 'Could not add to cart');
                }
            },
            error: function(xhr) {
                let errorMsg = xhr.responseJSON?.message || 'Something went wrong!';
                toastr.error(errorMsg);
            },
            complete: function() {
                button.prop('disabled', false).html(' <i class="flaticon-cart"></i>');
            }
        });
    });

$(document).on('click', '.add-to-wishlist', function(e) {
    e.preventDefault();
    console.log('Wishlist button clicked'); // Check if event fires
    
    var button = $(this);
    var productId = button.data('product-id');
    console.log('Product ID:', productId); // Verify product ID
    
    // Show loading state
    button.find('i').removeClass('flaticon-heart').addClass('fa fa-spinner fa-spin');
    console.log('Button state changed'); // Check if DOM manipulation works

    $.ajax({
        url: '{{ route("wishlist.add") }}',
        type: 'POST',
        data: {
            product_id: productId,
            _token: '{{ csrf_token() }}'
        },
        success: function(response) {
            console.log('AJAX Success:', response); // Inspect response
            if(response.success) {
                $('.wishlist-count').text(response.wishlist_count).fadeOut(100).fadeIn(100);
                toastr.success(response.message || 'Added to wishlist!');
                button.find('i').removeClass('fa-spinner fa-spin').addClass('flaticon-heart text-danger');
            } else {
                toastr.warning(response.message || 'Could not add to wishlist');
                button.find('i').removeClass('fa-spinner fa-spin').addClass('flaticon-heart');
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error:', status, error); // Detailed error logging
            console.error('Response:', xhr.responseJSON);
            let errorMsg = xhr.responseJSON?.message || 'Error processing request';
            toastr.error(errorMsg);
            button.find('i').removeClass('fa-spinner fa-spin').addClass('flaticon-heart');
        }
    });
});
});
</script>
@endsection
