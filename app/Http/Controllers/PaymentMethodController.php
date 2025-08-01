<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\PaymentMethod;
use Carbon\Carbon;

class PaymentMethodController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $user_auth = auth()->user();
		if ($user_auth->can('payment_method')){

            $payment_methods = PaymentMethod::where('deleted_at', '=', null)->orderBy('id', 'desc')->get();
            return view('accounting.payment_methods', compact('payment_methods'));

        }
        return abort('403', __('You are not authorized'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('payment_method')){

            request()->validate([
                'title'           => 'required|string|max:255',
            ]);

            PaymentMethod::create([
                'title'           => $request['title'],
                'is_default'      => 0,
            ]);

            return response()->json(['success' => true]);

        }
        return abort('403', __('You are not authorized'));
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
 public function update(Request $request, $id)
{
    $user_auth = auth()->user();
    if ($user_auth->can('payment_method')) {

        request()->validate([
            'title' => 'required|string|max:255',
        ]);

        $method = PaymentMethod::findOrFail($id);
        if ($method->is_default == 1) {
            return response()->json(['message' => 'Default method cannot be updated.'], 403);
        }

        $method->update([
            'title' => $request->title,
        ]);

        return response()->json(['success' => true]);
    }

    return abort('403', __('You are not authorized'));
}


    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user_auth = auth()->user();
		if ($user_auth->can('payment_method')){

            PaymentMethod::where('is_default', 0)->whereId($id)->update([
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
         if($user_auth->can('payment_method')){
             $selectedIds = $request->selectedIds;
     
             foreach ($selectedIds as $payment_method_id) {
                PaymentMethod::where('is_default', 0)->whereId($payment_method_id)->update([
                    'deleted_at' => Carbon::now(),
                ]);
             }
             return response()->json(['success' => true]);
         }
         return abort('403', __('You are not authorized'));
      }
}
