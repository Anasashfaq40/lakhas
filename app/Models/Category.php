<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\SoftDeletes;

class Category extends Model
{
    use SoftDeletes;

    protected $dates = ['deleted_at'];

    protected $fillable = ['code', 'name', 'image'];

    /**
     * Category ke paas kai SubCategories hoti hain.
     */
    public function subcategories(): HasMany
    {
        return $this->hasMany(SubCategory::class, 'category_id');
    }
}
