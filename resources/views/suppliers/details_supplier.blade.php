@extends('layouts.master')

@section('page-css')
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/datatables.min.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/nprogress.css') }}">
    <link rel="stylesheet" href="{{ asset('assets/styles/vendor/datepicker.min.css') }}">
@endsection

@section('main-content')

<div class="breadcrumb">
    <h1>{{ __('translate.Provider_details') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div id="section_supplier_details">
    <div class="card">
        <div class="card-body">

            {{-- Supplier Basic Info --}}
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                    <table class="display table table-md">
                        <tbody>
                            <tr>
                                <th>{{ __('translate.FullName') }}</th>
                                <td>{{ $supplier_data['full_name'] }}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Code') }}</th>
                                <td>{{ $supplier_data['code'] }}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Phone') }}</th>
                                <td>{{ $supplier_data['phone'] }}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Address') }}</th>
                                <td>{{ $supplier_data['address'] }}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            {{-- Stats Cards --}}
            <div class="row">
                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-icon-big mb-4">
                        <div class="card-body text-center">
                            <i class="i-Full-Cart"></i>
                            <div class="content">
                                <p class="text-muted mt-2 mb-2">{{ __('translate.Total Purchases') }}</p>
                                <p class="text-primary text-24 line-height-1 m-0">{{ $supplier_data['total_purchases'] }}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-icon-big mb-4">
                        <div class="card-body text-center">
                            <i class="i-Money-2"></i>
                            <div class="content">
                                <p class="text-muted mt-2 mb-2">{{ __('translate.Total Amount') }}</p>
                                <p class="text-primary text-24 line-height-1 m-0">{{ $supplier_data['total_amount'] }}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-icon-big mb-4">
                        <div class="card-body text-center">
                            <i class="i-Money-Bag"></i>
                            <div class="content">
                                <p class="text-muted mt-2 mb-2">{{ __('translate.Total paid') }}</p>
                                <p class="text-primary text-24 line-height-1 m-0">{{ $supplier_data['total_paid'] }}</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-icon-big mb-4">
                        <div class="card-body text-center">
                            <i class="i-Financial"></i>
                            <div class="content">
                                <p class="text-muted mt-2 mb-2">{{ __('translate.Total debt') }}</p>
                                <p class="text-primary text-24 line-height-1 m-0">{{ $supplier_data['total_debt'] }}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {{-- Purchases History Table --}}
            <div class="card mt-4">
                <div class="card-body">
                    <h4 class="mb-3">Purchases History</h4>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>
                                    <th>Reference</th>
                                    <th>Date</th>
                                    <th>Grand Total</th>
                                    <th>Paid Amount</th>
                                    <th>Status</th>
                                    <th>Payment Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($purchases as $purchase)
                                    <tr>
                                        <td>{{ $purchase->Ref }}</td>
                                        <td>{{ \Carbon\Carbon::parse($purchase->date)->format('d M Y') }}</td>
                                        <td>{{ $purchase->GrandTotal }}</td>
                                        <td>{{ $purchase->paid_amount }}</td>
                                        <td>{{ $purchase->statut }}</td>
                                        <td>
                                            @if($purchase->payment_statut === 'paid')
                                                <span class="badge badge-success">Paid</span>
                                            @elseif($purchase->payment_statut === 'partial')
                                                <span class="badge badge-warning">Partial</span>
                                            @else
                                                <span class="badge badge-danger">Unpaid</span>
                                            @endif
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="6" class="text-center">No purchases found.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div> {{-- card-body --}}
    </div> {{-- card --}}
</div> {{-- section_supplier_details --}}

@endsection

@section('page-js')
    <script src="{{ asset('assets/js/nprogress.js') }}"></script>

    <script>
        var app = new Vue({
            el: '#section_supplier_details',
            data: {
                SubmitProcessing: false,
            },
            methods: {},
            created() {}
        });
    </script>
@endsection
