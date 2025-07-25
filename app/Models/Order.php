<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Order extends Model
{
    protected $fillable = [
        'first_name', 'last_name', 'company_name', 'country', 'address1', 'address2',
        'city', 'state', 'zipcode', 'phone', 'email', 'different_address',
        'payment_method', 'total'
    ];

    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }
}

