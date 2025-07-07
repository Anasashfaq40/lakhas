<?php
// $languageDirection = $_COOKIE['language'] == 'ar' ? 'rtl' : 'ltr';
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, shrink-to-fit=no" name="viewport">
  <title>The Lakhas - Order Invoice</title>
  <link rel=icon href={{ asset('images/logo.svg') }}>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

  <!-- CSS Files -->
  <!-- <link rel="stylesheet" href="{{asset('assets/styles/vendor/invoice_pos.css')}}"> -->
  <script src="{{asset('/assets/js/vue.js')}}"></script>

  <style>
    :root {
      --primary-color: #5d4bff;
      --secondary-color: #7ec8ca;
      --dark-color: #05070b;
      --light-color: #f8f9fa;
      --border-color: #e0e0e0;
      --text-color: #333333;
      --success-color: #28a745;
      --warning-color: #ffc107;
      --danger-color: #dc3545;
    }
    
    body {
      font-family: 'Poppins', sans-serif;
      margin: 0;
      padding: 0;
      font-size: 13px;
      line-height: 1.5;
      color: var(--text-color);
      background-color: #f5f7fa;
    }
    
    #invoice-POS {
      width: 100%;
      max-width: 300mm;
      margin: 20px auto;
      padding: 15px;
      background: #FFF;
      position: relative;
      overflow: visible;
      min-height: 210mm;
      box-sizing: border-box;
      box-shadow: 0 5px 15px rgba(0,0,0,0.05);
      border-radius: 8px;
      overflow: hidden;
    
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
      opacity: 0.06;
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
      gap: 10mm;
      width: 100%;
      min-height: 190mm;
      box-sizing: border-box;
    }
    
    .left-section {
      width: 60%;
      flex: 0 0 60%;
      border-right: 1px dashed var(--primary-color);
      padding-right: 10mm;
      box-sizing: border-box;
    }
    
    .right-section {
      width: 40%;
      flex: 0 0 40%;
      padding-left: 10mm;
      box-sizing: border-box;
    }
    
    .header-section {
      text-align: center;
      margin-bottom: 20px;
      border-bottom: 2px solid var(--primary-color);
      padding-bottom: 15px;
    }
    
    .company-name {
      font-size: 24px;
      font-weight: 600;
      margin-bottom: 5px;
      color: var(--primary-color);
      letter-spacing: 0.5px;
    }
    
    .company-tagline {
      font-size: 14px;
      font-weight: 400;
      margin-bottom: 8px;
      color: var(--dark-color);
      opacity: 0.8;
    }
    
    .company-details {
      font-size: 11px;
      line-height: 1.4;
      color: #666;
    }
    
    .order-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      flex-wrap: wrap;
      background-color: rgba(93, 75, 255, 0.05);
      padding: 12px;
      border-radius: 6px;
    }
    
    .order-number {
      font-size: 16px;
      font-weight: 600;
      color: var(--primary-color);
    }
    
    .order-form-label {
      background-color: var(--primary-color);
      color: white;
      padding: 5px 12px;
      font-weight: 500;
      font-size: 11px;
      border-radius: 4px;
      letter-spacing: 0.5px;
    }
    
    .customer-section {
      margin-bottom: 20px;
      background-color: var(--light-color);
      padding: 15px;
      border-radius: 6px;
      border-left: 4px solid var(--primary-color);
    }
    
    .form-row {
      display: flex;
      margin-bottom: 8px;
      align-items: center;
    }
    
    .form-label {
      font-weight: 500;
      margin-right: 10px;
      min-width: 80px;
      font-size: 11px;
      color: var(--dark-color);
    }
    
    .form-input {
      border-bottom: 1px solid var(--border-color);
      flex: 1;
      padding: 3px 5px;
      min-height: 16px;
      font-size: 11px;
      transition: border-color 0.3s;
    }
    
    .form-input:focus {
      outline: none;
      border-bottom-color: var(--primary-color);
    }
    
    .dates-section {
      display: flex;
      gap: 20px;
      margin-bottom: 20px;
      font-size: 11px;
      flex-wrap: wrap;
      background-color: var(--light-color);
      padding: 12px;
      border-radius: 6px;
    }
    
    .date-item {
      display: flex;
      align-items: center;
      gap: 5px;
      flex: 1;
      min-width: 120px;
    }
    
    .date-label {
      font-weight: 500;
      color: var(--dark-color);
    }
    
    .date-input {
      border-bottom: 1px solid var(--border-color);
      min-width: 80px;
      padding: 3px;
      font-size: 11px;
      flex: 1;
    }
    
    .items-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 20px;
      font-size: 12px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.05);
    }
    
    .items-table th,
    .items-table td {
      border: 1px solid var(--border-color);
      padding: 8px;
      text-align: center;
    }
    
    .items-table th {
      background-color: var(--primary-color);
      color: white;
      font-weight: 500;
      font-size: 11px;
      letter-spacing: 0.5px;
    }
    
    .items-table tr:nth-child(even) {
      background-color: var(--light-color);
    }
    
    .items-col {
      width: 40%;
      text-align: left !important;
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
      margin-top: 20px;
      font-size: 10px;
      line-height: 1.5;
      background-color: var(--light-color);
      padding: 15px;
      border-radius: 6px;
      border-left: 4px solid var(--secondary-color);
    }
    
    .terms-title {
      font-weight: 600;
      margin-bottom: 8px;
      color: var(--dark-color);
      font-size: 12px;
    }
    
    .right-header {
      text-align: center;
      margin-bottom: 20px;
      border-bottom: 1px solid var(--primary-color);
      padding-bottom: 12px;
    }
    
    .measurements-section {
      margin-bottom: 20px;
    }
    
    .measurement-category {
      font-weight: 600;
      margin-bottom: 12px;
      font-size: 13px;
      color: var(--primary-color);
      letter-spacing: 0.5px;
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 5px;
    }
    
    .measurement-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 8px;
      margin-bottom: 15px;
    }
    
    .measurement-item {
      display: flex;
      align-items: center;
      gap: 5px;
    }
    
    .measurement-label {
      min-width: 80px;
      font-size: 11px;
      font-weight: 500;
      color: #555;
    }
    
    .measurement-input {
      border-bottom: 1px solid var(--border-color);
      flex: 1;
      min-height: 16px;
      padding: 3px 5px;
      font-size: 11px;
    }
    
    .style-options {
      margin-bottom: 15px;
      background-color: var(--light-color);
      padding: 12px;
      border-radius: 6px;
    }
    
    .style-row {
      display: flex;
      align-items: center;
      margin-bottom: 6px;
      gap: 10px;
      font-size: 11px;
    }
    
    .style-row-title {
      font-weight: 500;
      min-width: 60px;
      color: var(--dark-color);
    }
    
    .checkbox-group {
      display: flex;
      gap: 15px;
    }
    
    .checkbox-item {
      display: flex;
      align-items: center;
      gap: 5px;
      font-size: 10px;
    }
    
    .checkbox-item input {
      accent-color: var(--primary-color);
    }
    
    .swatches-box {
      border: 1px solid var(--border-color);
      height: 80px;
      margin-bottom: 15px;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: var(--light-color);
      border-radius: 6px;
    }
    
    .swatches-label {
      font-size: 11px;
      color: #777;
      font-style: italic;
    }
    
    .notes-section {
      margin-top: 15px;
    }
    
    .notes-label {
      font-weight: 500;
      margin-bottom: 8px;
      font-size: 12px;
      color: var(--dark-color);
    }
    
    .notes-area {
      border: 1px solid var(--border-color);
      height: 60px;
      width: 100%;
      padding: 8px;
      font-size: 11px;
      box-sizing: border-box;
      border-radius: 6px;
      resize: none;
      transition: border-color 0.3s;
    }
    
    .notes-area:focus {
      outline: none;
      border-color: var(--primary-color);
    }
    
    .hidden-print {
      margin-bottom: 20px;
      text-align: center;
    }
    
    .btn {
      display: inline-block;
      padding: 10px 20px;
      background-color: var(--primary-color);
      color: white;
      text-decoration: none;
      border-radius: 6px;
      font-weight: 500;
      cursor: pointer;
      border: none;
      transition: all 0.3s ease;
      box-shadow: 0 2px 5px rgba(93, 75, 255, 0.2);
    }
    
    .btn:hover {
      background-color: #4a3acc;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(93, 75, 255, 0.3);
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
        border-bottom: 1px dashed var(--primary-color);
        padding-right: 0;
        padding-bottom: 15px;
        margin-bottom: 15px;
      }
      
      .right-section {
        padding-left: 0;
        padding-top: 15px;
      }
    }
    
    @media print {
      .hidden-print {
        display: none;
      }
      
      body {
        margin: 0;
        padding: 0;
        background: none;
      }
      
      #invoice-POS {
        width: 100%;
        margin: 0;
        padding: 5mm;
        max-width: none;
        box-shadow: none;
        border: none;
      }
      
      .invoice-container {
        flex-direction: row;
      }
      
      .left-section,
      .right-section {
        width: 60% 40%;
        flex: 0 0 60% 40%;
      }
      
      .left-section {
        border-right: 1px dashed var(--primary-color);
        border-bottom: none;
        padding-right: 10mm;
        margin-bottom: 0;
      }
      
      .right-section {
        padding-left: 10mm;
        padding-top: 0;
      }
    }
  </style>
