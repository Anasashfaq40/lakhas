<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $dates = ['deleted_at', 'promo_start_date', 'promo_end_date'];

    protected $fillable = [
        // Basic Product Information
        'code', 'Type_barcode', 'name', 'cost', 'price', 'unit_id', 'unit_sale_id', 'unit_purchase_id',
        'stock_alert', 'category_id', 'sub_category_id', 'is_variant', 'is_imei', 'is_promo', 'promo_price', 
        'promo_start_date', 'promo_end_date', 'tax_method', 'image', 'brand_id', 'is_active', 'note', 'qty_min',
        'is_visible', 'TaxNet',
        
        // Product Type
        'type', // is_single, is_service, is_variant, stitched_garment, unstitched_garment
        'garment_type', // shalwar_suit, pant_shirt
        
        // Shalwar/Suit Measurements
        'kameez_length', 'kameez_shoulder', 'kameez_sleeves', 'kameez_chest',
        'kameez_upper_waist', 'kameez_lower_waist', 'kameez_hip', 'kameez_neck',
        'kameez_arms', 'kameez_cuff', 'kameez_biceps',
        
        // Shalwar Measurements
        'shalwar_length', 'shalwar_waist', 'shalwar_bottom',
        
        // Collar Types (Shalwar/Suit)
        'collar_shirt', 'collar_sherwani', 'collar_damian', 'collar_round', 'collar_square',
        
        // Pant/Shirt Measurements
        'pshirt_length', 'pshirt_shoulder', 'pshirt_sleeves', 'pshirt_chest', 'pshirt_neck',
        
        // Collar Types (Pant/Shirt)
        'pshirt_collar_shirt', 'pshirt_collar_round', 'pshirt_collar_square',
        
        // Pant Measurements
        'pant_length', 'pant_waist', 'pant_hip', 'pant_thai', 'pant_knee', 'pant_bottom', 'pant_fly',
        
        // Unstitched Garment Properties
        'thaan_length', 'suit_length', 'available_sizes'
    ];

    protected $casts = [
        'category_id' => 'integer',
        'sub_category_id' => 'integer',
        'unit_id' => 'integer',
        'unit_sale_id' => 'integer',
        'unit_purchase_id' => 'integer',
        'brand_id' => 'integer',
        'is_active' => 'boolean',
        'is_visible' => 'boolean',
        'cost' => 'decimal:2',
        'price' => 'decimal:2',
        'stock_alert' => 'decimal:2',
        'qty_min' => 'decimal:2',
        'TaxNet' => 'decimal:2',
        'promo_price' => 'decimal:2',
        'thaan_length' => 'decimal:2',
        'suit_length' => 'decimal:2',
        
        // Measurement fields
        'kameez_length' => 'decimal:2',
        'kameez_shoulder' => 'decimal:2',
        'kameez_sleeves' => 'decimal:2',
        'kameez_chest' => 'decimal:2',
        'kameez_upper_waist' => 'decimal:2',
        'kameez_lower_waist' => 'decimal:2',
        'kameez_hip' => 'decimal:2',
        'kameez_neck' => 'decimal:2',
        'kameez_arms' => 'decimal:2',
        'kameez_cuff' => 'decimal:2',
        'kameez_biceps' => 'decimal:2',
        'shalwar_length' => 'decimal:2',
        'shalwar_waist' => 'decimal:2',
        'shalwar_bottom' => 'decimal:2',
        'pshirt_length' => 'decimal:2',
        'pshirt_shoulder' => 'decimal:2',
        'pshirt_sleeves' => 'decimal:2',
        'pshirt_chest' => 'decimal:2',
        'pshirt_neck' => 'decimal:2',
        'pant_length' => 'decimal:2',
        'pant_waist' => 'decimal:2',
        'pant_hip' => 'decimal:2',
        'pant_thai' => 'decimal:2',
        'pant_knee' => 'decimal:2',
        'pant_bottom' => 'decimal:2',
        'pant_fly' => 'decimal:2',
        
        // Boolean fields
        'collar_shirt' => 'boolean',
        'collar_sherwani' => 'boolean',
        'collar_damian' => 'boolean',
        'collar_round' => 'boolean',
        'collar_square' => 'boolean',
        'pshirt_collar_shirt' => 'boolean',
        'pshirt_collar_round' => 'boolean',
        'pshirt_collar_square' => 'boolean',
        'is_promo' => 'boolean',
        'is_variant' => 'boolean',
        'is_imei' => 'boolean',
        
        // Array fields
        'available_sizes' => 'array'
    ];

    // Relationships
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
    public function subcategory()
    {
    return $this->belongsTo(SubCategory::class, 'sub_category_id');
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
    
    // Scopes
    public function scopeStandardProducts($query)
    {
        return $query->where('type', 'is_single');
    }
    
    public function scopeServiceProducts($query)
    {
        return $query->where('type', 'is_service');
    }
    
    public function scopeVariantProducts($query)
    {
        return $query->where('type', 'is_variant');
    }
    
    public function scopeStitchedGarments($query)
    {
        return $query->where('type', 'stitched_garment');
    }
    
    public function scopeUnstitchedGarments($query)
    {
        return $query->where('type', 'unstitched_garment');
    }
    
    public function scopeShalwarSuits($query)
    {
        return $query->where('garment_type', 'shalwar_suit');
    }
    
    public function scopePantShirts($query)
    {
        return $query->where('garment_type', 'pant_shirt');
    }
    
    // Accessors
    public function getTypeNameAttribute()
    {
        $types = [
            'is_single' => 'Standard Product',
            'is_service' => 'Service Product',
            'is_variant' => 'Variant Product',
            'stitched_garment' => 'Stitched Garment',
            'unstitched_garment' => 'Unstitched Garment'
        ];
        
        return $types[$this->type] ?? $this->type;
    }
    
    public function getGarmentTypeNameAttribute()
    {
        $types = [
            'shalwar_suit' => 'Shalwar/Suit',
            'pant_shirt' => 'Pant/Shirt'
        ];
        
        return $types[$this->garment_type] ?? $this->garment_type;
    }
    
    public function getMeasurementDetailsAttribute()
    {
        if ($this->type === 'stitched_garment') {
            if ($this->garment_type === 'shalwar_suit') {
                return [
                    'Kameez' => [
                        'Length' => $this->kameez_length,
                        'Shoulder' => $this->kameez_shoulder,
                        'Sleeves' => $this->kameez_sleeves,
                        'Chest' => $this->kameez_chest,
                        'Upper Waist' => $this->kameez_upper_waist,
                        'Lower Waist' => $this->kameez_lower_waist,
                        'Hip' => $this->kameez_hip,
                        'Neck' => $this->kameez_neck,
                        'Arms' => $this->kameez_arms,
                        'Cuff' => $this->kameez_cuff,
                        'Biceps' => $this->kameez_biceps
                    ],
                    'Shalwar' => [
                        'Length' => $this->shalwar_length,
                        'Waist' => $this->shalwar_waist,
                        'Bottom' => $this->shalwar_bottom
                    ],
                    'Collar Types' => [
                        'Shirt' => $this->collar_shirt,
                        'Sherwani' => $this->collar_sherwani,
                        'Damian' => $this->collar_damian,
                        'Round' => $this->collar_round,
                        'Square' => $this->collar_square
                    ]
                ];
            } else {
                return [
                    'Shirt' => [
                        'Length' => $this->pshirt_length,
                        'Shoulder' => $this->pshirt_shoulder,
                        'Sleeves' => $this->pshirt_sleeves,
                        'Chest' => $this->pshirt_chest,
                        'Neck' => $this->pshirt_neck
                    ],
                    'Pant' => [
                        'Length' => $this->pant_length,
                        'Waist' => $this->pant_waist,
                        'Hip' => $this->pant_hip,
                        'Thai' => $this->pant_thai,
                        'Knee' => $this->pant_knee,
                        'Bottom' => $this->pant_bottom,
                        'Fly' => $this->pant_fly
                    ],
                    'Collar Types' => [
                        'Shirt' => $this->pshirt_collar_shirt,
                        'Round' => $this->pshirt_collar_round,
                        'Square' => $this->pshirt_collar_square
                    ]
                ];
            }
        } elseif ($this->type === 'unstitched_garment') {
            return [
                'Thaan Length' => $this->thaan_length,
                'Suit Length' => $this->suit_length,
                'Available Sizes' => $this->available_sizes
            ];
        }
        
        return null;
    }
    
    // Mutators
    public function setAvailableSizesAttribute($value)
    {
        $this->attributes['available_sizes'] = json_encode($value);
    }
    
    public function setKameezLengthAttribute($value)
    {
        $this->attributes['kameez_length'] = $value ?: null;
    }
    
    // Similar mutators can be added for other measurement fields to handle empty values
    
    // Other methods
    public function hasMeasurements()
    {
        return in_array($this->type, ['stitched_garment', 'unstitched_garment']);
    }
    
    public function isGarment()
    {
        return in_array($this->type, ['stitched_garment', 'unstitched_garment']);
    }
    public function reviews()
{
    return $this->hasMany(Review::class);
}


public function averageRating()
{
    return $this->reviews()->avg('rating');
}

}