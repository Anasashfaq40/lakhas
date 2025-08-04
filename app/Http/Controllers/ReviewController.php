<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Review;
use App\Models\Product;
use Illuminate\Support\Facades\Auth;

class ReviewController extends Controller
{
public function store(Request $request)
{
    $validated = $request->validate([
        'product_id' => 'required|exists:products,id',
        'user_id' => 'required|exists:users,id',
        'order_item_id' => 'required|exists:order_items,id', // This refers to the 'id' column in order_items
        'rating' => 'required|integer|min:1|max:5',
        'comment' => 'required|string|max:1000',
    ]);

    // Check if this order item already has a review
    $existing = Review::where('order_item_id', $validated['order_item_id'])
                      ->first();

    if ($existing) {
        return back()->with('error', 'You have already reviewed this product.');
    }

    Review::create($validated);

    return back()->with('success', 'Thank you for your review!');
}
    public function index()
    {
        $reviews = Review::with(['product', 'user'])->latest()->paginate(10);
        return view('products.reviews', compact('reviews'));
    }
    public function destroy($id)
{
    $review = Review::findOrFail($id);
    $review->delete();

    return response()->json(['success' => true]);
}
}