</head>

<body>
  <div id="in_pos">
    <div class="hidden-print">
      <a @click="print_pos()" class="btn">{{ __('translate.print') }}</a>
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
              <span class="date-label">Order Date:</span>
              <div class="date-input">@{{sale?.date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span class="date-label">Trial Date:</span>
              <div class="date-input">@{{sale?.trial_date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span class="date-label">Delivery Date:</span>
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
              <span class="date-label">Order Date:</span>
              <div class="date-input">@{{sale?.date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span class="date-label">Trial Date:</span>
              <div class="date-input">@{{sale?.trial_date ?? ''}}</div>
            </div>
            <div class="date-item">
              <span class="date-label">Delivery Date:</span>
              <div class="date-input">@{{sale?.delivery_date ?? ''}}</div>
            </div>
          </div>
          
          <!-- Measurements Section -->
          <div class="measurements-section">
            <!-- Shirt/Suit Measurements -->
            <div class="measurement-category">SHIRT/SUIT MEASUREMENTS</div>
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
                <span class="style-row-title">Collar:</span>
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
                <span class="style-row-title">Daman:</span>
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
            <div class="measurement-category">PANT/SHALWAR MEASUREMENTS</div>
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
          <div class="swatches-box">
            <div class="swatches-label">Fabric Swatches Attached Here</div>
          </div>
          
          <!-- Notes Section -->
          <div class="notes-section">
            <div class="notes-label">CUSTOMER NOTES & SPECIAL INSTRUCTIONS:</div>
            <textarea class="notes-area" readonly>@{{sale?.notes ?? ''}}</textarea>
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
                background: none;
              }
              #invoice-POS {
                width: 100%;
                margin: 0;
                padding: 5mm;
                background: #FFF;
                box-shadow: none;
                border: none;
              }
              #invoice-POS::before {
                opacity: 0.06;
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