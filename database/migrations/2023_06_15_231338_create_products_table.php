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
            $table->string('type', 192)->default('is_single')->comment('is_single, is_service, is_variant, stitched_garment, unstitched_garment');
            $table->string('garment_type', 50)->nullable()->comment('shalwar_suit, pant_shirt');
            $table->string('code', 192);
            $table->string('Type_barcode', 192);
            $table->string('name', 192);
            $table->decimal('cost', 10, 2);
            $table->decimal('price', 10, 2);
            $table->integer('category_id')->index('category_id');
            $table->unsignedBigInteger('sub_category_id')->nullable();
            $table->integer('brand_id')->nullable()->index('brand_id_products');
            $table->integer('unit_id')->nullable()->index('unit_id_products');
            $table->integer('unit_sale_id')->nullable()->index('unit_id_sales');
            $table->integer('unit_purchase_id')->nullable()->index('unit_purchase_products');
            $table->decimal('TaxNet', 10, 2)->nullable()->default(0);
            $table->string('tax_method', 192)->nullable()->default('1');
            $table->text('image')->nullable();
            $table->text('note')->nullable();
            $table->decimal('stock_alert', 10, 2)->nullable()->default(0);
            $table->decimal('qty_min', 10, 2)->nullable()->default(0);
            $table->boolean('is_promo')->default(false);
            $table->decimal('promo_price', 10, 2)->default(0);
            $table->date('promo_start_date')->nullable();
            $table->date('promo_end_date')->nullable();
            $table->boolean('is_variant')->default(false);
            $table->boolean('is_imei')->default(false);
            $table->boolean('not_selling')->default(false);
            $table->boolean('is_active')->default(true);
            
            // Shalwar/Suit measurements
            $table->decimal('kameez_length', 10, 2)->nullable();
            $table->decimal('kameez_shoulder', 10, 2)->nullable();
            $table->decimal('kameez_sleeves', 10, 2)->nullable();
            $table->decimal('kameez_chest', 10, 2)->nullable();
            $table->decimal('kameez_upper_waist', 10, 2)->nullable();
            $table->decimal('kameez_lower_waist', 10, 2)->nullable();
            $table->decimal('kameez_hip', 10, 2)->nullable();
            $table->decimal('kameez_neck', 10, 2)->nullable();
            $table->decimal('kameez_arms', 10, 2)->nullable();
            $table->decimal('kameez_cuff', 10, 2)->nullable();
            $table->decimal('kameez_biceps', 10, 2)->nullable();
            
            // Shalwar measurements
            $table->decimal('shalwar_length', 10, 2)->nullable();
            $table->decimal('shalwar_waist', 10, 2)->nullable();
            $table->decimal('shalwar_bottom', 10, 2)->nullable();
            
            // Collar types (Shalwar/Suit)
            $table->boolean('collar_shirt')->default(false);
            $table->boolean('collar_sherwani')->default(false);
            $table->boolean('collar_damian')->default(false);
            $table->boolean('collar_round')->default(false);
            $table->boolean('collar_square')->default(false);
            
            // Pant/Shirt measurements
            $table->decimal('pshirt_length', 10, 2)->nullable();
            $table->decimal('pshirt_shoulder', 10, 2)->nullable();
            $table->decimal('pshirt_sleeves', 10, 2)->nullable();
            $table->decimal('pshirt_chest', 10, 2)->nullable();
            $table->decimal('pshirt_neck', 10, 2)->nullable();
            
            // Collar types (Pant/Shirt)
            $table->boolean('pshirt_collar_shirt')->default(false);
            $table->boolean('pshirt_collar_round')->default(false);
            $table->boolean('pshirt_collar_square')->default(false);
            
            // Pant measurements
            $table->decimal('pant_length', 10, 2)->nullable();
            $table->decimal('pant_waist', 10, 2)->nullable();
            $table->decimal('pant_hip', 10, 2)->nullable();
            $table->decimal('pant_thai', 10, 2)->nullable();
            $table->decimal('pant_knee', 10, 2)->nullable();
            $table->decimal('pant_bottom', 10, 2)->nullable();
            $table->decimal('pant_fly', 10, 2)->nullable();
            
            // Unstitched Garment Properties
            $table->decimal('thaan_length', 10, 2)->nullable()->default(22.5);
            $table->decimal('suit_length', 10, 2)->nullable()->default(4.5);
            $table->json('available_sizes')->nullable()->comment('Available sizes (S, M, L, XL)');
            
            $table->timestamps(6);
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::dropIfExists('products');
    }
}