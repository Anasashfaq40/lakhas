<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\ProductLedgerController;
use App\Http\Controllers\ProviderLedgerController;
use App\Http\Controllers\AccountLedgerController;
use App\Http\Controllers\ProductsController;
use App\Http\Controllers\ClientController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\WishlistController;
use App\Http\Controllers\CheckoutController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\CategoriesController;
use App\Http\Controllers\ReviewController;
use App\Http\Controllers\NewsletterController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Auth\LoginController;
use Illuminate\Foundation\Auth\EmailVerificationRequest;
use Illuminate\Http\Request;


Route::get('/home', function(){
    $products = Product::withAvg('reviews', 'rating')->latest()->paginate(9);
       $categories = Category::latest()->get();

 
     
    return view('frontend.home', compact('products','categories'));

});


Route::post('login', [LoginController::class, 'authenticate'])->name('login');

Route::get('/shop', function(){
    
     
    return view('frontend.shop');

});
Route::get('/contact', function(){
    
     
    return view('frontend.contact');

});
Route::get('/blog', function(){
    
     
    return view('frontend.blog');

});
Route::get('/register', function(){
    
     
    return view('frontend.signup');

});
Route::get('/shop-no-sidebar', function(){
    
     
    return view('frontend.shop-no-sidebar');

});
Route::get('/home', [ProductsController::class,'showProducts']);
Route::get('/shop-details/{id}', [ProductsController::class, 'showdetails'])->name('shop.details');
Route::post('/cart/add', [CartController::class, 'add'])->name('cart.add');
Route::post('/wishlist/add', [WishlistController::class, 'add'])->name('wishlist.add');
Route::get('/wishlist', [WishlistController::class, 'index'])->name('wishlist');
Route::delete('/wishlist/{wishlist}', [WishlistController::class, 'destroy'])
    ->name('wishlist.destroy');
    Route::post('/review/store', [ReviewController::class, 'store'])->name('review.store');

// Route::get('/cart', [CartController::class, 'index'])->name('cart');
// Route::post('/cart/increase', [CartController::class, 'increaseQuantity'])->name('cart.increase');
// Route::post('/cart/decrease', [CartController::class, 'decreaseQuantity'])->name('cart.decrease');


// Route::delete('/cart/remove', [CartController::class, 'removeItem'])->name('cart.remove');
Route::get('/cart', [CartController::class, 'index'])->name('cart');
Route::post('/cart/increase', [CartController::class, 'increaseQuantity'])->name('cart.increase');
Route::post('/cart/decrease', [CartController::class, 'decreaseQuantity'])->name('cart.decrease');
Route::delete('/cart/remove', [CartController::class, 'removeItem'])->name('cart.remove');
Route::get('/checkout', [CheckoutController::class, 'getdata'])->name('checkout.store');
Route::post('/checkout', [CheckoutController::class, 'store'])->name('checkout.placeorder');
Route::get('/thankyou', function () {
    return view('frontend.thankyou');
})->name('thankyou');
Route::get('/shop', [ShopController::class, 'index'])->name('shop');
Route::get('/category', [CategoriesController::class, 'showCategoryProducts'])->name('category');

Route::get('/track-order/{id}', [OrderController::class, 'track'])->name('order.track');
Route::post('/subscribe-newsletter', [NewsletterController::class, 'store'])->name('newsletter.subscribe');
Route::post('/signup', [UserController::class, 'newUser'])->name('signup.store');
Route::get('/stitched-garments', [ProductsController::class, 'stitched_garment'])->name('shop.stitched');
Route::get('/unstitched-garments', [ProductsController::class, 'unstitched_garment'])->name('shop.unstitched');








Route::get('/email/verify', function () {
    return view('auth.verify');
})->middleware('auth')->name('verification.notice');

