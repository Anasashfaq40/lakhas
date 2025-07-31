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
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'required|string|max:1000',
        ]);

        // Prevent duplicate reviews from same user on same product (optional)
        $existing = Review::where('product_id', $validated['product_id'])
                          ->where('user_id', $validated['user_id'])
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

