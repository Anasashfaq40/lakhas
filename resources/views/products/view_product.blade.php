@extends('layouts.master')
@section('main-content')

@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
<style>
  .product-details-container {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
    padding: 30px;
  }
  .product-image-main {
    width: 100%;
    max-height: 400px;
    object-fit: contain;
    border-radius: 8px;
  }
  .product-gallery {
    display: flex;
    margin-top: 15px;
    gap: 10px;
  }
  .product-gallery img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 5px;
    cursor: pointer;
    border: 2px solid transparent;
  }
  .product-gallery img.active {
    border-color: #3f6ad8;
  }
  .detail-label {
    font-weight: 600;
    color: #6c757d;
    min-width: 150px;
    display: inline-block;
  }
  .detail-value {
    font-weight: 500;
  }
  .action-buttons {
    margin-top: 30px;
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }
  .measurements-section {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin-top: 20px;
  }
</style>
@endsection

<div class="breadcrumb">
  <h1>{{ __('Product_Details') }}</h1>
  <ul>
    <li><a href="/products/products">{{ __('translate.Products') }}</a></li>
    <li>{{ $product->name }}</li>
  </ul>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_product_view">
  <div class="col-md-12">
    <div class="product-details-container">
      <div class="row">
        <!-- Product Images -->
        <div class="col-md-5">
          <img src="{{ asset('images/products/'.$product->image) }}" class="product-image-main" id="mainImage" 
               onerror="this.src='{{ asset('images/products/no_image.png') }}'">
          
          @if($product->images->count() > 0)
            <div class="product-gallery">
              <img src="{{ asset('images/products/'.$product->image) }}" 
                   onclick="changeMainImage(this)" 
                   class="{{ $product->images->count() == 0 ? 'active' : '' }}">
              
              @foreach($product->images as $image)
                <img src="{{ asset('images/products/multiple/'.$image->image) }}" 
                     onclick="changeMainImage(this)"
                     class="{{ $loop->first ? 'active' : '' }}">
              @endforeach
            </div>
          @endif
        </div>

        <!-- Product Details -->
        <div class="col-md-7">
          <h2 class="mb-4">{{ $product->name }}</h2>
          
          <div class="row">
            <div class="col-md-6">
              <p><span class="detail-label">{{ __('translate.Code') }}:</span> 
                <span class="detail-value">{{ $product->code }}</span></p>
              <p><span class="detail-label">{{ __('translate.Type') }}:</span> 
                <span class="detail-value">{{ ucfirst(str_replace('_', ' ', $product->type)) }}</span></p>
              <p><span class="detail-label">{{ __('translate.Category') }}:</span> 
                <span class="detail-value">{{ $product->category->name ?? 'N/A' }}</span></p>
              <p><span class="detail-label">{{ __('translate.Brand') }}:</span> 
                <span class="detail-value">{{ $product->brand->name ?? 'N/A' }}</span></p>
            </div>
            <div class="col-md-6">
              <p><span class="detail-label">{{ __('translate.Cost') }}:</span> 
                <span class="detail-value">{{ number_format($product->cost, 2) }}</span></p>
              <p><span class="detail-label">{{ __('translate.Price') }}:</span> 
                <span class="detail-value">{{ number_format($product->price, 2) }}</span></p>
              <p><span class="detail-label">{{ __('translate.Tax') }}:</span> 
                <span class="detail-value">{{ $product->TaxNet }}% ({{ $product->tax_method == 1 ? 'Exclusive' : 'Inclusive' }})</span></p>
              <p><span class="detail-label">{{ __('translate.Unit') }}:</span> 
                <span class="detail-value">{{ $product->unit->ShortName ?? 'N/A' }}</span></p>
            </div>
          </div>

        <!-- Garment Specific Details -->
