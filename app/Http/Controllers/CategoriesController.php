<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Carbon\Carbon;
use Illuminate\Contracts\Support\Renderable;
use DataTables;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Storage;


class CategoriesController extends Controller
{

    //-------------- Get All Categories ---------------\\

   public function index(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')){
            if ($request->ajax()) {
                $data = Category::with('parent')
                    ->where('deleted_at', '=', null)
                    ->orderBy('id', 'desc')
                    ->get();

                return Datatables::of($data)->addIndexColumn()
                    ->addColumn('image', function($row){
                        $url = $row->image ? asset('storage/images/categories/'.$row->image) : asset('assets/images/no-image.png');
                        return '<img src="'.$url.'" width="50px" class="img-thumbnail">';
                    })
                    ->addColumn('subcategory', function($row){
                        return $row->parent ? $row->parent->name : 'N/A';
                    })
                    ->addColumn('action', function($row){
                        $btn = '<a id="' .$row->id. '"  class="edit cursor-pointer ul-link-action text-success"
                        data-toggle="tooltip" data-placement="top" title="Edit"><i class="i-Edit"></i></a>';
                        $btn .= '&nbsp;&nbsp;';
                        $btn .= '<a id="' .$row->id. '" class="delete cursor-pointer ul-link-action text-danger"
                        data-toggle="tooltip" data-placement="top" title="Remove"><i class="i-Close-Window"></i></a>';
                        return $btn;
                    })
                    ->rawColumns(['action', 'image'])
                    ->make(true);
            }

            $subcategories = Category::where('deleted_at', null)->get();
            return view('products.categories', compact('subcategories'));
        }
        return abort('403', __('You are not authorized'));
    }

    //-------------- Store New Category ---------------\\

 public function store(Request $request)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')){
            request()->validate([
                'name' => 'required',
                'code' => 'required',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $data = [
                'code' => $request['code'],
                'name' => $request['name'],
                'sub_category_id' => $request['sub_category_id'],
            ];

            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $filename = time().'.'.$image->getClientOriginalExtension();
                $image->storeAs('public/images/categories', $filename);
                $data['image'] = $filename;
            }

            Category::create($data);
            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

     //------------ function show -----------\\

    public function show($id){
        //
    
    }

      public function edit(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')){
            $category = Category::where('deleted_at', '=', null)->findOrFail($id);
            $subcategories = Category::where('deleted_at', null)
                ->where('id', '!=', $id)
                ->get();
                
            return response()->json([
                'category' => $category,
                'subcategories' => $subcategories,
            ]);
        }
        return abort('403', __('You are not authorized'));
    }

    //-------------- Update Category ---------------\\

   public function update(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')){
            request()->validate([
                'name' => 'required',
                'code' => 'required',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $category = Category::findOrFail($id);
            $data = [
                'code' => $request['code'],
                'name' => $request['name'],
                'sub_category_id' => $request['sub_category_id'],
            ];

            if ($request->hasFile('image')) {
                // Delete old image if exists
                if ($category->image) {
                    Storage::delete('public/images/categories/'.$category->image);
                }
                
                $image = $request->file('image');
                $filename = time().'.'.$image->getClientOriginalExtension();
                $image->storeAs('public/images/categories', $filename);
                $data['image'] = $filename;
            }

            $category->update($data);
            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }
    //-------------- Remove Category ---------------\\

     public function destroy(Request $request, $id)
    {
        $user_auth = auth()->user();
        if ($user_auth->can('category')){
            $category = Category::findOrFail($id);
            
            // Delete image if exists
            if ($category->image) {
                Storage::delete('public/images/categories/'.$category->image);
            }
            
            $category->update([
                'deleted_at' => Carbon::now(),
            ]);
            return response()->json(['success' => true]);
        }
        return abort('403', __('You are not authorized'));
    }

    //-------------- Delete by selection  ---------------\\

    public function delete_by_selection(Request $request)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('category')){

            $selectedIds = $request->selectedIds;

            foreach ($selectedIds as $category_id) {
                Category::whereId($category_id)->update([
                    'deleted_at' => Carbon::now(),
                ]);
            }

            return response()->json(['success' => true]);

        }
        return abort('403', __('You are not authorized'));
    }

}
