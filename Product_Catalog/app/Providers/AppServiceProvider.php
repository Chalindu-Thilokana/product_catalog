<?php

namespace App\Providers;
use Laravel\Fortify\Contracts\RegisterResponse;
use App\Actions\Fortify\CustomRegisterResponse;

use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
         $this->app->singleton(RegisterResponse::class, CustomRegisterResponse::class);
    }
}