Route::get('/email/verify/{id}/{hash}', function (EmailVerificationRequest $request) {
    $request->fulfill(); // Mark email as verified

    return redirect('/dashboard'); // Redirect after verification
})->middleware(['auth', 'signed'])->name('verification.verify');

Route::post('/email/verification-notification', function (Request $request) {
    $request->user()->sendEmailVerificationNotification();

    return back()->with('message', 'Verification link sent!');
})->middleware(['auth', 'throttle:6,1'])->name('verification.send');



Route::post('/email/verification-notification', function (Request $request) {
    $request->user()->sendEmailVerificationNotification();
    return back()->with('message', 'Verification link sent!');
})->middleware(['auth', 'throttle:6,1'])->name('verification.send');
Route::get('/login2', function(){
    return view('frontend.login');
});
Route::get('/shop-details', function(){
    return view('frontend.shop-details');
});
Route::get('/about', function(){
    return view('frontend.about');
});
// Route::get('/admin/cartss', function(){
//     return view('orders.carts');
// });

Route::get('/fix-laravel', function () {
    Artisan::call('config:clear');
    Artisan::call('view:clear');
    Artisan::call('cache:clear');
    return 'Laravel cache cleared.';
});



Route::get('/fix-storage', function () {
    if (function_exists('symlink')) {
        symlink(storage_path('app/public'), public_path('storage'));
        echo 'Symlink created successfully!';
    } else {
        echo 'symlink() is disabled on this server. Upload manually or use public folder.';
    }
});


