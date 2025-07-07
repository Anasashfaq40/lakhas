<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCategoriesTable extends Migration {

    public function up()
    {
        Schema::create('categories', function(Blueprint $table)
        {
            $table->increments('id'); // auto-incrementing primary key
            $table->string('code', 192);
            $table->string('name', 192);
            $table->string('image')->nullable(); // optional image field
            $table->timestamps(6);
            $table->softDeletes();
        });
    }

    public function down()
    {
        Schema::drop('categories');
    }
}
