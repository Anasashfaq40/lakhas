@extends('layouts.master')

@section('main-content')
@section('page-css')
<link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">
<link rel="stylesheet" href="{{ asset('assets/styles/vendor/nprogress.css') }}">
@endsection

<div class="breadcrumb">
  <h1>{{ __('translate.Categories') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_Category_list">
  <div class="col-md-12">
    <div class="card">
      <div class="card-body">
        <div class="text-end mb-3">
          <a class="new_category btn btn-outline-primary btn-md m-1">
            <i class="i-Add me-2 font-weight-bold"></i>{{ __('translate.Create') }}
          </a>
        </div>

        <div class="table-responsive">
          <table id="category_table" class="display table">
            <thead>
              <tr>
                <th>ID</th>
                <th>{{ __('translate.Code') }}</th>
                <th>{{ __('translate.Name') }}</th>
                <th>{{ __('Image') }}</th>
                <th class="not_show">{{ __('translate.Action') }}</th>
              </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal Add & Edit category -->
  <div class="modal fade" id="modal_Category" tabindex="-1" role="dialog" aria-labelledby="modal_Category"
    aria-hidden="true">
    <div class="modal-dialog modal-md" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 v-if="editmode" class="modal-title">{{ __('translate.Edit') }}</h5>
          <h5 v-else class="modal-title">{{ __('translate.Create') }}</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <form @submit.prevent="editmode ? Update_Category() : Create_Category()" enctype="multipart/form-data">
            <div class="row">
              <div class="form-group col-md-12">
                <label for="code">{{ __('translate.Code_of_category') }}<span class="field_required">*</span></label>
                <input type="text" v-model="category.code" class="form-control" name="code" id="code"
                  placeholder="{{ __('translate.Enter_Code_category') }}">
                <span class="error" v-if="errors && errors.code">@{{ errors.code[0] }}</span>
              </div>

              <div class="form-group col-md-12">
                <label for="name">{{ __('translate.Name_of_category') }}<span class="field_required">*</span></label>
                <input type="text" v-model="category.name" class="form-control" name="name" id="name"
                  placeholder="{{ __('translate.Enter_name_category') }}">
                <span class="error" v-if="errors && errors.name">@{{ errors.name[0] }}</span>
              </div>

              <div class="form-group col-md-12">
                <label for="image">{{ __('Image') }}</label>
                <input type="file" class="form-control" name="image" id="image" @change="handleImageUpload">
                <span class="error" v-if="errors && errors.image">@{{ errors.image[0] }}</span>
                <div v-if="category.image" class="mt-2">
                  <img :src="getImageUrl(category.image)" width="100" class="img-thumbnail">
                </div>
              </div>
            </div>

            <div class="row mt-3">
              <div class="col-md-6">
                <button type="submit" class="btn btn-primary" :disabled="SubmitProcessing">
                  <span v-if="SubmitProcessing" class="spinner-border spinner-border-sm" role="status"
                    aria-hidden="true"></span>
                  <i class="i-Yes me-2 font-weight-bold"></i> {{ __('translate.Submit') }}
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

<script src="{{ asset('assets/js/vendor/datatables.min.js') }}"></script>
<script src="{{ asset('assets/js/nprogress.js') }}"></script>

<script type="text/javascript">
  $(function () {
    "use strict";

    $(document).ready(function () {
      Category_datatable();
    });

    function Category_datatable() {
      $('#category_table').DataTable({
        processing: true,
        serverSide: true,
        order: [[0, "desc"]],
        columnDefs: [
          {
            targets: [0],
            visible: false,
            searchable: false,
          },
        ],
        ajax: "{{ route('categories.index') }}",
        columns: [
          { data: 'id', name: 'id', className: "d-none" },
          { data: 'code', name: 'code' },
          { data: 'name', name: 'name' },
          { data: 'image', name: 'image', orderable: false, searchable: false },
          { data: 'action', name: 'action', orderable: false, searchable: false },
        ],
        lengthMenu: [[10, 25, 50, -1], [10, 25, 50, "All"]],
        dom: "<'row'<'col-sm-12 col-md-7'lB><'col-sm-12 col-md-5 p-0'f>>rtip",
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
          oAria: {
            sSortAscending: "{{ __('datatable.oAria.sSortAscending') }}",
            sSortDescending: "{{ __('datatable.oAria.sSortDescending') }}",
          }
        },
        buttons: [
          {
            extend: 'collection',
            text: "{{ __('translate.EXPORT') }}",
            buttons: ['print', 'pdf', 'excel', 'csv'].map(type => ({
              extend: type,
              text: type,
              exportOptions: {
                columns: ':visible:Not(.not_show)',
                rows: ':visible'
              }
            }))
          }
        ]
      });
    }

    $(document).bind('event_category', function () {
      $('#modal_Category').modal('hide');
      $('#category_table').DataTable().destroy();
      Category_datatable();
    });

    $(document).on('click', '.new_category', function () {
      app.editmode = false;
      app.reset_Form();
      $('#modal_Category').modal('show');
    });

    $(document).on('click', '.edit', function () {
      NProgress.start();
      NProgress.set(0.1);
      app.editmode = true;
      app.reset_Form();
      app.Get_Data_Edit($(this).attr('id'));

      setTimeout(() => {
        NProgress.done();
        $('#modal_Category').modal('show');
      }, 500);
    });

    $(document).on('click', '.delete', function () {
      app.Remove_Category($(this).attr('id'));
    });
  });
</script>

<script>
  var app = new Vue({
    el: '#section_Category_list',
    data: {
      editmode: false,
      SubmitProcessing: false,
      errors: [],
      category: {
        id: "",
        name: "",
        code: "",
        image: "",
      }
    },

    methods: {
      handleImageUpload(e) {
        this.category.image = e.target.files[0];
      },

      getImageUrl(image) {
        if (typeof image === 'string') {
          return image.startsWith('http') ? image : '/storage/images/categories/' + image;
        }
        return URL.createObjectURL(image);
      },

      reset_Form() {
        this.category = {
          id: "",
          name: "",
          code: "",
          image: "",
        };
        this.errors = {};
      },

      Get_Data_Edit(id) {
        axios.get("/products/categories/" + id + "/edit")
          .then(response => {
            this.category = response.data.category;
          }).catch(console.error);
      },

      Create_Category() {
        this.SubmitProcessing = true;
        let formData = new FormData();
        formData.append('name', this.category.name);
        formData.append('code', this.category.code);
        if (this.category.image instanceof File) {
          formData.append('image', this.category.image);
        }

        axios.post("/products/categories", formData)
          .then(() => {
            this.SubmitProcessing = false;
            $.event.trigger('event_category');
            toastr.success('{{ __('translate.Created_in_successfully') }}');
            this.errors = {};
          })
          .catch(error => {
            this.SubmitProcessing = false;
            if (error.response.status == 422) {
              this.errors = error.response.data.errors;
            }
            toastr.error('{{ __('translate.There_was_something_wronge') }}');
          });
      },

      Update_Category() {
        this.SubmitProcessing = true;
        let formData = new FormData();
        formData.append('name', this.category.name);
        formData.append('code', this.category.code);
        formData.append('_method', 'PUT');
        if (this.category.image instanceof File) {
          formData.append('image', this.category.image);
        }

        axios.post("/products/categories/" + this.category.id, formData)
          .then(() => {
            this.SubmitProcessing = false;
            $.event.trigger('event_category');
            toastr.success('{{ __('translate.Updated_in_successfully') }}');
            this.errors = {};
          })
          .catch(error => {
            this.SubmitProcessing = false;
            if (error.response.status == 422) {
              this.errors = error.response.data.errors;
            }
            toastr.error('{{ __('translate.There_was_something_wronge') }}');
          });
      },

      Remove_Category(id) {
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
        }).then(() => {
          axios.delete("/products/categories/" + id)
            .then(() => {
              $.event.trigger('event_category');
              toastr.success('{{ __('translate.Deleted_in_successfully') }}');
            })
            .catch(() => {
              toastr.error('{{ __('translate.There_was_something_wronge') }}');
            });
        });
      },
    }
  });
</script>

@endsection
