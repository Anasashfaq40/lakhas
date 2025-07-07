<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\SubCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class SubCategoriesController extends Controller
{
    public function index(Request $request)
    {
        if ($request->ajax()) {
            $data = SubCategory::with('category')->latest()->get();
            return datatables()->of($data)
                ->addColumn('category', fn($row) => $row->category->name ?? '')
                ->addColumn('image', fn($row) => $row->image
                    ? '<img src="' . asset("storage/{$row->image}") . '" width="50">'
                    : '<span class="badge bg-secondary">No Image</span>')
                ->addColumn('action', function ($row) {
                    return '
                        <button class="btn btn-sm btn-primary edit-btn" data-id="' . $row->id . '"><i class="i-Edit"></i></button>
                        <button class="btn btn-sm btn-danger delete-btn" data-id="' . $row->id . '"><i class="i-Close"></i></button>
                    ';
                })
                ->rawColumns(['image', 'action'])
                ->make(true);
        }

        $categories = Category::all();
        return view('products.sub_categories', compact('categories'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|unique:sub_categories,name',
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image',
        ]);

        if ($request->hasFile('image')) {
            $validated['image'] = $request->file('image')->store('sub_categories', 'public');
        }

        SubCategory::create($validated);

        return response()->json(['success' => true]);
    }

    public function edit($id)
    {
        $sub = SubCategory::findOrFail($id);
        return response()->json(['sub_category' => $sub]);
    }

    public function update(Request $request, $id)
    {
        $sub = SubCategory::findOrFail($id);
        $validated = $request->validate([
            'name' => 'required|unique:sub_categories,name,' . $id,
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image',
        ]);

        if ($request->hasFile('image')) {
            if ($sub->image) {
                Storage::disk('public')->delete($sub->image);
            }
            $validated['image'] = $request->file('image')->store('sub_categories', 'public');
        }

        $sub->update($validated);

        return response()->json(['success' => true]);
    }

    public function destroy($id)
    {
        $sub = SubCategory::findOrFail($id);
        if ($sub->image) {
            Storage::disk('public')->delete($sub->image);
        }
        $sub->delete();

        return response()->json(['success' => true]);
    }
}
