<?php

namespace App\Http\Controllers;

use App\Models\SubCategory;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Storage;

class SubCategoriesController extends Controller
{
    // Get All SubCategories
    public function index()
    {
        $sub_categories = SubCategory::orderBy('id', 'desc')->get();
        return view('products.sub_categories', compact('sub_categories'));
    }

    // Store New SubCategory
  public function store(Request $request)
{
    $request->validate([
        'name' => 'required|unique:sub_categories,name',
        'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
    ]);

    $imagePath = null;
    if ($request->hasFile('image')) {
        $imagePath = $request->file('image')->store('sub_categories', 'public');
    }

    SubCategory::create([
        'name' => $request->name,
        'image' => $imagePath,
    ]);

    return response()->json(['success' => true]);
}
    // Edit SubCategory
    public function edit($id)
    {
        $sub_category = SubCategory::findOrFail($id);
        return response()->json([
            'sub_category' => $sub_category,
        ]);
    }

    // Update SubCategory
     
// Update the update method
public function update(Request $request, $id)
{
    $request->validate([
        'name' => 'required|unique:sub_categories,name,' . $id,
        'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
    ]);

    $subCategory = SubCategory::findOrFail($id);
    $data = ['name' => $request->name];

    if ($request->hasFile('image')) {
    
        if ($subCategory->image) {
            Storage::disk('public')->delete($subCategory->image);
        }
        $data['image'] = $request->file('image')->store('sub_categories', 'public');
    }

    $subCategory->update($data);

    return response()->json(['success' => true]);
}

    // Delete SubCategory
    public function destroy($id)
    {
        SubCategory::findOrFail($id)->delete();
        return response()->json(['success' => true]);
    }
}