$installed = Storage::disk('public')->exists('installed');
$installed=true;
if ($installed === true) {

    Auth::routes(['register' => false]);
    // Auth::routes();
    
    


    Route::middleware(['XSS'])->group(function () {

        Route::get('/', "HomeController@RedirectToLogin");
        Route::get('switch/language/{lang}', 'LocalController@languageSwitch')->name('language.switch');

        //------------------------------- dashboard Admin--------------------------\\
      Route::group(['middleware' => ['auth', 'Is_Admin', 'Is_Active']], function () {
            Route::get('dashboard/admin', "DashboardController@dashboard_admin")->name('dashboard');
            Route::resource('products/sub_categories', SubCategoriesController::class);
            Route::post('/products/toggle-visibility', [ProductsController::class, 'toggleVisibility'])->name('products.toggle.visibility');



          Route::get('/admin/carts', [CartController::class, 'adminIndex'])->name('admin.carts.index');
    Route::delete('/admin/carts/{cart}', [CartController::class, 'destroy'])->name('admin.carts.destroy');
      Route::delete('/admin/orders/{order}', [OrderController::class, 'destroy'])->name('admin.carts.destroy');


       Route::get('/orders', [OrderController::class, 'index'])->name('orders.index');
    Route::get('/orders/{order}', [OrderController::class, 'show'])->name('orders.show');
    Route::delete('/orders/{order}', [OrderController::class, 'destroy'])->name('orders.destroy');
    Route::put('/admin/orders/{id}/update-status/{status}', [CheckoutController::class, 'updateStatus'])->name('admin.orders.updateStatus');
    Route::get('/reviews', [ReviewController::class, 'index'])->name('reviews.index');
    Route::delete('/reviews/{review}', [ReviewController::class, 'destroy'])->name('reviews.destroy');
            //------------------------------------------------------------------\\

            Route::get('/update_database', 'UpdateController@viewStep1');

            Route::get('/update_database/finish', function () {

                return view('update.finishedUpdate');
            });

            Route::post('/update_database/lastStep', [
                'as' => 'update_lastStep', 'uses' => 'UpdateController@lastStep',
            ]);
            
        });

        Route::middleware(['auth', 'Is_Active'])->group(function () {
         
            Route::get('dashboard/employee', "DashboardController@dashboard_employee")->name('dashboard_employee');

            // Route::prefix('inventory')->group(function() {


                Route::get('dashboard_filter/{start_date}/{end_date}', "DashboardController@dashboard_filter");

                //-------------------------------  Reports ------------------------\\
                Route::prefix('reports')->group(function() {
                    
                    Route::get('report_profit', 'ReportController@report_profit')->name('report_profit');
                    Route::get('report_profit/{start_date}/{end_date}/{warehouse}', 'ReportController@report_profit_filter')->name('report_profit_filter');

                    Route::get('report_stock', 'ReportController@report_stock_page')->name('report_stock');
                    Route::post('get_report_stock_datatable', 'ReportController@get_report_stock_datatable')->name('get_report_stock_datatable');

                    Route::get('report_product', 'ReportController@report_product')->name('report_product');
                    Route::post('get_report_product_datatable', 'ReportController@get_report_product_datatable')->name('get_report_product_datatable');

                    Route::get('report_clients', 'ReportController@report_clients')->name('report_clients');
                    Route::post('get_report_clients_datatable', 'ReportController@get_report_clients_datatable')->name('get_report_clients_datatable');

                    Route::get('report_providers', 'ReportController@report_providers')->name('report_providers');
                    Route::post('get_report_providers_datatable', 'ReportController@get_report_providers_datatable')->name('get_report_providers_datatable');
                    
                    Route::get('sale_report', 'ReportController@sale_report')->name('sale_report');
                    Route::post('get_report_sales_datatable', 'ReportController@get_report_sales_datatable')->name('get_report_sales_datatable');
                    Route::get('report_monthly_sale', 'ReportController@report_monthly_sale')->name('report_monthly_sale');

                    Route::get('purchase_report', 'ReportController@purchase_report')->name('purchase_report');
                    Route::post('get_report_Purchases_datatable', 'ReportController@get_report_Purchases_datatable')->name('get_report_Purchases_datatable');
                    Route::get('report_monthly_purchase', 'ReportController@report_monthly_purchase')->name('report_monthly_purchase');

                    Route::get('payment_sale', 'ReportController@payment_sale_report')->name('payment_sale');
                    Route::post('get_payment_sale_reports_datatable', 'ReportController@get_payment_sale_reports_datatable')->name('get_payment_sale_reports_datatable');


                    Route::get('payment_purchase', 'ReportController@payment_purchase_report')->name('payment_purchase');
                    Route::post('get_payment_purchase_report_datatable', 'ReportController@get_payment_purchase_report_datatable')->name('get_payment_purchase_report_datatable');


                    Route::get('payment_sale_return', 'ReportController@payment_sale_return_report')->name('payment_sale_return_report');

                    Route::get('payment_purchase_return', 'ReportController@payment_purchase_return_report')->name('payment_purchase_return_report');
                    
                    Route::get('reports_quantity_alerts', 'ReportController@reports_quantity_alerts')->name('reports_quantity_alerts');
                });
                
                //------------------------------- products--------------------------\\
                Route::prefix('products')->group(function() {
                    Route::resource('products', 'ProductsController');
                    Route::post('get_product_datatable', 'ProductsController@get_product_datatable')->name('products_datatable');
                    Route::get('show_product_data/{id}/{variant_id}', 'ProductsController@show_product_data');

                    Route::get('products_by_Warehouse/{id}', 'ProductsController@Products_by_Warehouse');
                    Route::get('print_labels', 'ProductsController@print_labels')->name('print_labels');
                    Route::get('import_products', 'ProductsController@import_products_page');
                    Route::post('import_products', 'ProductsController@import_products');
                    Route::get('{productId}/ledger', [ProductLedgerController::class, 'index'])->name('product.ledger.index');
                    Route::get('{productId}/ledger/download', [ProductLedgerController::class, 'downloadExcel'])->name('product.ledger.download');
                    Route::get('products/view/{id}', 'ProductsController@showdetail')->name('products.view');


                    //------------------------------- categories--------------------------\\
                    Route::resource('categories', 'CategoriesController');
                    Route::get('/categories/parents', 'CategoriesController@parentCategories')->name('categories.parents');
            
                    //------------------------------- brands--------------------------\\
                    Route::resource('brands', 'BrandsController');

                    //------------------------------- units--------------------------\\
                    Route::resource('units', 'UnitsController');
                    Route::get('Get_Units_SubBase', 'UnitsController@Get_Units_SubBase');
                    Route::get('Get_sales_units', 'UnitsController@Get_sales_units');
            
                    //------------------------------- warehouses--------------------------\\
                    Route::resource('warehouses', 'WarehousesController');
                });

                //------------------------------- adjustments--------------------------\\
                Route::resource('adjustment/adjustments', 'AdjustmentsController');
    
        
                //------------------------------- quotations --------------------------\\
                Route::prefix('quotation')->group(function() {
                    Route::resource('quotations', 'QuotationsController');
                    Route::post('get_quotations_datatable', 'QuotationsController@get_quotations_datatable')->name('get_quotations_datatable');
                });
                
                Route::post('quotations/sendQuote/email', 'QuotationsController@SendEmail');
                Route::get('quotations/generate_sale/{id}', 'QuotationsController@generate_sale');
        
                //------------------------------- purchases --------------------------\\
                Route::prefix('purchase')->group(function() {
                    Route::resource('purchases', 'PurchasesController');
                    Route::post('get_purchases_datatable', 'PurchasesController@get_purchases_datatable')->name('get_purchases_datatable');

                    Route::get('purchases/payments/{id}', 'PurchasesController@Get_Payments');
                    Route::post('purchases/send/email', 'PurchasesController@Send_Email');
                    Route::get('get_Products_by_purchase/{id}', 'PurchasesController@get_Products_by_purchase');
                });
        
                //------------------------------- Sales --------------------------\\
                Route::prefix('sale')->group(function() {
                    Route::resource('sales', 'SalesController');
                    Route::post('get_sales_datatable', 'SalesController@get_sales_datatable')->name('sales_datatable');

                    Route::post('sales/send/email', 'SalesController@Send_Email');
                    Route::get('sales/payments/{id}', 'SalesController@Payments_Sale');
                    Route::get('get_Products_by_sale/{id}', 'SalesController@get_Products_by_sale');
                    Route::get('/products/products_by_Warehouse/{id}', 'ProductsController@products_by_Warehouse')
    ->name('products.by.warehouse');
                });

                //---------------------- POS (point of sales) ----------------------\\
                //------------------------------------------------------------------\\
                Route::get('pos', 'PosController@index');
                Route::post('pos/create_pos', 'PosController@CreatePOS');
                Route::get('pos/get_products_pos', 'PosController@GetProductsByParametre');
                Route::get('pos/data_create_pos', 'PosController@GetELementPos');
                Route::get('pos/autocomplete_product_pos/{id}', 'PosController@autocomplete_product_pos');
                Route::get('invoice_pos/{id}', 'PosController@Print_Invoice_POS');

                //------------------------------- transfers --------------------------\\
                Route::resource('transfer/transfers', 'TransfersController');
        
                //------------------------------- Sales Return --------------------------\\
                Route::prefix('sales-return')->group(function() {
                    Route::resource('returns_sale', 'SalesReturnController');
                    Route::get('returns/sale/payment/{id}', 'SalesReturnController@Payment_Returns');

                    Route::get('add_returns_sale/{id}', 'SalesReturnController@create_sell_return')->name('create_sell_return');
                    Route::get('edit_returns_sale/{id}/{sale_id}', 'SalesReturnController@edit_sell_return')->name('edit_sell_return');
                });
        
                //------------------------------- Purchases Return --------------------------\\
                Route::prefix('purchase-return')->group(function() {
                    Route::resource('returns_purchase', 'PurchasesReturnController');
                    Route::post('returns/purchase/send/email', 'PurchasesReturnController@Send_Email');
                    Route::get('returns/purchase/payment/{id}', 'PurchasesReturnController@Payment_Returns');

                    Route::get('add_returns_purchase/{id}', 'PurchasesReturnController@create_purchase_return')->name('create_purchase_return');
                    Route::get('edit_returns_purchase/{id}/{purchase_id}', 'PurchasesReturnController@edit_purchase_return')->name('edit_purchase_return');
                });
                
                //------------------------------- payment purchase --------------------------\\
        
                Route::resource('payment/purchase', 'PaymentPurchasesController');
                Route::get('payment/purchase/get_data_create/{id}', 'PaymentPurchasesController@get_data_create');
                Route::post('payment/purchase/send/email', 'PaymentPurchasesController@SendEmail');
        
                //------------------------------- payment sale --------------------------\\
        
                Route::resource('payment/sale', 'PaymentSalesController');
                Route::get('payment/sale/get_data_create/{id}', 'PaymentSalesController@get_data_create');
                Route::post('payment/sale/send/email', 'PaymentSalesController@SendEmail');
        
                //------------------------------- Payment Sale Returns --------------------------\\
        
                Route::resource('payment_returns_sale', 'PaymentSaleReturnsController');
                Route::get('payment/returns_sale/get_data_create/{id}', 'PaymentSaleReturnsController@get_data_create');
                Route::post('payment/returns_sale/send/email', 'PaymentSaleReturnsController@SendEmail');

                //------------------------------- Payments Purchase Returns --------------------------\\
        
                Route::resource('payment_returns_purchase', 'PaymentPurchaseReturnsController');
                Route::get('payment/returns_purchase/get_data_create/{id}', 'PaymentPurchaseReturnsController@get_data_create');
                Route::post('payment/returns_purchase/send/email', 'PaymentPurchaseReturnsController@SendEmail');

                //------------------------------- suppliers --------------------------\\
        
                 Route::resource('people/suppliers', 'SuppliersController');
                 Route::post('get_suppliers_datatable', 'SuppliersController@get_suppliers_datatable')->name('get_suppliers_datatable');

                 Route::post("suppliers/delete/by_selection", "SuppliersController@delete_by_selection");
                 Route::get('get_provider_debt_total/{id}', 'SuppliersController@get_provider_debt_total');
                 Route::post('providers_pay_due', 'SuppliersController@providers_pay_due');
Route::get('providers/{id}/ledger/export', [ProviderLedgerController::class, 'export'])->name('provider.ledger.export');
Route::get('providers/{id}/ledger', [ProviderLedgerController::class, 'index'])->name('provider.ledger.index'); // optional

                 Route::get('get_provider_debt_return_total/{id}', 'SuppliersController@get_provider_debt_return_total');
                 Route::post('providers_pay_return_due', 'SuppliersController@providers_pay_return_due');

                 //------------------------------- clients --------------------------\\
        
                 Route::resource('people/clients', 'ClientController');
                 Route::get('/get_client_due/{id}', 'ClientController@getClientDue');
                 Route::get('/clients/{id}/ledger/export', [App\Http\Controllers\ClientLedgerController::class, 'export'])
    ->name('clients.ledger.export');

                 Route::post('get_clients_datatable', 'ClientController@get_clients_datatable')->name('clients_datatable');

                 Route::get('get_client_plafond/{id}', 'ClientController@get_client_plafond');
                 Route::get('get_client_debt_total/{id}', 'ClientController@get_client_debt_total');
                 Route::get('get_client_debt_return_total/{id}', 'ClientController@get_client_debt_return_total');

                 Route::post('clients_pay_due', 'ClientController@clients_pay_due');
                 Route::post('clients_pay_return_due', 'ClientController@clients_pay_return_due');

                 Route::get('import_clients', 'ClientController@import_clients_page')->name('import_clients');
                 Route::post('import_clients', 'ClientController@import_clients');
                Route::get('clients/sales/{id}', [ClientController::class, 'clientdetailshow'])->name('clients.sales.details');


                 //------------------------------- users & permissions --------------------------\\
              Route::middleware(['web', 'auth'])->prefix('user-management')->group(function() {
    Route::resource('users', 'UserController');
    Route::post('assignRole', 'UserController@assignRole');
    Route::resource('permissions', 'PermissionsController');
});

                //-------------------------------  --------------------------\\
        
                //------------------------------- Profile --------------------------\\
                //----------------------------------------------------------------\\
                Route::put('updateProfile/{id}', 'ProfileController@updateProfile');
                Route::resource('profile', 'ProfileController');

                //-------------------------------  Print & PDF ------------------------\\
        
                Route::get('Sale_PDF/{id}', 'SalesController@Sale_PDF');
                Route::get('Quote_PDF/{id}', 'QuotationsController@Quotation_pdf');
                Route::get('Purchase_PDF/{id}', 'PurchasesController@Purchase_pdf');
                Route::get('Payment_Purchase_PDF/{id}', 'PaymentPurchasesController@Payment_purchase_pdf');
                Route::get('payment_Sale_PDF/{id}', 'PaymentSalesController@payment_sale');
                Route::get('return_sale_pdf/{id}', 'SalesReturnController@Return_pdf');
                Route::get('return_purchase_pdf/{id}', 'PurchasesReturnController@Return_pdf');
                Route::get('payment_return_sale_pdf/{id}', 'PaymentSaleReturnsController@payment_return');
                Route::get('payment_return_purchase_pdf/{id}', 'PaymentPurchaseReturnsController@payment_return');

                //------------------------------- SEND SMS --------------------------\\
                Route::post('sales_send_sms', 'SalesController@Send_SMS');
                Route::post('purchase_send_sms', 'PurchasesController@Send_SMS');
                Route::post('quotation_send_sms', 'QuotationsController@Send_SMS');
                Route::post('purchase_payment_send_sms', 'PaymentPurchasesController@Send_SMS');
                Route::post('sell_payment_send_sms', 'PaymentSalesController@Send_SMS');
                Route::post('sell_return_payment_send_sms', 'PaymentSaleReturnsController@Send_SMS');

                //------------------------------- Settings --------------------------\\
                //----------------------------------------------------------------\\

                Route::prefix('settings')->group(function () {
                    Route::resource('system_settings', 'SettingController');
                    Route::resource('currency', 'CurrencyController');
                    Route::resource('backup', 'BackupController');
                    Route::resource('email_settings', 'EmailSettingController');
                    Route::get('pos_settings', 'SettingController@get_pos_Settings');
                    Route::put('pos_settings/{id}', 'SettingController@update_pos_settings');

                     //------------------------------- SMS Settings ------------------------\\

    
                     Route::get('sms_settings', 'Sms_SettingsController@get_sms_config');
                     Route::put('update_Default_SMS', 'Sms_SettingsController@update_Default_SMS');
                     Route::post('update_twilio_config', 'Sms_SettingsController@update_twilio_config');
                     Route::post('update_nexmo_config', 'Sms_SettingsController@update_nexmo_config');
                     Route::post('update_infobip_config', 'Sms_SettingsController@update_infobip_config');
 
                     // notifications_template
                     Route::get('sms_template', 'Notifications_Template@get_sms_template');
                     Route::put('update_sms_body', 'Notifications_Template@update_sms_body');

                     Route::get('emails_template', 'Notifications_Template@get_emails_template');
                     Route::put('update_custom_email', 'Notifications_Template@update_custom_email');
                     
                    // update_backup_settings
                     Route::post('update_backup_settings', 'SettingController@update_backup_settings');

                });

                Route::get('GenerateBackup', 'BackupController@GenerateBackup');
                
                //------------------------------- clear_cache --------------------------\\

                Route::get("clear_cache", "SettingController@Clear_Cache");
                


            //------------------------------- Accounting -----------------------\\
            //----------------------------------------------------------------\\
            Route::prefix('accounting')->group(function () {
                Route::resource('account', 'AccountController');
                Route::resource('deposit', 'DepositController');
                Route::resource('expense', 'ExpenseController');
                Route::resource('expense_category', 'ExpenseCategoryController');
                Route::resource('deposit_category', 'DepositCategoryController');
                Route::resource('payment_methods', 'PaymentMethodController');

                Route::post("account/delete/by_selection", "AccountController@delete_by_selection");
                Route::post("deposit/delete/by_selection", "DepositController@delete_by_selection");
                Route::post("expense/delete/by_selection", "ExpenseController@delete_by_selection");
                Route::post("expense_category/delete/by_selection", "ExpenseCategoryController@delete_by_selection");
                Route::post("deposit_category/delete/by_selection", "DepositCategoryController@delete_by_selection");
                Route::post("payment_methods/delete/by_selection", "PaymentMethodController@delete_by_selection");
                // Add this with your other product routes
Route::get('/products/export', [ProductsController::class, 'export'])->name('products.export');
            });

        });


          //------------------------------- url_invoice_sms--------------------------\\
          Route::get('sell_url/{id}', 'SalesController@Sale_PDF');
          Route::get('purchase_url/{id}', 'PurchasesController@Purchase_pdf');
          Route::get('quotation_url/{id}', 'QuotationsController@Quote_PDF');
   

    });

        } else {

            Route::get('/{vue?}',
            function () {
                    return redirect('/setup');
            })->where('vue', '^(?!setup).*$');
    
            
            Route::get('/setup', [
                'uses' => 'SetupController@viewCheck',
            ])->name('setup');

            Route::get('/setup/step-1', [
                'uses' => 'SetupController@viewStep1',
            ]);

            Route::post('/setup/step-2', [
                'as' => 'setupStep1', 'uses' => 'SetupController@setupStep1',
            ]);

            Route::post('/setup/testDB', [
                'as' => 'testDB', 'uses' => 'TestDbController@testDB',
            ]);

            Route::get('/setup/step-2', [
                'uses' => 'SetupController@viewStep2',
            ]);

            Route::get('/setup/step-3', [
                'uses' => 'SetupController@viewStep3',
            ]);

            Route::get('/setup/finish', function () {

                return view('setup.finishedSetup');
            });

            Route::get('/setup/getNewAppKey', [
                'as' => 'getNewAppKey', 'uses' => 'SetupController@getNewAppKey',
            ]);

            Route::get('/setup/getPassport', [
                'as' => 'getPassport', 'uses' => 'SetupController@getPassport',
            ]);

            Route::get('/setup/getMegrate', [
                'as' => 'getMegrate', 'uses' => 'SetupController@getMegrate',
            ]);

            Route::post('/setup/step-3', [
                'as' => 'setupStep2', 'uses' => 'SetupController@setupStep2',
            ]);

            Route::post('/setup/step-4', [
                'as' => 'setupStep3', 'uses' => 'SetupController@setupStep3',
            ]);

            Route::post('/setup/step-5', [
                'as' => 'setupStep4', 'uses' => 'SetupController@setupStep4',
            ]);

            Route::post('/setup/lastStep', [
                'as' => 'lastStep', 'uses' => 'SetupController@lastStep',
            ]);

            Route::get('setup/lastStep', function () {
                return redirect('/setup', 301);
            });
            
            

    } 
    
Route::get('account-ledger/export/{id}', [AccountLedgerController::class, 'export'])->name('account-ledger.export');

Route::get('/fix-maintance' , function(){
    
    Artisan::call('down');
    return 'Website is down temporily ';
});

Route::get('/fix-maintance-up', function () {
    Artisan::call('up');
    return 'Website is now live again!';
});


