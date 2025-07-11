<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckUserType
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next,...$usertype): Response
    {
         if (!in_array($request->user()->usertype, $usertype)) {
            abort(403, 'Unauthorized action.'); // Redirect if the role doesn't match
        }

        

        return $next($request);
    
    }
}
