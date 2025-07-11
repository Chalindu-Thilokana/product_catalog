<?php

use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\WebController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\OdersController;
/*u
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [WebController::class, 'index'])->name('product_view');
Route::get('/filter', [WebController::class, 'filter'])->name('products.filter');
Route::get('/Cart_index', [WebController::class, 'show'])->name('Cart_index');
Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {


        Route::middleware(['auth:sanctum', 'verified', 'usertype:admin'])->group(function () {
    
    
         //   Route::get('/dashboard', function () {
        //return Inertia::render('admin/dashbord');
    //})->name('dashboard');

    Route::get('/dashboard', [ProductController::class, 'index'])->name('dashboard');

    // Show create form
    Route::get('products/create', [ProductController::class, 'create'])->name('products.create');

    // Store new product
    Route::post('products/store', [ProductController::class, 'store'])->name('products.store');

    // Show edit form
    Route::get('products/{product}/edit', [ProductController::class, 'edit'])->name('products.edit');

    // Update product
    Route::put('products/{product}', [ProductController::class, 'update'])->name('products.update');

    // Delete product
    Route::delete('products/{product}', [ProductController::class, 'destroy'])->name('products.destroy');

                Route::get('/orders/show', [OdersController::class, 'show'])->name('orders.show');



        });


                Route::middleware(['auth:sanctum', 'verified', 'usertype:user'])->group(function () {
                  Route::get('/cart', [CartController::class, 'index'])->name('cart.index');
                  Route::post('/cart/add', [CartController::class, 'add'])->name('cart.add');
                 Route::post('/cart/update', [CartController::class, 'update'])->name('cart.update');
                Route::post('/cart/remove', [CartController::class, 'remove'])->name('cart.remove');
                    Route::post('/cart/clear', [CartController::class, 'clear'])->name('cart.clear');
                Route::post('/checkout', [OdersController::class, 'create'])->name('checkout');
                Route::get('/orders', [OdersController::class, 'index'])->name('orders.index');
                });



});
