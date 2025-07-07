<?php



namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Str;

class SubCategory extends Model
{
    protected $fillable = ['name', 'slug', 'image', 'category_id'];

    /**
     * Automatically slug banaye name se.
     */
    protected static function boot()
    {
        parent::boot();

        static::creating(function ($subCategory) {
            $subCategory->slug = Str::slug($subCategory->name);
        });

        static::updating(function ($subCategory) {
            if ($subCategory->isDirty('name')) {
                $subCategory->slug = Str::slug($subCategory->name);
            }
        });
    }

    /**
     * Har SubCategory ka ek Category hota hai.
     */
    public function category(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'category_id');
    }
}

