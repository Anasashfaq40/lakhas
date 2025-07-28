<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;

class ShopController extends Controller
{
    public function index()
    {

        $products = Product::where('is_visible', true)
                            ->where('is_active', true)
                            ->latest()
                            ->paginate(9); 

        return view('frontend.shop', compact('products'));
    }
}

