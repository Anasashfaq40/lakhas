@extends('layouts.master')
@section('main-content')
@section('page-css')
@endsection

<div class="breadcrumb">
  <h1>{{ __('translate.Details_Sale') }}</h1>
</div>

<div class="separator-breadcrumb border-top"></div>

<div class="row" id="section_sale_detail">
  <div class="col-md-12">
    @if (auth()->user()->can('sales_edit'))
      <a v-if="sale.sale_has_return == 'no'" class="btn-sm btn btn-success ripple btn-icon m-1" :href="'/sale/sales/'+sale.id+'/edit'">
        <i class="i-Edit"></i>
        <span>{{ __('translate.Edit_Sale') }}</span>
      </a>
    @endif

    <a onclick="printDiv()" class="btn-sm btn btn-warning ripple btn-icon m-1">
      <i class="i-Billing"></i>
      {{ __('translate.Print_Sale') }}
    </a>
    @can('sales_delete')
    <a v-if="sale.sale_has_return == 'no'" @click="Delete_Sale(sale.id)" class="btn btn-danger btn-icon icon-left btn-sm m-1">
      <i class="i-Close-Window"></i>
      {{ __('translate.Delete_Sale') }}
    </a>
    @endcan

    <hr>
    
    <div class="invoice-print" id="print_Invoice" style="position: relative; z-index: 1;">
      <div style="text-align: center; margin-bottom: 20px;">
        <img src="{{ asset('images/1745664460.png') }}" alt="Logo" style="max-height: 100px;">
      </div>
      <div style="
        position: absolute;
        top: 40%;
        left: 50%;
        transform: translate(-50%, -50%) rotate(-30deg);
        font-size: 100px;
        color: rgba(0, 0, 0, 0.05);
        font-weight: bold;
        white-space: nowrap;
        pointer-events: none;
        z-index: 0;
      ">
        The Lakhas
      </div>
      
      <!-- INFO SECTION -->
      <div class="row mt-5 align-items-start">
        <div class="col-md-4">
          <h5 class="font-weight-bold">{{ __('translate.Customer_Info') }}</h5>
          <div>@{{sale.client_name}}</div>
          <div>@{{sale.client_email}}</div>
          <div>@{{sale.client_phone}}</div>
          <div>@{{sale.client_adr}}</div>
        </div>
        <div class="col-md-4">
          <h5 class="font-weight-bold">{{ __('translate.Company_Info') }}</h5>
          <div>@{{company.CompanyName}}</div>
          <div>@{{company.email}}</div>
          <div>@{{company.CompanyPhone}}</div>
          <div>@{{company.CompanyAdress}}</div>
        </div>
        <div class="col-md-4">
          <h5 class="font-weight-bold">{{ __('translate.Sale_Info') }}</h5>
          <div>{{ __('translate.Reference') }} : @{{sale.Ref}}</div>
          <div>
            {{ __('translate.Status') }} :
            <span v-if="sale.statut == 'completed'" class="badge badge-outline-success">{{ __('translate.Completed') }}</span>
            <span v-else-if="sale.statut == 'pending'" class="badge badge-outline-info">{{ __('translate.Pending') }}</span>
            <span v-else class="badge badge-outline-warning">{{ __('translate.Ordered') }}</span>
          </div>
          <div>
            {{ __('translate.Payment_Status') }} :
            <span v-if="sale.payment_status == 'paid'" class="badge badge-outline-success">{{ __('translate.Paid') }}</span>
            <span v-else-if="sale.payment_status == 'partial'" class="badge badge-outline-info">{{ __('translate.Partial') }}</span>
            <span v-else class="badge badge-outline-warning">{{ __('translate.Unpaid') }}</span>
          </div>
          <div>{{ __('translate.date') }} : @{{sale.date}}</div>
          <div>{{ __('translate.warehouse') }} : @{{sale.warehouse}}</div>
          <div>{{ __('Rider') }} : @{{sale.assigned_driver}}</div>
        </div>
      </div>

      <!-- ORDER SUMMARY -->
      <div class="row mt-3">
        <div class="col-md-12">
          <h5 class="font-weight-bold">{{ __('translate.Order_Summary') }}</h5>
          <div class="table-responsive">
            <table class="table table-hover table-md">
              <thead>
                <tr>
                  <th>{{ __('translate.Product_Name') }}</th>
                  <th>{{ __('translate.Net_Unit_Price') }}</th>
                  <th>{{ __('translate.Quantity') }}</th>
                  <th>{{ __('translate.Unit_Price') }}</th>
                  <th>{{ __('translate.Discount') }}</th>
                  <th>{{ __('translate.Tax') }}</th>
                  <th>{{ __('translate.SubTotal') }}</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="detail in details">
                  <td>
                    <span>@{{detail.name}}</span>
                    <p v-show="detail.is_imei && detail.imei_number !== null">IMEI_SN : @{{detail.imei_number}}</p>
                    
                    <!-- Shalwar Kameez Measurements -->
    <div v-if="detail.garment_type === 'shalwar_suit' && (detail.kameez_length || detail.shalwar_length)" class="mt-2">
      <h6 class="font-weight-bold mb-1">Shalwar Kameez Measurements:</h6>
      <div class="row small">
        <!-- Kameez Measurements -->
        <div class="col-md-4" v-if="detail.kameez_length">
          <div>Kameez Length: @{{ detail.kameez_length }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_shoulder">
          <div>Shoulder: @{{ detail.kameez_shoulder }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_sleeves">
          <div>Sleeves: @{{ detail.kameez_sleeves }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_chest">
          <div>Chest: @{{ detail.kameez_chest }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_upper_waist">
          <div>Upper Waist: @{{ detail.kameez_upper_waist }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_lower_waist">
          <div>Lower Waist: @{{ detail.kameez_lower_waist }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_hip">
          <div>Hip: @{{ detail.kameez_hip }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_neck">
          <div>Neck: @{{ detail.kameez_neck }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_arms">
          <div>Arms: @{{ detail.kameez_arms }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_cuff">
          <div>Cuff: @{{ detail.kameez_cuff }}</div>
        </div>
        <div class="col-md-4" v-if="detail.kameez_biceps">
          <div>Biceps: @{{ detail.kameez_biceps }}</div>
        </div>
        
        <!-- Shalwar Measurements -->
        <div class="col-md-4" v-if="detail.shalwar_length">
          <div>Shalwar Length: @{{ detail.shalwar_length }}</div>
        </div>
        <div class="col-md-4" v-if="detail.shalwar_waist">
          <div>Waist: @{{ detail.shalwar_waist }}</div>
        </div>
        <div class="col-md-4" v-if="detail.shalwar_bottom">
          <div>Bottom: @{{ detail.shalwar_bottom }}</div>
        </div>
      </div>
    </div>
    
    <!-- Pant Shirt Measurements -->
    <div v-if="detail.garment_type === 'pant_shirt' && (detail.pshirt_length || detail.pant_length)" class="mt-2">
      <h6 class="font-weight-bold mb-1">Pant Shirt Measurements:</h6>
      <div class="row small">
        <!-- Shirt Measurements -->
        <div class="col-md-4" v-if="detail.pshirt_length">
          <div>Shirt Length: @{{ detail.pshirt_length }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_shoulder">
          <div>Shoulder: @{{ detail.pshirt_shoulder }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_sleeves">
          <div>Sleeves: @{{ detail.pshirt_sleeves }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_chest">
          <div>Chest: @{{ detail.pshirt_chest }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_neck">
          <div>Neck: @{{ detail.pshirt_neck }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_collar_shirt || detail.pshirt_collar_round || detail.pshirt_collar_square">
          <div>Collar: 
            <span v-if="detail.pshirt_collar_shirt">Shirt</span>
            <span v-if="detail.pshirt_collar_round">, Round</span>
            <span v-if="detail.pshirt_collar_square">, Square</span>
          </div>
        </div>
                    
                 <!-- Pant Shirt Measurements -->
    <div v-if="detail.garment_type === 'pant_shirt' && (detail.pshirt_length || detail.pant_length)" class="mt-2">
      <h6 class="font-weight-bold mb-1">Pant Shirt Measurements:</h6>
      <div class="row small">
        <!-- Shirt Measurements -->
        <div class="col-md-4" v-if="detail.pshirt_length">
          <div>Shirt Length: @{{ detail.pshirt_length }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_shoulder">
          <div>Shoulder: @{{ detail.pshirt_shoulder }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_sleeves">
          <div>Sleeves: @{{ detail.pshirt_sleeves }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_chest">
          <div>Chest: @{{ detail.pshirt_chest }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_neck">
          <div>Neck: @{{ detail.pshirt_neck }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pshirt_collar_shirt || detail.pshirt_collar_round || detail.pshirt_collar_square">
          <div>Collar: 
            <span v-if="detail.pshirt_collar_shirt">Shirt</span>
            <span v-if="detail.pshirt_collar_round">, Round</span>
            <span v-if="detail.pshirt_collar_square">, Square</span>
          </div>
        </div>
        
        <!-- Pant Measurements -->
        <div class="col-md-4" v-if="detail.pant_length">
          <div>Pant Length: @{{ detail.pant_length }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pant_waist">
          <div>Waist: @{{ detail.pant_waist }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pant_hip">
          <div>Hip: @{{ detail.pant_hip }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pant_thigh">
          <div>Thigh: @{{ detail.pant_thigh }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pant_knee">
          <div>Knee: @{{ detail.pant_knee }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pant_bottom">
          <div>Bottom: @{{ detail.pant_bottom }}</div>
        </div>
        <div class="col-md-4" v-if="detail.pant_fly">
          <div>Fly: @{{ detail.pant_fly }}</div>
        </div>
      </div>
    </div>
    
    <!-- Other Measurements -->
    <div v-if="detail.thaan_length || detail.suit_length" class="mt-2">
      <h6 class="font-weight-bold mb-1">Other Measurements:</h6>
      <div class="row small">
        <div class="col-md-4" v-if="detail.thaan_length">
          <div>Thaan Length: @{{ detail.thaan_length }}</div>
        </div>
        <div class="col-md-4" v-if="detail.suit_length">
          <div>Suit Length: @{{ detail.suit_length }}</div>
        </div>
      </div>
    </div>
    
    <!-- Available Sizes -->
    <div v-if="detail.available_sizes" class="mt-1">
      <strong>Available Sizes:</strong> @{{ detail.available_sizes }}
    </div>
  </td>
                  </td>
                  <td>@{{formatNumber(detail.Net_price,2)}}</td>
                  <td>@{{formatNumber(detail.quantity,2)}} @{{detail.unit_sale}}</td>
                  <td>@{{formatNumber(detail.price,2)}}</td>
                  <td>@{{formatNumber(detail.DiscountNet,2)}}</td>
                  <td>@{{formatNumber(detail.taxe,2)}}</td>
                  <td>@{{detail.total.toFixed(2)}}</td>
                </tr>
                <tfoot>
                  <tr>
                    <td colspan="2"><span class="font-weight-bold">Total Products : @{{ details.length }}</span></td>
                    <td colspan="5"><span class="font-weight-bold">@{{sale.total_quantity}}</span></td>
                  </tr>
                </tfoot>
              </tbody>
            </table>
          </div>
        </div>

        <!-- TOTALS -->
        <div class="offset-md-9 col-md-3 mt-4">
          <table class="table table-striped table-sm">
            <tbody>
              <tr>
                <td class="bold">{{ __('translate.Order_Tax') }}</td>
                <td><span>@{{sale.TaxNet}} (@{{formatNumber(sale.tax_rate ,2)}} %)</span></td>
              </tr>
              <tr>
                <td class="bold">{{ __('translate.Discount') }}</td>
                <td>
                  <div>@{{ sale.discount }}</div>
                  <div v-if="sale.product_discount_total">
                    + @{{ sale.product_discount_total }} <small class="text-muted">({{ __('Product Discounts') }})</small>
                  </div>
                </td>
              </tr>
              <tr>
                <td class="bold">{{ __('translate.Shipping') }}</td>
                <td>@{{sale.shipping}}</td>
              </tr>
              <tr>
                <td><span class="font-weight-bold">{{ __('translate.Total') }}</span></td>
                <td><span class="font-weight-bold">@{{sale.GrandTotal}}</span></td>
              </tr>
              <tr>
                <td><span class="font-weight-bold">{{ __('translate.Paid') }}</span></td>
                <td><span class="font-weight-bold">@{{sale.paid_amount}}</span></td>
              </tr>
              <tr>
                <td><span class="font-weight-bold">{{ __('translate.Due') }}</span></td>
                <td><span class="font-weight-bold">@{{sale.due}}</span></td>
              </tr>
              <tr>
                <td><span class="font-weight-bold">{{ __('Previous Balance') }}</span></td>
                <td><span class="font-weight-bold">@{{ sale.previous_balance }}</span></td>
              </tr>
              <tr>
                <td><span class="font-weight-bold">{{ __('Updated Balance') }}</span></td>
                <td><span class="font-weight-bold">@{{ sale.updated_balance }}</span></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>

      <!-- SALE NOTE -->
      <hr v-show="sale.note">
      <div class="row mt-4">
        <div class="col-md-12">
          <p>@{{sale.note}}</p>
        </div>
      </div>

      <!-- SIGNATURE -->
      <div class="row mt-5">
        <div class="col-md-6">
          <h6 class="font-weight-bold mb-2">Authorized Signature</h6>
          <div style="border: 1px solid #000; height: 100px;"></div>
        </div>
      </div>
    </div>
  </div>
</div>

@endsection

@section('page-js')
<script src="{{asset('assets/js/nprogress.js')}}"></script>

<script>
  function printDiv() {
    var printContents = document.getElementById('print_Invoice').outerHTML;
    var printWindow = window.open('', '_blank', 'width=1200,height=1000');

    const tabloidStyle = `
      <style>
        @media print {
          @page {
            size: A4;
            margin: 20mm;
          }
          body {
            -webkit-print-color-adjust: exact;
            font-size: 13px;
          }
          .badge {
            border: 1px solid #000;
            padding: 2px 5px;
          }
          .table {
            border-collapse: collapse;
            width: 100%;
          }
          .table th, .table td {
            border: 1px solid #ddd;
            padding: 5px;
          }
          .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0,0,0,.05);
          }
        }
      </style>
    `;

    printWindow.document.open();
    printWindow.document.write('<html><head><title>Print</title>');
    printWindow.document.write('<link rel="stylesheet" href="/assets_setup/css/bootstrap.css">');
    printWindow.document.write(tabloidStyle);
    printWindow.document.write('</head><body>');
    printWindow.document.write(printContents);
    printWindow.document.write('</body></html>');
    printWindow.document.close();

    setTimeout(() => {
      printWindow.print();
    }, 1000);
  }
</script>

<script>
  var app = new Vue({
    el: '#section_sale_detail',
    data: {
      editmode: false,
      SubmitProcessing:false,
      errors:[],
      sale: @json($sale),
      details: @json($details),
      company: @json($company),
      email: {
        to: "",
        subject: "",
        message: "",
        client_name: "",
        Sale_Ref: ""
      }
    },
   
    methods: {
      //----------------------------------- Invoice Sale PDF  -------------------------\\
      Sale_PDF(id) {
        NProgress.start();
        NProgress.set(0.1);          
        axios
          .get('/Sale_PDF/'+ id, {
            responseType: "blob",
            headers: {
              "Content-Type": "application/json"
            }
          })
          .then(response => {
            const url = window.URL.createObjectURL(new Blob([response.data]));
            const link = document.createElement("a");
            link.href = url;
            link.setAttribute("download", "Sale_" + this.sale.Ref + ".pdf");
            document.body.appendChild(link);
            link.click();
            setTimeout(() => NProgress.done(), 500);
          })
          .catch(() => {
            setTimeout(() => NProgress.done(), 500);
          });
      },
   
      //------------------------------Formetted Numbers -------------------------\\
      formatNumber(number, dec) {
        const value = (typeof number === "string"
          ? number
          : number.toString()
        ).split(".");
        if (dec <= 0) return value[0];
        let formated = value[1] || "";
        if (formated.length > dec)
          return `${value[0]}.${formated.substr(0, dec)}`;
        while (formated.length < dec) formated += "0";
        return `${value[0]}.${formated}`;
      },

      //---------SMS notification
      Sale_SMS(id) {
        NProgress.start();
        NProgress.set(0.1);
        axios
          .post("/sales_send_sms", {
            id: id,
          })
          .then(response => {
            setTimeout(() => NProgress.done(), 500);
            toastr.success('{{ __('translate.sent_in_successfully') }}');
          })
          .catch(error => {
            setTimeout(() => NProgress.done(), 500);
            toastr.error('{{ __('translate.There_was_something_wronge') }}');
          });
      },
        
      //--------------------------------- Send Sale in Email ------------------------------\\
      Sale_Email(id) {
        this.email.to = this.sale.client_email;
        this.email.Sale_Ref = this.sale.Ref;
        this.email.client_name = this.sale.client_name;
        this.Send_Email(id);
      },

      Send_Email(id) {
        NProgress.start();
        NProgress.set(0.1);
        axios
          .post("/sale/sales/send/email", {
            id: id,
            to: this.email.to,
            client_name: this.email.client_name,
            Ref: this.email.Sale_Ref
          })
          .then(response => {
            setTimeout(() => NProgress.done(), 500);
            toastr.success('{{ __('translate.sent_in_successfully') }}');
          })
          .catch(error => {
            setTimeout(() => NProgress.done(), 500);
            toastr.error('{{ __('translate.There_was_something_wronge') }}');
          });
      },
 
      //--------------------------------- Delete_Sale ---------------------------\\
      Delete_Sale(id) {
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
            .delete("/sale/sales/" + id)
            .then(() => {
              toastr.success('{{ __('translate.Deleted_in_successfully') }}');
              window.location.href = '/sale/sales';
            })
            .catch(() => {
              toastr.error('{{ __('translate.There_was_something_wronge') }}');
            });
        });
      }
    },

    created() {
    }
  })
</script>
@endsection