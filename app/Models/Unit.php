<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Unit extends Model
{
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'name', 
        'ShortName', 
        'base_unit', 
        'operator', 
        'operator_value', 
        'is_active',
    ];

    protected $casts = [
        'base_unit' => 'integer',
        'operator_value' => 'float',
        'is_active' => 'boolean',
    ];

    public function baseUnit()
    {
        return $this->belongsTo(Unit::class, 'base_unit');
    }

    public function subUnits()
    {
        return $this->hasMany(Unit::class, 'base_unit');
    }

    public function products()
    {
        return $this->hasMany(Product::class, 'unit_id');
    }

    public function saleProducts()
    {
        return $this->hasMany(Product::class, 'unit_sale_id');
    }
}