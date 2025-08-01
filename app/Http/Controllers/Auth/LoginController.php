<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Providers\RouteServiceProvider;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Login Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles authenticating users for the application and
    | redirecting them to your home screen. The controller uses a trait
    | to conveniently provide its functionality to your applications.
    |
    */

    use AuthenticatesUsers;

    /**
     * Where to redirect users after login.
     *
     * @var string
     */
    protected $redirectTo = RouteServiceProvider::HOME;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('guest')->except('logout');
    }

    

    // public function authenticate(Request $request)
    // {
    //     $credentials = $request->validate([
    //         'email' => ['required', 'email'],
    //         'password' => ['required'],
    //         'status'   => 1
    //     ]);

    //     if (Auth::attempt($credentials)) {

    //         $request->session()->regenerate();
            
    //         $user_Auth = Auth::User();
    //         return redirect('/dashboard/admin');
    //     }
    // }
    public function authenticated(Request $request)
{
    $credentials = $request->validate([
        'email' => ['required', 'email'],
        'password' => ['required'],
    ]);

    if (Auth::attempt($credentials)) {
        $request->session()->regenerate();

        $user = Auth::user();

        if ($user->status != 1) {
            Auth::logout();
            return redirect('/login')->with('erro_login', 'Your Account Inactivated');
        }

        // Role-based redirect
        if ($user->role_users_id == 1) {
            return redirect('/dashboard/admin');
      } elseif ($user->role_users_id == 2) {
            return redirect('/dashboard/admin');
        } elseif ($user->role_users_id == 3) {
            return redirect('/dashboard/admin');
        } elseif ($user->role_users_id == 4) {
            return redirect('/home');
        }

        return redirect('/login');
    }

    return back()->withErrors([
        'email' => 'The provided credentials do not match our records.',
    ]);
}

}
