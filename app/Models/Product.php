<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'code', 'Type_barcode', 'name', 'cost', 'price', 'unit_id', 'unit_sale_id', 'unit_purchase_id',
        'stock_alert', 'category_id', 'sub_category_id', 'is_variant', 'is_imei', 'is_promo', 'promo_price', 
        'promo_start_date', 'promo_end_date', 'tax_method', 'image', 'brand_id', 'is_active', 'note', 'qty_min',
        'is_visible', 'type', 'garment_type',
        
        // Shirt/Suit measurements
        'shirt_length', 'shirt_shoulder', 'shirt_sleeves', 'shirt_chest',
        'shirt_upper_waist', 'shirt_lower_waist', 'shirt_hip', 'shirt_neck',
        'shirt_arms', 'shirt_cuff', 'shirt_biceps',
        
        // Pant/Shalwar measurements
        'pant_length', 'pant_waist', 'pant_hip', 'pant_thai', 
        'pant_knee', 'pant_bottom', 'pant_fly',
        
        // Collar types
        'collar_shirt', 'collar_sherwani', 'collar_damian', 'collar_round', 'collar_square',
        
        // Unstitched Garment Properties
        'thaan_length', 'suit_length', 'available_sizes'
    ];

    protected $casts = [
        'category_id' => 'integer',
        'sub_category_id' => 'integer',
        'unit_id' => 'integer',
        'unit_sale_id' => 'integer',
        'unit_purchase_id' => 'integer',
        'is_variant' => 'integer',
        'is_imei' => 'integer',
        'brand_id' => 'integer',
        'is_active' => 'integer',
        'is_visible' => 'boolean',
        'cost' => 'double',
        'price' => 'double',
        'stock_alert' => 'double',
        'qty_min' => 'double',
        'TaxNet' => 'double',
        'is_promo' => 'integer',
        'promo_price' => 'double',
        'thaan_length' => 'float',
        'suit_length' => 'float',
        
        'available_sizes' => 'array',
        'collar_shirt' => 'boolean',
        'collar_sherwani' => 'boolean',
        'collar_damian' => 'boolean',
        'collar_round' => 'boolean',
        'collar_square' => 'boolean',
        'is_promo' => 'boolean',
        'is_variant' => 'boolean',
        'is_imei' => 'boolean',
        'not_selling' => 'boolean',
    ];

    public function variants()
    {
        return $this->hasMany(ProductVariant::class);
    }

    public function PurchaseDetail()
    {
        return $this->belongsTo('App\Models\PurchaseDetail');
    }

    public function images()
    {
        return $this->hasMany(\App\Models\ProductImage::class);
    }

    public function SaleDetail()
    {
        return $this->belongsTo('App\Models\SaleDetail');
    }

    public function QuotationDetail()
    {
        return $this->belongsTo('App\Models\QuotationDetail');
    }

    public function category()
    {
        return $this->belongsTo('App\Models\Category');
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'unit_id');
    }

    public function unitPurchase()
    {
        return $this->belongsTo(Unit::class, 'unit_purchase_id');
    }

    public function unitSale()
    {
        return $this->belongsTo(Unit::class, 'unit_sale_id');
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }

    public function ledgers()
    {
        return $this->hasMany(ProductLedger::class);
    }
    
    // Scope for garment types
    public function scopeStitchedGarments($query)
    {
        return $query->where('type', 'stitched_garment');
    }
    
    public function scopeUnstitchedGarments($query)
    {
        return $query->where('type', 'unstitched_garment');
    }
    
    // Accessor for garment type
    public function getGarmentTypeNameAttribute()
    {
        $types = [
            'shirt_suit' => 'Shirt/Suit',
            'pant_shalwar' => 'Pant/Shalwar'
        ];
        
        return $types[$this->garment_type] ?? null;
    }
}