@if($product->type == 'stitched_garment')
    <div class="measurements-section">
        <h5 class="mb-3">Garment Details</h5>
        <p><span class="detail-label">Garment Type:</span> 
            <span class="detail-value">{{ ucfirst(str_replace('_', ' ', $product->garment_type)) }}</span>
        </p>
        
        @if($product->garment_type == 'shalwar_suit')
            <!-- Shalwar/Kameez Measurements -->
            <h6 class="mt-3">Kameez Measurements</h6>
            <div class="row">
                <div class="col-md-6">
                    <p><span class="detail-label">Length:</span> {{ $product->kameez_length ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Shoulder:</span> {{ $product->kameez_shoulder ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Sleeves:</span> {{ $product->kameez_sleeves ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Chest:</span> {{ $product->kameez_chest ?? 'N/A' }} inches</p>
                </div>
                <div class="col-md-6">
                    <p><span class="detail-label">Upper Waist:</span> {{ $product->kameez_upper_waist ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Lower Waist:</span> {{ $product->kameez_lower_waist ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Hip:</span> {{ $product->kameez_hip ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Neck:</span> {{ $product->kameez_neck ?? 'N/A' }} inches</p>
                </div>
            </div>
            
            <h6 class="mt-3">Shalwar Measurements</h6>
            <div class="row">
                <div class="col-md-6">
                    <p><span class="detail-label">Length:</span> {{ $product->shalwar_length ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Waist:</span> {{ $product->shalwar_waist ?? 'N/A' }} inches</p>
                </div>
                <div class="col-md-6">
                    <p><span class="detail-label">Bottom:</span> {{ $product->shalwar_bottom ?? 'N/A' }} inches</p>
                </div>
            </div>
            
            <h6 class="mt-3">Collar Types</h6>
            <div class="row">
                <div class="col-md-12">
                    <p>
                        @if($product->collar_shirt) <span class="badge badge-primary">Shirt</span> @endif
                        @if($product->collar_sherwani) <span class="badge badge-primary">Sherwani</span> @endif
                        @if($product->collar_damian) <span class="badge badge-primary">Damian</span> @endif
                        @if($product->collar_round) <span class="badge badge-primary">Round</span> @endif
                        @if($product->collar_square) <span class="badge badge-primary">Square</span> @endif
                        @if(!$product->collar_shirt && !$product->collar_sherwani && !$product->collar_damian && !$product->collar_round && !$product->collar_square)
                            <span>N/A</span>
                        @endif
                    </p>
                </div>
            </div>
            
        @elseif($product->garment_type == 'pant_shirt')
            <!-- Pant/Shirt Measurements -->
            <h6 class="mt-3">Shirt Measurements</h6>
            <div class="row">
                <div class="col-md-6">
                    <p><span class="detail-label">Length:</span> {{ $product->pshirt_length ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Shoulder:</span> {{ $product->pshirt_shoulder ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Sleeves:</span> {{ $product->pshirt_sleeves ?? 'N/A' }} inches</p>
                </div>
                <div class="col-md-6">
                    <p><span class="detail-label">Chest:</span> {{ $product->pshirt_chest ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Neck:</span> {{ $product->pshirt_neck ?? 'N/A' }} inches</p>
                </div>
            </div>
            
            <h6 class="mt-3">Pant Measurements</h6>
            <div class="row">
                <div class="col-md-6">
                    <p><span class="detail-label">Length:</span> {{ $product->pant_length ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Waist:</span> {{ $product->pant_waist ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Hip:</span> {{ $product->pant_hip ?? 'N/A' }} inches</p>
                </div>
                <div class="col-md-6">
                    <p><span class="detail-label">Thai:</span> {{ $product->pant_thai ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Knee:</span> {{ $product->pant_knee ?? 'N/A' }} inches</p>
                    <p><span class="detail-label">Bottom:</span> {{ $product->pant_bottom ?? 'N/A' }} inches</p>
                </div>
            </div>
            
            <h6 class="mt-3">Collar Types</h6>
            <div class="row">
                <div class="col-md-12">
                    <p>
                        @if($product->pshirt_collar_shirt) <span class="badge badge-primary">Shirt</span> @endif
                        @if($product->pshirt_collar_round) <span class="badge badge-primary">Round</span> @endif
                        @if($product->pshirt_collar_square) <span class="badge badge-primary">Square</span> @endif
                        @if(!$product->pshirt_collar_shirt && !$product->pshirt_collar_round && !$product->pshirt_collar_square)
                            <span>N/A</span>
                        @endif
                    </p>
                </div>
            </div>
        @endif
    </div>
@elseif($product->type == 'unstitched_garment')
    <div class="measurements-section">
        <h5 class="mb-3">Unstitched Garment Details</h5>
        <div class="row">
            <div class="col-md-6">
                <p><span class="detail-label">Thaan Length:</span> {{ $product->thaan_length ?? 'N/A' }} meters</p>
                <p><span class="detail-label">Suit Length:</span> {{ $product->suit_length ?? 'N/A' }} meters</p>
            </div>
            <div class="col-md-6">
                <p><span class="detail-label">Available Sizes:</span> 
                    @if($product->available_sizes)
                        @foreach(json_decode($product->available_sizes) as $size)
                            <span class="badge badge-info">{{ $size }}</span>
                        @endforeach
                    @else
                        N/A
                    @endif
                </p>
            </div>
        </div>
    </div>
@endif

          <!-- Variants -->
          @if($product->type == 'is_variant' && $product->variants->count() > 0)
            <div class="mt-4">
              <h5>Variants</h5>
              <div class="table-responsive">
                <table class="table table-bordered">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Code</th>
                      <th>Cost</th>
                      <th>Price</th>
                    </tr>
                  </thead>
                  <tbody>
                    @foreach($product->variants as $variant)
                      <tr>
                        <td>{{ $variant->name }}</td>
                        <td>{{ $variant->code }}</td>
                        <td>{{ number_format($variant->cost, 2) }}</td>
                        <td>{{ number_format($variant->price, 2) }}</td>
                      </tr>
                    @endforeach
                  </tbody>
                </table>
              </div>
            </div>
          @endif

          <!-- Notes -->
          @if($product->note)
            <div class="mt-4">
              <h5>Notes</h5>
              <p>{{ $product->note }}</p>
            </div>
          @endif

          <!-- Action Buttons -->
          <div class="action-buttons">
            @can('products_edit')
              <a href="/products/products/{{ $product->id }}/edit" class="btn btn-primary">
                <i class="i-Edit me-2"></i> {{ __('translate.Edit') }}
              </a>
            @endcan
            
            @can('products_delete')
              <button class="btn btn-danger delete-product" data-id="{{ $product->id }}">
                <i class="i-Close me-2"></i> {{ __('translate.Delete') }}
              </button>
            @endcan
            
            <a href="{{ route('product.ledger.download', $product->id) }}" class="btn btn-info">
              <i class="i-Download me-2"></i> Download Ledger
            </a>
            
            <a href="/products/products" class="btn btn-secondary">
              <i class="i-Back me-2"></i> Back to Products
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

@endsection

@section('page-js')
<script src="{{asset('assets/js/vendor/sweetalert2.min.js')}}"></script>
<script>
  // Change main image when clicking on thumbnails
  function changeMainImage(element) {
    document.getElementById('mainImage').src = element.src;
    document.querySelectorAll('.product-gallery img').forEach(img => {
      img.classList.remove('active');
    });
    element.classList.add('active');
  }

  // Delete product
  $(document).on('click', '.delete-product', function() {
    var productId = $(this).data('id');
    
    swal({
      title: '{{ __('translate.Are_you_sure') }}',
      text: '{{ __('translate.You_wont_be_able_to_revert_this') }}',
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#0CC27E',
      cancelButtonColor: '#FF586B',
      confirmButtonText: '{{ __('translate.Yes_delete_it') }}',
      cancelButtonText: '{{ __('translate.No_cancel') }}',
      confirmButtonClass: 'btn btn-primary me-5',
      cancelButtonClass: 'btn btn-danger',
      buttonsStyling: false
    }).then(function() {
      axios.delete("/products/products/" + productId)
        .then(response => {
          if (response.data.success) {
            window.location.href = "/products/products";
          }
        })
        .catch(error => {
          toastr.error('{{ __('translate.There_was_something_wronge') }}');
        });
    });
  });
</script>
@endsection