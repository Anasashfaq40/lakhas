<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'date', 'Ref', 'is_pos', 'client_id', 'GrandTotal', 'qte_retturn', 'TaxNet', 'tax_rate', 'notes',
        'total_retturn', 'warehouse_id', 'user_id', 'statut', 'discount', 'shipping',
        'paid_amount', 'payment_statut', 'created_at', 'updated_at', 'deleted_at','discount_type','discount_percent_total',
        'shirt_length', 'shirt_shoulder', 'shirt_sleeves', 'shirt_chest',
        'shirt_upper_waist', 'shirt_lower_waist', 'shirt_hip', 'shirt_neck',
        'shirt_arms', 'shirt_cuff', 'shirt_biceps', 'shirt_collar_type', 'shirt_daman_type',
        'pant_length', 'pant_waist', 'pant_hip', 'pant_thigh',
        'pant_knee', 'pant_bottom', 'pant_fly',
    ];

    protected $casts = [
        'is_pos' => 'integer',
        'GrandTotal' => 'double',
        'qte_retturn' => 'double',
        'total_retturn' => 'double',
        'user_id' => 'integer',
        'client_id' => 'integer',
        'warehouse_id' => 'integer',
        'discount' => 'double',
        'discount_percent_total' => 'double',
        'shipping' => 'double',
        'TaxNet' => 'double',
        'tax_rate' => 'double',
        'paid_amount' => 'double',
    ];

    public function user()
    {
        return $this->belongsTo('App\Models\User');
    }

    public function details()
    {
        return $this->hasMany('App\Models\SaleDetail');
    }

    public function client()
    {
        return $this->belongsTo('App\Models\Client');
    }

    public function facture()
    {
        return $this->hasMany('App\Models\PaymentSale');
    }

    public function warehouse()
    {
        return $this->belongsTo('App\Models\Warehouse');
    }

}
