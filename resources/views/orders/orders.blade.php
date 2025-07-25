@extends('layouts.master')
@section('main-content')
@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/datatables.min.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
@endsection

<div class="breadcrumb">
  <h1>{{ __('All_Orders') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div id="section_order_list">
  <div class="card">
    <div class="card-body">
      <div class="row">
        <div class="col-md-12">
          <div class="table-responsive">
            <table id="order_list" class="display table">
              <thead>
                <tr>
                  <th>{{ __('Order_ID') }}</th>
                  <th>{{ __('translate.Customer') }}</th>
                  <th>{{ __('translate.Email') }}</th>
                  <th>{{ __('translate.Phone') }}</th>
                  <th>{{ __('translate.Address') }}</th>
                  <th>{{ __('translate.Payment_Method') }}</th>
                  <th>{{ __('translate.Total') }}</th>
                  <th>{{ __('translate.Date') }}</th>
                  <th>{{ __('translate.Action') }}</th>
                </tr>
              </thead>
              <tbody>
                @foreach($orders as $order)
                <tr>
                  <td>#{{ $order->id }}</td>
                  <td>{{ $order->first_name }} {{ $order->last_name }}</td>
                  <td>{{ $order->email }}</td>
                  <td>{{ $order->phone }}</td>
                  <td>
                    {{ $order->address1 }}, 
                    @if($order->address2){{ $order->address2 }}, @endif
                    {{ $order->city }}, {{ $order->state }}, {{ $order->zipcode }}, {{ $order->country }}
                  </td>
                  <td>{{ $order->payment_method }}</td>
                  <td>{{ format_currency($order->total) }}</td>
                  <td>{{ $order->created_at->format('d M Y') }}</td>
                  <td>
                    <a href="{{ route('orders.show', $order->id) }}" class="text-primary me-2" 
                       data-toggle="tooltip" data-placement="top" title="View Details">
                      <i class="i-Eye"></i>
                    </a>
                    <a @click="deleteOrder({{ $order->id }})" class="cursor-pointer text-danger ul-link-action" 
                       data-toggle="tooltip" data-placement="top" title="Delete">
                      <i class="i-Close-Window"></i>
                    </a>
                  </td>
                </tr>
                @endforeach
              </tbody>
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

    $('#order_list').DataTable({
      "processing": true,
      lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
      dom: "<'row'<'col-sm-12 col-md-6'l><'col-sm-12 col-md-6'f>>rt<'row'<'col-sm-12 col-md-6'i><'col-sm-12 col-md-6'p>>",
      order: [[7, 'desc']], // Default sort by date descending
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
    el: '#section_order_list',
    methods: {
      // Delete order
      deleteOrder(id) {
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
            .delete("/admin/orders/" + id)
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