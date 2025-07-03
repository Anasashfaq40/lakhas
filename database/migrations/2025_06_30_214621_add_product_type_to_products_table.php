<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddProductTypeToProductsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
       Schema::table('products', function (Blueprint $table) {
    $table->enum('product_type', ['stitched', 'unstitched'])->default('stitched');
});

    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
       Schema::table('products', function (Blueprint $table) {
    $table->enum('product_type', ['stitched', 'unstitched'])->default('stitched');
});

    }
}
