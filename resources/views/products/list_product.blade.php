@extends('layouts.master')
@section('main-content')

@section('page-css')
<link rel="stylesheet" href="{{asset('assets/styles/vendor/datatables.min.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
<style>
  .form-switch .form-check-input {
    width: 3em;
    height: 1.5em;
    margin-left: 0;
    cursor: pointer;
  }
  .product-image {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 4px;
  }
  .variant-details {
    margin-left: 15px;
    font-size: 0.9em;
    color: #666;
  }
  .product-table th {
    white-space: nowrap;
  }
  .product-table td {
    vertical-align: middle;
  }
  .measurement-cell {
    max-width: 200px;
    white-space: normal;
  }
</style>
@endsection

<div class="breadcrumb">
  <h1>{{ __('translate.Products') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_product_list">
  <div class="col-md-12">
    <div class="card">
      <div class="card-body">
        <div class="text-end mb-3">
          @can('products_add')
          <a href="/products/products/create" class="btn btn-outline-primary btn-md m-1">
            <i class="i-Add me-2 font-weight-bold"></i>{{ __('translate.Create') }}
          </a>
          @endcan
          <!-- <a class="btn btn-outline-success btn-md m-1" id="Show_Modal_Filter">
            <i class="i-Filter-2 me-2 font-weight-bold"></i>{{ __('translate.Filter') }}
          </a> -->
        </div>

        <div class="table-responsive">
          <table id="product_table" class="display table table-hover">
            <thead>
              <tr>
                <th>ID</th>
                <th>Visibility</th>
                <th>{{ __('translate.Image') }}</th>
                <th>{{ __('translate.type') }}</th>
                <th>{{ __('translate.Name') }}</th>
                <th>{{ __('translate.Code') }}</th>
                <th>{{ __('translate.Category') }}</th>
                <th>{{ __('translate.Brand') }}</th>
                <th>{{ __('translate.Product_Cost') }}</th>
                <th>{{ __('translate.Product_Price') }}</th>
                <th>{{ __('translate.Current_Stock') }}</th>
                <th>{{ __('translate.Tax') }}</th>
                <th>{{ __('translate.Unit') }}</th>
                <th>{{ __('translate.Stock_Alert') }}</th>
                <th>{{ __('translate.Note') }}</th>
                <th>Garment Type</th>
                <th>Measurements</th>
                <th>Thaan Length</th>
                <th>Suit Length</th>
                <th>Available Sizes</th>
                <th class="not_show">{{ __('translate.Action') }}</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Filter -->
  <div class="modal fade" id="filter_products_modal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">{{ __('translate.Filter') }}</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form method="POST" id="filter_products">
            @csrf
            <div class="row">
              <div class="form-group col-md-6">
                <label for="code">{{ __('translate.Code_Product') }}</label>
                <input type="text" class="form-control" name="code" id="code">
              </div>
              <div class="form-group col-md-6">
                <label for="name">{{ __('translate.Product_Name') }}</label>
                <input type="text" class="form-control" name="name" id="product_name">
              </div>
              <div class="form-group col-md-6">
                <label for="category_id">{{ __('translate.Category') }}</label>
                <select name="category_id" id="category_id" class="form-control">
                  <option value="0">{{ __('translate.All') }}</option>
                  @foreach ($categories as $category)
                    <option value="{{$category->id}}">{{$category->name}}</option>
                  @endforeach
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="brand_id">{{ __('translate.Brand') }}</label>
                <select name="brand_id" id="brand_id" class="form-control">
                  <option value="0">{{ __('translate.All') }}</option>
                  @foreach ($brands as $brand)
                    <option value="{{$brand->id}}">{{$brand->name}}</option>
                  @endforeach
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="type">{{ __('translate.Type') }}</label>
                <select name="type" id="type" class="form-control">
                  <option value="all">{{ __('translate.All') }}</option>
                  <option value="is_single">{{ __('translate.Single') }}</option>
                  <option value="is_variant">{{ __('translate.Variant') }}</option>
                  <option value="is_service">{{ __('translate.Service') }}</option>
                  <option value="stitched_garment">{{ __('translate.Stitched Garment') }}</option>
                  <option value="unstitched_garment">{{ __('translate.Unstitched Garment') }}</option>
                </select>
              </div>
              <div class="form-group col-md-6">
                <label for="warehouse_id">{{ __('translate.Warehouse') }}</label>
                <select name="warehouse_id" id="warehouse_id" class="form-control">
                  <option value="0">{{ __('translate.All') }}</option>
                  @foreach ($warehouses as $warehouse)
                    <option value="{{$warehouse->id}}">{{$warehouse->name}}</option>
                  @endforeach
                </select>
              </div>
            </div>
            <div class="row mt-3">
              <div class="col-md-6">
                <button type="submit" class="btn btn-primary">
                  <i class="i-Filter-2 me-2 font-weight-bold"></i> {{ __('translate.Filter') }}
                </button>
                <button id="Clear_Form" class="btn btn-danger">
                  <i class="i-Power-2 me-2 font-weight-bold"></i> {{ __('translate.Clear') }}
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
@endsection

@section('page-js')
<script src="{{asset('assets/js/vendor/datatables.min.js')}}"></script>
<script src="{{asset('assets/js/nprogress.js')}}"></script>
<script src="{{asset('assets/js/vendor/sweetalert2.min.js')}}"></script>
<script type="text/javascript">
  $(function () {
    "use strict";
    
    $(document).ready(function () {
      product_datatable();
    });

    function product_datatable(name ='', category_id ='', brand_id ='', code ='', type ='', warehouse_id ='') {
      var table = $('#product_table').DataTable({
        processing: true,
        serverSide: true,
        order: [[ 0, "desc" ]],
        columnDefs: [
          { targets: [0], visible: false, searchable: false },
          { targets: [1,2,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19], orderable: false },
          { targets: [16], className: "measurement-cell" }
        ],
        ajax: {
          url: "{{ route('products_datatable') }}",
          data: {
            name: name,
            category_id: category_id == '0' ? '' : category_id,
            brand_id: brand_id == '0' ? '' : brand_id,
            code: code,
            type: type == 'all' ? '' : type,
            warehouse_id: warehouse_id == '0' ? '' : warehouse_id,
            "_token": "{{ csrf_token()}}"
          },
          type: "post"
        },
        columns: [
          {data: 'id', className: "d-none"},
          {data: 'visibility'},
          {data: 'image'},
          {data: 'type'},
          {data: 'name'},
          {data: 'code'},
          {data: 'category'},
          {data: 'brand'},
          {data: 'cost'},
          {data: 'price'},
          {data: 'quantity'},
          {data: 'tax'},
          {data: 'unit'},
          {data: 'stock_alert'},
          {data: 'note'},
          {data: 'garment_type'},
          {data: 'measurements'},
          {data: 'thaan_length'},
          {data: 'suit_length'},
          {data: 'available_sizes'},
          {data: 'action', className: "not_show"}
        ],
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
        dom: "<'row'<'col-sm-12 col-md-7'lB><'col-sm-12 col-md-5 p-0'f>>rtip",
        className: "product-table",
        oLanguage: {
          sEmptyTable: "{{ __('datatable.sEmptyTable') }}",
          sInfo: "{{ __('datatable.sInfo') }}",
          sInfoEmpty: "{{ __('datatable.sInfoEmpty') }}",
          sInfoFiltered: "{{ __('datatable.sInfoFiltered') }}",
          sInfoThousands: "{{ __('datatable.sInfoThousands') }}",
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
          oAria: {
            sSortAscending: "{{ __('datatable.oAria.sSortAscending') }}",
            sSortDescending: "{{ __('datatable.oAria.sSortDescending') }}",
          }
        },
        buttons: [
          {
            extend: 'collection',
            text: "{{ __('translate.EXPORT') }}",
            buttons: [
              {
                extend: 'print',
                text: 'print',
                exportOptions: {
                  columns: ':visible:Not(.not_show)',
                  rows: ':visible'
                },
              },
              {
                extend: 'pdf',
                text: 'pdf',
                exportOptions: {
                  columns: ':visible:Not(.not_show)',
                  rows: ':visible'
                },
              },
              {
                extend: 'excel',
                text: 'excel',
                exportOptions: {
                  columns: ':visible:Not(.not_show)',
                  rows: ':visible'
                },
              },
              {
                extend: 'csv',
                text: 'csv',
                exportOptions: {
                  columns: ':visible:Not(.not_show)',
                  rows: ':visible'
                },
              },
            ]
          }
        ]
      });
    }

    $('#Clear_Form').on('click', function (e) {
      e.preventDefault();
      $('#product_name, #code').val('');
      $('#category_id, #brand_id, #type, #warehouse_id').val('0');
    });

    $('#Show_Modal_Filter').on('click', function () {
      $('#filter_products_modal').modal('show');
    });

    $('#filter_products').on('submit', function (e) {
      e.preventDefault();
      let name = $('#product_name').val();
      let category_id = $('#category_id').val();
      let brand_id = $('#brand_id').val();
      let code = $('#code').val();
      let type = $('#type').val();
      let warehouse_id = $('#warehouse_id').val();

      $('#product_table').DataTable().destroy();
      product_datatable(name, category_id, brand_id, code, type, warehouse_id);
      $('#filter_products_modal').modal('hide');
    });

    $(document).on('click', '.delete', function () {
      var id = $(this).attr('id');
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
        axios.delete("/products/products/" + id)
          .then(() => {
            $('#product_table').DataTable().ajax.reload();
            toastr.success('{{ __('translate.Deleted_in_successfully') }}');
          })
          .catch(() => {
            toastr.error('{{ __('translate.There_was_something_wronge') }}');
          });
      });
    });

    $(document).on('change', '.toggle-visibility', function () {
      let product_id = $(this).data('id');
      let is_visible = $(this).is(':checked') ? 1 : 0;

      axios.post('/products/toggle-visibility', {
        product_id: product_id,
        is_visible: is_visible,
        _token: '{{ csrf_token() }}'
      })
      .then(response => {
        toastr.success(response.data.message);
      })
      .catch(error => {
        toastr.error('{{ __('translate.There_was_something_wronge') }}');
        $(this).prop('checked', !is_visible);
      });
    });
  });
</script>
@endsection