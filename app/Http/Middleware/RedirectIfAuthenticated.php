<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class RedirectIfAuthenticated
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|null  $guard
     * @return mixed
     */
    public function handle($request, Closure $next, $guard = null)
    {
        if (Auth::guard($guard)->check() && Auth::user()->status) {
            $roleId = Auth::user()->role_users_id;

            switch ($roleId) {
                case 1:
                    return redirect('/dashboard/admin');
                case 2:
                    return redirect('/dashboard/admin');
                case 3:
                    return redirect('/dashboard/admin');
                case 4:
                    return redirect('/home');
                default:
                    return redirect('/login'); // fallback
            }
        }

        return $next($request);
    }
}
