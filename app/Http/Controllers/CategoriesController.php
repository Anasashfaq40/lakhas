<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use DataTables;
use Carbon\Carbon;

class CategoriesController extends Controller
{
    //-------------- Get All Categories ---------------\\
    public function index(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')) {
            if ($request->ajax()) {
                $data = Category::whereNull('deleted_at')->orderBy('id', 'desc')->get();

                return DataTables::of($data)
                    ->addIndexColumn()
                    ->addColumn('image', function ($row) {
                        $url = $row->image
                            ? asset('storage/images/categories/' . $row->image)
                            : asset('assets/images/no-image.png');
                        return '<img src="' . $url . '" width="50px" class="img-thumbnail">';
                    })
                    ->addColumn('action', function ($row) {
                        return '
                            <a id="' . $row->id . '" class="edit cursor-pointer ul-link-action text-success" title="Edit"><i class="i-Edit"></i></a>
                            &nbsp;&nbsp;
                            <a id="' . $row->id . '" class="delete cursor-pointer ul-link-action text-danger" title="Remove"><i class="i-Close-Window"></i></a>
                        ';
                    })
                    ->rawColumns(['action', 'image'])
                    ->make(true);
            }

            return view('products.categories');
        }

        return abort(403, __('You are not authorized'));
    }

    //-------------- Store New Category ---------------\\
    public function store(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')) {
            $request->validate([
                'name' => 'required',
                'code' => 'required',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $data = [
                'code' => $request->code,
                'name' => $request->name,
            ];

            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $filename = time() . '.' . $image->getClientOriginalExtension();
                $image->storeAs('public/images/categories', $filename);
                $data['image'] = $filename;
            }

            Category::create($data);

            return response()->json(['success' => true]);
        }

        return abort(403, __('You are not authorized'));
    }

    //-------------- Edit Category ---------------\\
    public function edit(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')) {
            $category = Category::whereNull('deleted_at')->findOrFail($id);
            return response()->json(['category' => $category]);
        }

        return abort(403, __('You are not authorized'));
    }

    //-------------- Update Category ---------------\\
    public function update(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')) {
            $request->validate([
                'name' => 'required',
                'code' => 'required',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $category = Category::findOrFail($id);
            $data = [
                'code' => $request->code,
                'name' => $request->name,
            ];

            if ($request->hasFile('image')) {
                if ($category->image) {
                    Storage::delete('public/images/categories/' . $category->image);
                }
                $filename = time() . '.' . $request->file('image')->getClientOriginalExtension();
                $request->file('image')->storeAs('public/images/categories', $filename);
                $data['image'] = $filename;
            }

            $category->update($data);

            return response()->json(['success' => true]);
        }

        return abort(403, __('You are not authorized'));
    }

    //-------------- Remove Category ---------------\\
    public function destroy(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')) {
            $category = Category::findOrFail($id);

            if ($category->image) {
                Storage::delete('public/images/categories/' . $category->image);
            }

            $category->delete();

            return response()->json(['success' => true]);
        }

        return abort(403, __('You are not authorized'));
    }

    //-------------- Delete by selection ---------------\\
    public function delete_by_selection(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')) {
            foreach ($request->selectedIds as $id) {
                Category::whereId($id)->update(['deleted_at' => Carbon::now()]);
            }

            return response()->json(['success' => true]);
        }

        return abort(403, __('You are not authorized'));
    }


}
