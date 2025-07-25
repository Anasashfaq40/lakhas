@extends('layouts.master')
@section('main-content')
@section('page-css')

<link rel="stylesheet" href="{{asset('assets/styles/vendor/datatables.min.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/nprogress.css')}}">
<link rel="stylesheet" href="{{asset('assets/styles/vendor/datepicker.min.css')}}">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />



@endsection

<div class="breadcrumb">
    <h1>{{ __('translate.Customer_details') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>



<div id="section_Client_details">
    <div class="card">
        <div class="card-body">
            <div class="row">
                <div class="ol-lg-3 col-md-6 col-sm-6 col-12">
                    <table class="display table table-md">
                        <tbody>
                            <tr>
                                <th>{{ __('translate.FullName') }}</th>
                                <td>{{$client_data['full_name']}}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Code') }}</th>
                                <td>{{$client_data['code']}}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Phone') }}</th>
                                <td>{{$client_data['phone']}}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Address') }}</th>
                                <td>{{$client_data['address']}}</td>
                            </tr>
                            <tr>
                                <th>{{ __('translate.Status') }}</th>
                                <td>
                                    @if($client_data['status'] == 1)
                                    <span class="badge badge-success">{{ __('translate.Active Client') }}</span>
                                    @else
                                    <span class="badge badge-danger">{{ __('translate.Inactive Client') }}</span>
                                    @endif
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="row">

                <div class="col-lg-3 col-md-6 col-sm-6">
                    <div class="card card-icon-big mb-4">
                        <div class="card-body text-center">
                            <i class="i-Full-Cart"></i>
                            <div class="content">
                                <p class="text-muted mt-2 mb-2">{{ __('translate.Total Sales') }}</p>
                                <p class="text-primary text-24 line-height-1 m-0" id="sales_data">
                                    {{$client_data['total_sales']}}</p>
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
                                <p class="text-primary text-24 line-height-1 m-0" id="purchases_data">
                                    {{$client_data['total_amount']}}</p>
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
                                <p class="text-primary text-24 line-height-1 m-0" id="return_sales_data">
                                    {{$client_data['total_paid']}}</p>
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
                                <p class="text-primary text-24 line-height-1 m-0" id="return_purchases_data">
                                    {{$client_data['total_debt']}}</p>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>
    <div class="card mt-4">
    <div class="card-header">
        <h4>{{ __('Sales History') }}</h4>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-bordered" id="sales-history-table">
                <thead>
                    <tr>
                        <th>{{ __('translate.Ref') }}</th>
                        <th>{{ __('translate.Date') }}</th>
                        <th>{{ __('Created At') }}</th>
                          <th>{{ __('translate.Action') }}</th> 
                    </tr>
                </thead>
                <tbody>
                    @forelse($sales as $sale)
                        <tr>
                            <td>{{ $sale->Ref }}</td>
                            <td>{{ \Carbon\Carbon::parse($sale->date)->format('d M Y') }}</td>
                            <td>{{ \Carbon\Carbon::parse($sale->created_at)->format('d M Y h:i A') }}</td>
                   <td>
    <a href="{{ route('clients.sales.details', $sale->id) }}" class="btn btn-sm btn-info">
        <i class="fas fa-eye"></i> View Sales
    </a>
</td>

                        </tr>
                    @empty
                        <tr>
                            <td colspan="3" class="text-center">{{ __('translate.No Sales Found') }}</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>


</div>


@endsection

@section('page-js')

<script src="{{asset('assets/js/nprogress.js')}}"></script>



<script>
    var app = new Vue({
        el: '#section_Client_details',
        data: {
            SubmitProcessing:false,
        },
       
        methods: {
        
          
           
        },
        //-----------------------------Autoload function-------------------
        created() {
        }
    })
</script>

@endsection