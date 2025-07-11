<?php

namespace App\Actions\Fortify;

use Laravel\Fortify\Contracts\LoginResponse as LoginResponseContract;

class CustomLoginResponse implements LoginResponseContract
{
    public function toResponse($request)
    {
        $user = $request->user();

        // User type අනුව redirect වෙනස් කරන්න
        if ($user->usertype === 'admin') {
            return redirect()->intended('/dashboard');
        } elseif ($user->usertype === 'user') {
            return redirect()->intended('/');
        }

        // Default redirect path
        return redirect()->intended('/home');
    }
}
