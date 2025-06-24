<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Category extends Model
{
    protected $dates = ['deleted_at'];

    protected $fillable = [
        'code', 'name', 'image', 'sub_category_id'
    ];

    // Relationship with subcategories
    public function subcategories(): HasMany
    {
        return $this->hasMany(Category::class, 'sub_category_id');
    }

    // Relationship with parent category
    public function parent(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'sub_category_id');
    }
}