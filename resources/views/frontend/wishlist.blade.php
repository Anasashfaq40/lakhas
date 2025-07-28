@extends('layouts.frontendlinks')
@section('title', 'Wishlist')
@section('content')
   <main>
        <!-- BREADCRUMB SECTION START -->
        <div class="ul-container">
            <div class="ul-breadcrumb">
                <h2 class="ul-breadcrumb-title">Wishlist</h2>
                <div class="ul-breadcrumb-nav">
                    <a href="index.html"><i class="flaticon-home"></i> Home</a>
                    <i class="flaticon-arrow-point-to-right"></i>
                    <span class="current-page">Wishlist</span>
                </div>
            </div>
        </div>
        <!-- BREADCRUMB SECTION END -->


        <div class="ul-cart-container">
            <div class="cart-top">
                <div class="text-center">
                    <!-- cart header -->
                    <div class="ul-cart-header ul-wishlist-header">
                        <div>Product</div>
                        <div>Price</div>
                        <div>Stock</div>
                        <div>Remove</div>
                    </div>

                    <!-- cart body -->
                    <div>
                        <!-- single wishlist item -->
                    @forelse ($wishlists as $wishlist)
    @if ($wishlist->product)
        <div class="ul-cart-item">
            <!-- product -->
            <div class="ul-cart-product">
                <a href="#" class="ul-cart-product-img">
                    <img src="{{ asset('images/products/' . $wishlist->product->image) }}" alt="{{ $wishlist->product->title }}">
                </a>
                <a href="#" class="ul-cart-product-title">
                    {{ $wishlist->product->title }}
                </a>
            </div>

            <!-- price -->
            <span class="ul-cart-item-price">
                ${{ number_format($wishlist->product->price, 2) }}
            </span>

            <!-- stock -->
            <span class="ul-cart-item-subtotal ul-wislist-item-stock {{ $wishlist->product->stock_alert > 0 ? 'green' : 'red' }}">
                {{ $wishlist->product->stock_alert > 0 ? 'In Stock' : 'Out of Stock' }}
            </span>

            <!-- remove -->
      <div class="ul-cart-item-remove">
    <form class="removeWishlistItemForm" action="{{ route('wishlist.destroy', $wishlist->id) }}" method="POST">
        @csrf
        @method('DELETE')
        <button type="submit" class="btn-remove-wishlist">
            <i class="flaticon-close"></i>
        </button>
    </form>
</div>
        </div>
    @endif
@empty
    <p>Your wishlist is empty.</p>
@endforelse


                    

                     

                   
                    </div>
                </div>
            </div>
        </div>
    </main>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function() {
    // Handle wishlist item removal
    $('.removeWishlistItemForm').on('submit', function(e) {
        e.preventDefault();
        
        const form = $(this);
        const url = form.attr('action');
        
        $.ajax({
            url: url,
            type: 'POST', // Laravel's way of handling DELETE requests
            data: form.serialize(),
            success: function(response) {
                if(response.success) {
                    // Show success toast
                    toastr.success(response.message);
                    
                    // Remove the item from view
                    form.closest('.ul-cart-item').fadeOut(300, function() {
                        $(this).remove();
                    });
                    
                    // Update wishlist count in header
                    if(response.wishlist_count !== undefined) {
                        $('.wishlist-count').text(response.wishlist_count);
                    }
                    
                    // If no items left, show empty message
                    if($('.ul-cart-item').length === 0) {
                        $('.ul-wishlist-header').after('<p>Your wishlist is empty.</p>');
                    }
                } else {
                    toastr.error(response.message || 'Failed to remove item');
                }
            },
            error: function(xhr) {
                toastr.error(xhr.responseJSON?.message || 'Error removing item');
            }
        });
    });
});
</script>

@endsection