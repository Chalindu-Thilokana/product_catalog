<?php

namespace App\Providers;
use Laravel\Fortify\Contracts\RegisterResponse;
use App\Actions\Fortify\CustomRegisterResponse;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;
use App\Models\Product;

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
           Inertia::share('cartItems', function () {
            $cart = session('cart', []);
            $productIds = array_keys($cart);
            $products = Product::whereIn('id', $productIds)->get()->keyBy('id');

            $items = [];

            foreach ($cart as $productId => $item) {
                if (isset($products[$productId])) {
                    $product = $products[$productId];
                    $product->price = (float) $product->price;

                    $items[] = [
                        'product_id' => $productId,
                        'quantity' => $item['quantity'],
                        'product' => $product,
                        'total' => $product->price * $item['quantity'],
                    ];
                }
            }

            return $items;
        });
         
    }
}
