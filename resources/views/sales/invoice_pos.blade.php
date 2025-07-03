<?php
// $languageDirection = $_COOKIE['language'] == 'ar' ? 'rtl' : 'ltr';
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>The Lakhas </title>
  <link rel=icon href={{ asset('images/logo.svg') }}>

  <!-- CSS Files -->
  <link rel="stylesheet" href="{{asset('assets/styles/vendor/invoice_pos.css')}}">
  <script src="{{asset('/assets/js/vue.js')}}"></script>

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      font-size: 11px;
      line-height: 1.3;
    }
    
    #invoice-POS {
      width: 100%;
      max-width: 297mm; /* Changed from 210mm to 297mm for landscape */
      margin: 0 auto;
      padding: 10px;
      background: #FFF;
      position: relative;
      overflow: visible;
      min-height: 210mm; /* Changed from 297mm to 210mm for landscape */
      box-sizing: border-box;
    }

    #invoice-POS::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: url('{{ asset('images/watermark.jpg') }}');
      background-position: center;
      background-repeat: no-repeat;
      background-size: 40%;
      opacity: 0.05;
      z-index: 0;
      pointer-events: none;
    }

    #invoice-POS > * {
      position: relative;
      z-index: 1;
    }
    
    .invoice-container {
      display: flex;
      flex-direction: row;
      gap: 5mm;
      width: 100%;
      min-height: 190mm; /* Adjusted for landscape */
      box-sizing: border-box;
    }
    
    .left-section {
      width: 60%; /* Increased width for left section */
      flex: 0 0 60%;
      border-right: 2px dotted #000;
      padding-right: 5mm;
      box-sizing: border-box;
    }
    
    .right-section {
      width: 40%; /* Adjusted width for right section */
      flex: 0 0 40%;
      padding-left: 5mm;
      box-sizing: border-box;
    }
    
    .header-section {
      text-align: center;
      margin-bottom: 15px;
      border-bottom: 2px solid #000;
      padding-bottom: 10px;
    }
    
    .company-name {
      font-size: 20px;
      font-weight: bold;
      margin-bottom: 5px;
    }
    
    .company-tagline {
      font-size: 12px;
      font-style: italic;
      margin-bottom: 5px;
    }
    
    .company-details {
      font-size: 9px;
      line-height: 1.2;
    }
    
    .order-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
      flex-wrap: wrap;
    }
    
    .order-number {
      font-size: 14px;
      font-weight: bold;
    }
    
    .order-form-label {
      border: 1px solid #000;
      padding: 3px 8px;
      font-weight: bold;
      font-size: 10px;
    }
    
    .customer-section {
      margin-bottom: 15px;
    }
    
    .form-row {
      display: flex;
      margin-bottom: 6px;
      align-items: center;
    }
    
    .form-label {
      font-weight: bold;
      margin-right: 8px;
      min-width: 70px;
      font-size: 10px;
    }
    
    .form-input {
      border-bottom: 1px solid #000;
      flex: 1;
      padding: 2px 3px;
      min-height: 14px;
      font-size: 10px;
    }
    
    .dates-section {
      display: flex;
      gap: 15px;
      margin-bottom: 15px;
      font-size: 9px;
      flex-wrap: wrap;
    }
    
    .date-item {
      display: flex;
      align-items: center;
      gap: 3px;
    }
    
    .date-input {
      border-bottom: 1px solid #000;
      min-width: 60px;
      padding: 2px;
      font-size: 9px;
    }
    
    .items-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 15px;
      font-size: 10px;
    }
    
    .items-table th,
    .items-table td {
      border: 1px solid #000;
      padding: 4px;
      text-align: center;
    }
    
    .items-table th {
      background-color: #f0f0f0;
      font-weight: bold;
      font-size: 9px;
    }
    
    .items-col {
      width: 40%;
    }
    
    .qty-col {
      width: 20%;
    }
    
    .rate-col {
      width: 20%;
    }
    
    .total-col {
      width: 20%;
    }
    
    .terms-section {
      margin-top: 15px;
      font-size: 8px;
      line-height: 1.2;
    }
    
    .terms-title {
      font-weight: bold;
      text-decoration: underline;
      margin-bottom: 5px;
    }
    
    .right-header {
      text-align: center;
      margin-bottom: 15px;
      border-bottom: 1px solid #000;
      padding-bottom: 8px;
    }
    
    .measurements-section {
      margin-bottom: 15px;
    }
    
    .measurement-category {
      font-weight: bold;
      text-decoration: underline;
      margin-bottom: 8px;
      font-size: 11px;
    }
    
    .measurement-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 4px;
      margin-bottom: 12px;
    }
    
    .measurement-item {
      display: flex;
      align-items: center;
      gap: 3px;
    }
    
    .measurement-label {
      min-width: 60px;
      font-size: 9px;
    }
    
    .measurement-input {
      border-bottom: 1px solid #000;
      flex: 1;
      min-height: 12px;
      padding: 1px 2px;
      font-size: 9px;
    }
    
    .style-options {
      margin-bottom: 12px;
    }
    
    .style-row {
      display: flex;
      align-items: center;
      margin-bottom: 4px;
      gap: 8px;
      font-size: 9px;
    }
    
    .checkbox-group {
      display: flex;
      gap: 10px;
    }
    
    .checkbox-item {
      display: flex;
      align-items: center;
      gap: 2px;
      font-size: 8px;
    }
    
 
    
    .notes-section {
      margin-top: 8px;
    }
    
    .notes-label {
      font-weight: bold;
      margin-bottom: 4px;
      font-size: 10px;
    }
    
    .notes-area {
      border: 1px solid #000;
      height: 40px;
      width: 100%;
      padding: 3px;
      font-size: 8px;
      box-sizing: border-box;
    }
    
    .hidden-print {
      margin-bottom: 20px;
    }
    
    /* Landscape orientation for printing */
    @page {
      size: A4 landscape;
      margin: 0;
    }
    
    /* Responsive adjustments */
    @media screen and (max-width: 1200px) {
      .invoice-container {
        flex-direction: column;
      }
      
      .left-section,
      .right-section {
        width: 100%;
        flex: none;
      }
      
      .left-section {
        border-right: none;
        border-bottom: 2px dotted #000;
        padding-right: 0;
        padding-bottom: 10px;
        margin-bottom: 10px;
      }
      
      .right-section {
        padding-left: 0;
        padding-top: 10px;
      }
    }
    
    @media print {
      .hidden-print {
        display: none;
      }
      
      body {
        margin: 0;
        padding: 0;
      }
      
      #invoice-POS {
        width: 100%;
        margin: 0;
        padding: 5mm;
        max-width: none;
      }
      
      .invoice-container {
        flex-direction: row;
      }
      
      .left-section,
      .right-section {
        width: 60% 40%; /* Maintain landscape proportions */
        flex: 0 0 60% 40%;
      }
      
      .left-section {
        border-right: 2px dotted #000;
        border-bottom: none;
        padding-right: 5mm;
        margin-bottom: 0;
      }
      
      .right-section {
        padding-left: 5mm;
        padding-top: 0;
      }
    }
  </style>
