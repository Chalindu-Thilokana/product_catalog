<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Route;
use App\Services\ProductService;

class WebController extends Controller
{
    protected ProductService $service;

    public function __construct(ProductService $service)
    {
        $this->service = $service;
    }

    public function index()
    {
        $products = $this->service->all();

        return Inertia::render('web/product_view', [
            'products' => $products,
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }

    public function show(Product $product)
    {
        return Inertia::render('web/cart/cart_index', [
            'product' => $product,
        ]);
    }

    public function filter(Request $request)
    {
        if (!$request->filled('name')) {
            return redirect()->route('product_view');
        }

        $products = $this->service->filter($request);

        return Inertia::render('web/product_view', [
            'products' => $products,
            'filters' => $request->only('name'),
            'canLogin' => Route::has('login'),
            'canRegister' => Route::has('register'),
        ]);
    }
}
