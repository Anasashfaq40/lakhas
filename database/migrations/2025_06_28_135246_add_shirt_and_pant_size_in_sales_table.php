<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddShirtAndPantSizeInSalesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        //schema for adding shirt and pant measurements to the sales table added by kashan
    Schema::table('sales', function (Blueprint $table) {
            // Shirt/Suit measurements
            $table->string('shirt_length')->nullable();
            $table->string('shirt_shoulder')->nullable();
            $table->string('shirt_sleeves')->nullable();
            $table->string('shirt_chest')->nullable();
            $table->string('shirt_upper_waist')->nullable();
            $table->string('shirt_lower_waist')->nullable();
            $table->string('shirt_hip')->nullable();
            $table->string('shirt_neck')->nullable();
            $table->string('shirt_arms')->nullable();
            $table->string('shirt_cuff')->nullable();
            $table->string('shirt_biceps')->nullable();
            

            $table->enum('shirt_collar_type', ['Shirt', 'Sherwani'])->nullable();
            $table->enum('shirt_daman_type', ['Round', 'Square'])->nullable();
            
            // Pant/Shawar measurements
            $table->string('pant_length')->nullable();
            $table->string('pant_waist')->nullable();
            $table->string('pant_hip')->nullable();
            $table->string('pant_thigh')->nullable();
            $table->string('pant_knee')->nullable();
            $table->string('pant_bottom')->nullable();
            $table->string('pant_fly')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
         Schema::table('sales', function (Blueprint $table) {
            // Shirt/Suit measurements
            $table->dropColumn([
                'shirt_length',
                'shirt_shoulder',
                'shirt_sleeves',
                'shirt_chest',
                'shirt_upper_waist',
                'shirt_lower_waist',
                'shirt_hip',
                'shirt_neck',
                'shirt_arms',
                'shirt_cuff',
                'shirt_biceps',
                'shirt_collar_type',
                'shirt_daman_type',
            ]);
            
            // Pant/Shawar measurements
            $table->dropColumn([
                'pant_length',
                'pant_waist',
                'pant_hip',
                'pant_thigh',
                'pant_knee',
                'pant_bottom',
                'pant_fly',
            ]);
        });
    }
}
