<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class OrderItem extends Model
{
    protected $fillable = ['order_id', 'product_id', 'user_id', 'quantity', 'price'];

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
    public function user()
{
    return $this->belongsTo(User::class);
}
public function review()
{
    return $this->hasOne(Review::class, 'order_item_id', 'id');
}

}

