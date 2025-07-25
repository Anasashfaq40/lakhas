@extends('layouts.master')
@section('main-content')
@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/datatables.min.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
@endsection

<div class="breadcrumb">
  <h1>{{ __('All User Carts') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div id="section_Cart_list">
  <div class="card">
    <div class="card-body">
      <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
            <table id="ul-contact-list" class="display table">
              <thead>
                <tr>
                  <th>{{ __('translate.Users') }}</th>
                  <th>{{ __('translate.Products') }}</th>
                  <th>{{ __('translate.Price') }}</th>
                  <th>{{ __('translate.Quantity') }}</th>
                  <th>{{ __('translate.Size') }}</th>
                  <th>{{ __('translate.Color') }}</th>
                  <th>{{ __('translate.Total') }}</th>
                  <th>{{ __('translate.Action') }}</th>
                </tr>
              </thead>
              <tbody>
                @foreach($allCarts as $cart)
                <tr>
                  <td>
                    <div class="d-flex align-items-center">
                      <div class="avatar me-2 avatar-md">
                        <!-- <img src="{{ asset('images/avatar/'.$cart->user->avatar) }}" alt=""> -->
                      </div>
                      <span>{{ $cart->user->username }}</span>
                    </div>
                  </td>
                  <td>
                    <div class="d-flex align-items-center">
                      <img src="{{ asset('images/products/'.$cart->product->image) }}" class="img-thumbnail me-2" width="60" alt="">
                      <span>{{ $cart->product->name }}</span>
                    </div>
                  </td>
                  <td>{{ format_currency($cart->price) }}</td>
                  <td>{{ $cart->quantity }}</td>
                  <td>{{ $cart->size ?? '-' }}</td>
                  <td>
                    @if($cart->color)
                    <span class="badge" style="background-color: {{$cart->color}}">&nbsp;&nbsp;&nbsp;</span>
                    @else
                    -
                    @endif
                  </td>
                  <td>{{ format_currency($cart->price * $cart->quantity) }}</td>
                  <td>
                    <a @click="Remove_CartItem({{ $cart->id }})" class="cursor-pointer text-danger ul-link-action" 
                       data-toggle="tooltip" data-placement="top" title="Remove">
                      <i class="i-Close-Window"></i>
                    </a>
                  </td>
                </tr>
                @endforeach
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="6" class="text-end"><strong>{{ __('translate.Grand_Total') }}:</strong></td>
                  <td><strong>{{ format_currency($grandTotal) }}</strong></td>
                  <td></td>
                </tr>
              </tfoot>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection

@section('page-js')

<script src="{{asset('assets/js/vendor/datatables.min.js')}}"></script>
<script src="{{asset('assets/js/nprogress.js')}}"></script>

<script>
  $(function () {
    "use strict";

    $('#ul-contact-list').DataTable({
      "processing": true,
      lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
      dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>rt<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>",
      oLanguage: {
        sEmptyTable: "{{ __('datatable.sEmptyTable') }}",
        sInfo: "{{ __('datatable.sInfo') }}",
        sInfoEmpty: "{{ __('datatable.sInfoEmpty') }}",
        sInfoFiltered: "{{ __('datatable.sInfoFiltered') }}",
        sLengthMenu: "_MENU_", 
        sLoadingRecords: "{{ __('datatable.sLoadingRecords') }}",
        sProcessing: "{{ __('datatable.sProcessing') }}",
        sSearch: "",
        sSearchPlaceholder: "{{ __('datatable.sSearchPlaceholder') }}",
        oPaginate: {
          sFirst: "{{ __('datatable.oPaginate.sFirst') }}",
          sLast: "{{ __('datatable.oPaginate.sLast') }}",
          sNext: "{{ __('datatable.oPaginate.sNext') }}",
          sPrevious: "{{ __('datatable.oPaginate.sPrevious') }}",
        },
      }
    });
  });
</script>

<script>
  var app = new Vue({
    el: '#section_Cart_list',
    methods: {
      // Remove cart item
      Remove_CartItem(id) {
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
        }).then(function () {
          axios
            .delete("/admin/carts/" + id)
            .then(() => {
              window.location.reload();
              toastr.success('{{ __('translate.Deleted_in_successfully') }}');
            })
            .catch(() => {
              toastr.error('{{ __('translate.There_was_something_wronge') }}');
            });
        });
      }
    }
  });
</script>

@endsection