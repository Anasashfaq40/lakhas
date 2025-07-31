@extends('layouts.master')

@section('main-content')
@section('page-css')
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/nprogress.css') }}">
@endsection

<div class="breadcrumb">
    <h1>{{ __('All Reviews') }}</h1>
</div>
<div class="separator-breadcrumb border-top"></div>

<div id="section_Review_list">
    <div class="card">
        <div class="card-body">
            <div class="table-responsive">
                <table id="review-table" class="display table">
                    <thead>
                        <tr>
                            <th>{{ __('User') }}</th>
                            <th>{{ __('Product') }}</th>
                            <th>{{ __('Rating') }}</th>
                            <th>{{ __('Comment') }}</th>
                            <th>{{ __('Date') }}</th>
                            <th>{{ __('Action') }}</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($reviews as $review)
                        <tr>
                            <td>{{ $review->user->username ?? '-' }}</td>
                            <td>{{ $review->product->name ?? '-' }}</td>
<td>
    @for ($i = 1; $i <= 5; $i++)
        <i class="{{ $i <= $review->rating ? 'fas fa-star' : 'far fa-star' }}" style="color: #f5b50a;"></i>
    @endfor
</td>


                            <td>{{ $review->comment }}</td>
                            <td>{{ $review->created_at->format('d M Y') }}</td>
                            <td>
                                <a @click="DeleteReview({{ $review->id }})" class="cursor-pointer text-danger ul-link-action" 
                                   data-toggle="tooltip" data-placement="top" title="Delete">
                                    <i class="i-Close-Window"></i>
                                </a>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
                {{ $reviews->links() }}
            </div>
        </div>
    </div>
</div>
@endsection

@section('page-js')
<script src="{{ asset('assets/js/vendor/datatables.min.js') }}"></script>
<script src="{{ asset('assets/js/nprogress.js') }}"></script>

<script>
    $(function () {
        "use strict";

        $('#review-table').DataTable({
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
        el: '#section_Review_list',
        methods: {
            DeleteReview(id) {
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
                        .delete("/reviews/" + id)
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
