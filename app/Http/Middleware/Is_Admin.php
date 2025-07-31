<?php

namespace App\Http\Middleware;

use Closure;
use Auth;

class Is_Admin
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    // public function handle($request, Closure $next)
    // {
	// 	if(Auth::check() && Auth::user()->role_users_id == 1){

	// 		return $next($request);
	// 	}

    //     return redirect("/dashboard/admin");
    // }
    public function handle($request, Closure $next)
{
    //  dd(Auth::user());
    if (Auth::check() && Auth::user()->role_users_id != 4) {
        return $next($request);
    }

    // Agar user ka role 4 hai to usay redirect kar do
    return redirect('/home')->with('error', 'Unauthorized access');
}

}
