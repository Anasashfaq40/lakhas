<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    use HasFactory;
    
    protected $fillable = ['user_id', 'product_id', 'quantity', 'size', 'color', 'price'];
    
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    public function product()
    {
        return $this->belongsTo(Product::class);
    }
       public static function getCount()
    {
        if (auth()->check()) {
            return self::where('user_id', auth()->id())->count();
        }
        return 0;
    }
}
