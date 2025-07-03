<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateProductsTable extends Migration
{
    public function up()
    {
        Schema::create('products', function (Blueprint $table) {
            $table->integer('id', true);
            $table->string('type', 192);
            $table->string('garment_type', 50)->nullable()->comment('shirt_suit, pant_shalwar');
            $table->string('code', 192);
            $table->string('Type_barcode', 192);
            $table->string('name', 192);
            $table->float('cost', 10, 0);
            $table->float('price', 10, 0);
            $table->integer('category_id')->index('category_id');
            $table->integer('brand_id')->nullable()->index('brand_id_products');
            $table->integer('unit_id')->nullable()->index('unit_id_products');
            $table->integer('unit_sale_id')->nullable()->index('unit_id_sales');
            $table->integer('unit_purchase_id')->nullable()->index('unit_purchase_products');
            $table->float('TaxNet', 10, 0)->nullable()->default(0);
            $table->string('tax_method', 192)->nullable()->default('1');
            $table->text('image')->nullable();
            $table->text('note')->nullable();
            $table->float('stock_alert', 10, 0)->nullable()->default(0);
            $table->float('qty_min', 10, 0)->nullable()->default(0);
            $table->boolean('is_promo')->default(0);
            $table->float('promo_price', 10, 0)->default(0);
            $table->date('promo_start_date')->nullable();
            $table->date('promo_end_date')->nullable();
            $table->boolean('is_variant')->default(0);
            $table->boolean('is_imei')->default(0);
            $table->boolean('not_selling')->default(0);
            $table->boolean('is_active')->nullable()->default(1);
            // $table->boolean('is_visible')->default(1); 
            
            // Shirt/Suit measurements
            $table->string('shirt_length', 50)->nullable();
            $table->string('shirt_shoulder', 50)->nullable();
            $table->string('shirt_sleeves', 50)->nullable();
            $table->string('shirt_chest', 50)->nullable();
            $table->string('shirt_upper_waist', 50)->nullable();
            $table->string('shirt_lower_waist', 50)->nullable();
            $table->string('shirt_hip', 50)->nullable();
            $table->string('shirt_neck', 50)->nullable();
            $table->string('shirt_arms', 50)->nullable();
            $table->string('shirt_cuff', 50)->nullable();
            $table->string('shirt_biceps', 50)->nullable();
            
            // Pant/Shalwar measurements
            $table->string('pant_length', 50)->nullable();
            $table->string('pant_waist', 50)->nullable();
            $table->string('pant_hip', 50)->nullable();
            $table->string('pant_thai', 50)->nullable();
            $table->string('pant_knee', 50)->nullable();
            $table->string('pant_bottom', 50)->nullable();
            $table->string('pant_fly', 50)->nullable();
            
            // Collar types
            $table->boolean('collar_shirt')->default(false);
            $table->boolean('collar_sherwani')->default(false);
            $table->boolean('collar_damian')->default(false);
            $table->boolean('collar_round')->default(false);
            $table->boolean('collar_square')->default(false);
            
            // Unstitched Garment Properties
            $table->decimal('thaan_length', 10, 2)->nullable()->default(22.5);
            $table->decimal('suit_length', 10, 2)->nullable()->default(4.5);
            $table->json('available_sizes')->nullable()->comment('Available sizes for unstitched garments');
            
            $table->timestamps(6);
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::drop('products');
    }
}