</head>

<body>
  <div id="in_pos">
    <div class="hidden-print">
      <a @click="print_pos()" class="btn btn-primary">{{ __('translate.print') }}</a>
      <br>
    </div>
    
    <div id="invoice-POS">
      <div class="invoice-container">
        <!-- Left Section -->
        <div class="left-section">
          <!-- Header -->
          <div class="header-section">
            <div class="company-name">@{{setting?.CompanyName ?? 'Fashion House'}}</div>
            <div class="company-tagline">LET'S LOVE FASHION</div>
            <div class="company-details">
              <div>@{{setting?.CompanyAddress ?? 'Address not available'}}</div>
              <div>Phone: @{{setting?.CompanyPhone ?? 'N/A'}}</div>
              <div>@{{setting?.CompanyEmail ?? ''}}</div>
            </div>
          </div>
          
          <!-- Order Header -->
          <div class="order-header">
            <div class="order-number">Order # @{{sale?.Ref ?? 'N/A'}}</div>
            <div class="order-form-label">Order Form</div>
          </div>
          
          <!-- Customer Information -->
          <div class="customer-section">
            <div class="form-row">
              <span class="form-label">NAME:</span>
              <div class="form-input">@{{sale?.client_name ?? ''}}</div>
            </div>
            <div class="form-row">
              <span class="form-label">ADDRESS:</span>
              <div class="form-input">@{{sale?.client_address ?? ''}}</div>
            </div>
            <div class="form-row">
              <span class="form-label">CONTACT NO:</span>
              <div class="form-input">@{{sale?.client_phone ?? ''}}</div>
            </div>
          </div>
          
          <!-- Dates Section -->
          <div class="dates-section">
            <div class="date-item">
              <span>Order Date:</span>
              <div class="date-input">@{{sale?.date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span>Trial Date:</span>
              <div class="date-input">@{{sale?.trial_date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span>Delivery Date:</span>
              <div class="date-input">@{{sale?.delivery_date ?? ''}}</div>
            </div>
          </div>
          
          <!-- Items Table -->
          <table class="items-table">
            <thead>
              <tr>
                <th class="items-col">ITEMS</th>
                <th class="qty-col">QUANTITY</th>
                <th class="rate-col">RATE</th>
                <th class="total-col">TOTAL</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="detail_invoice in details" :key="detail_invoice.id">
                <td style="text-align: left;">
                  @{{detail_invoice?.name ?? 'N/A'}}
                  <span v-show="detail_invoice?.is_imei && detail_invoice?.imei_number">
                    <br><small>IMEI_SN: @{{detail_invoice?.imei_number ?? ''}}</small>
                  </span>
                </td>
                <td>@{{formatNumber(detail_invoice?.quantity ?? 0, 2)}}</td>
                <td>@{{detail_invoice?.price ?? '0'}}</td>
                <td>@{{detail_invoice?.total ?? '0'}}</td>
              </tr>
              <!-- Empty rows -->
              <tr v-for="n in Math.max(0, 8 - (details?.length ?? 0))" :key="'empty-' + n">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
            </tbody>
          </table>
          
          <!-- Terms and Conditions -->
          <div class="terms-section">
            <div class="terms-title">TERMS AND CONDITIONS</div>
            <div>
              • Goods once sold will not be taken back or exchanged unless there is a manufacturing defect.<br>
              • All payments should be made in advance for custom orders.<br>
              • Delivery dates are approximate and may vary based on workload.<br>
              • Any alterations after final fitting will be charged extra.<br>
              • Please check all measurements and details before confirming the order.
            </div>
          </div>
        </div>
        
        <!-- Right Section -->
        <div class="right-section">
          <!-- Right Header -->
          <div class="right-header">
            <div class="company-name">@{{setting?.CompanyName ?? 'Fashion House'}}</div>
            <div class="company-tagline">LET'S LOVE FASHION</div>
            <div class="order-number">Order # @{{sale?.Ref ?? 'N/A'}}</div>
          </div>
          
          <!-- Customer Info (Right) -->
          <div class="customer-section">
            <div class="form-row">
              <span class="form-label">NAME:</span>
              <div class="form-input">@{{sale?.client_name ?? ''}}</div>
            </div>
            <div class="form-row">
              <span class="form-label">ADDRESS:</span>
              <div class="form-input">@{{sale?.client_address ?? ''}}</div>
            </div>
          </div>
          
          <!-- Dates (Right) -->
          <div class="dates-section">
            <div class="date-item">
              <span>Order Date:</span>
              <div class="date-input">@{{sale?.date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span>Trial Date:</span>
              <div class="date-input">@{{sale?.trial_date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span>Delivery Date:</span>
              <div class="date-input">@{{sale?.delivery_date ?? ''}}</div>
            </div>
          </div>
          
          <!-- Measurements Section -->
          <div class="measurements-section">
            <!-- Shirt/Suit Measurements -->
            <div class="measurement-category">SHIRT/SUIT:</div>
            <div class="measurement-grid">
              <div class="measurement-item">
                <span class="measurement-label">Length:</span>
                <div class="measurement-input">@{{measurements?.shirt_length ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Shoulder:</span>
                <div class="measurement-input">@{{measurements?.shoulder ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Sleeves:</span>
                <div class="measurement-input">@{{measurements?.sleeves ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Chest:</span>
                <div class="measurement-input">@{{measurements?.chest ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Upper Waist:</span>
                <div class="measurement-input">@{{measurements?.upper_waist ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Lower Waist:</span>
                <div class="measurement-input">@{{measurements?.lower_waist ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Hip:</span>
                <div class="measurement-input">@{{measurements?.hip ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Neck:</span>
                <div class="measurement-input">@{{measurements?.neck ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Arms:</span>
                <div class="measurement-input">@{{measurements?.arms ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Cuff:</span>
                <div class="measurement-input">@{{measurements?.cuff ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Biceps:</span>
                <div class="measurement-input">@{{measurements?.biceps ?? ''}}</div>
              </div>
            </div>
            
            <!-- Style Options -->
            <div class="style-options">
              <div class="style-row">
                <span>Collar:</span>
                <div class="checkbox-group">
                  <div class="checkbox-item">
                    <input type="checkbox" :checked="measurements?.collar_type === 'shirt'"> Shirt
                  </div>
                  <div class="checkbox-item">
                    <input type="checkbox" :checked="measurements?.collar_type === 'sherwani'"> Sherwani
                  </div>
                </div>
              </div>
              <div class="style-row">
                <span>Daman:</span>
                <div class="checkbox-group">
                  <div class="checkbox-item">
                    <input type="checkbox" :checked="measurements?.daman_type === 'round'"> Round
                  </div>
                  <div class="checkbox-item">
                    <input type="checkbox" :checked="measurements?.daman_type === 'square'"> Square
                  </div>
                </div>
              </div>
            </div>
            
            <!-- Pant/Shalwar Measurements -->
            <div class="measurement-category">PANT/SHALWAR:</div>
            <div class="measurement-grid">
              <div class="measurement-item">
                <span class="measurement-label">Length:</span>
                <div class="measurement-input">@{{measurements?.pant_length ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Waist:</span>
                <div class="measurement-input">@{{measurements?.waist ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Hip:</span>
                <div class="measurement-input">@{{measurements?.pant_hip ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Thigh:</span>
                <div class="measurement-input">@{{measurements?.thigh ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Knee:</span>
                <div class="measurement-input">@{{measurements?.knee ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Bottom:</span>
                <div class="measurement-input">@{{measurements?.bottom ?? ''}}</div>
              </div>
              <div class="measurement-item">
                <span class="measurement-label">Fly:</span>
                <div class="measurement-input">@{{measurements?.fly ?? ''}}</div>
              </div>
            </div>
          </div>
          
          <!-- Swatches Box -->
         
          
          <!-- Notes Section -->
          <div class="notes-section">
            <div class="notes-label">NOTES:</div>
            <div class="notes-area">@{{sale?.notes ?? ''}}</div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="{{asset('/assets/js/jquery.min.js')}}"></script>

  <script>
    var app = new Vue({
      el: '#in_pos',
      
          data: {
        payments: @json($payments),
        details: @json($details),
        pos_settings: @json($pos_settings),
        sale: @json($sale),
        setting: @json($setting),
        previous_balance: @json($previous_balance ?? 0),
        measurements: @json($measurements),
      },
      
      mounted() {
        if (this.pos_settings?.is_printable) {
          this.print_pos();
        }
      },
      
      methods: {
        isPaid() {
          const paidAmount = this.sale?.paid_amount ?? '0';
          return parseFloat(paidAmount.toString().replace(/[^\d.-]/g, '')) > 0;
        },
        
        isPaidLessThanTotal() {
          const paidAmount = this.sale?.paid_amount ?? '0';
          const grandTotal = this.sale?.GrandTotal ?? '0';
          return parseFloat(paidAmount.toString().replace(/[^\d.-]/g, '')) < parseFloat(grandTotal.toString().replace(/[^\d.-]/g, ''));
        },
        
        formatNumber(number, dec) {
          const value = (typeof number === "string" ? number : (number ?? 0).toString()).split(".");
          if (dec <= 0) return value[0];
          let formated = value[1] || "";
          if (formated.length > dec)
            return `${value[0]}.${formated.substr(0, dec)}`;
          while (formated.length < dec) formated += "0";
          return `${value[0]}.${formated}`;
        },
        
        print_pos() {
          var styles = '';
          for (var i = 0; i < document.styleSheets.length; i++) {
            var sheet = document.styleSheets[i];
            try {
              var rules = sheet.cssRules || sheet.rules;
              if (rules) {
                for (var j = 0; j < rules.length; j++) {
                  styles += rules[j].cssText + '\n';
                }
              }
            } catch (e) {
              console.log("Could not access stylesheet", e);
            }
          }
          
          var divContents = document.getElementById("invoice-POS").outerHTML;
          
          var printWindow = window.open('', '', 'height=800,width=1200');
          printWindow.document.write('<html><head><title>Print Fashion Order</title>');
          printWindow.document.write('<style type="text/css">');
          printWindow.document.write(styles);
          printWindow.document.write(`
            @media print {
              @page {
                size: A4 landscape;
                margin: 0;
              }
              body {
                margin: 0;
                padding: 0;
              }
              #invoice-POS {
                width: 100%;
                margin: 0;
                padding: 5mm;
                background: #FFF;
              }
              #invoice-POS::before {
                opacity: 0.05;
              }
              .invoice-container {
                flex-direction: row;
              }
              .left-section, .right-section {
                width: 60% 40%;
                flex: 0 0 60% 40%;
              }
            }
          `);
          printWindow.document.write('</style></head><body>');
          printWindow.document.write(divContents);
          printWindow.document.write('</body></html>');
          printWindow.document.close();
          
          setTimeout(function() {
            printWindow.focus();
            printWindow.print();
            printWindow.close();
          }, 1000);
        }
      },
      
      computed: {
        remaining_balance() {
          const previousBalanceValue = parseFloat((this.previous_balance ?? 0).toString().replace(/[^\d.-]/g, '')) || 0;
          const currentDue = parseFloat((this.sale?.due ?? 0).toString().replace(/[^\d.-]/g, '')) || 0;
          const currencySymbol = (this.previous_balance ?? '').toString().replace(/[\d., ]/g, '');
          const totalRemaining = previousBalanceValue + currentDue;
          return currencySymbol + this.formatNumber(totalRemaining, 2);
        }
      },
    });
  </script>
</body>
</html>