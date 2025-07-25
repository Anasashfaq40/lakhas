<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOrdersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('orders', function (Blueprint $table) {
        $table->id();
        $table->string('first_name');
        $table->string('last_name');
        $table->string('company_name')->nullable();
        $table->string('country');
        $table->string('address1');
        $table->string('address2')->nullable();
        $table->string('city');
        $table->string('state');
        $table->string('zipcode');
        $table->string('phone');
        $table->string('email');
        $table->text('different_address')->nullable();
        $table->string('payment_method');
        $table->decimal('total', 10, 2);
        $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('orders');
    }
}
