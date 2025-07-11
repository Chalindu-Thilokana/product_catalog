<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Services\ProductService;
use RealRashid\SweetAlert\Facades\Alert;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
class ProductController extends Controller
{
    protected ProductService $service;

    public function __construct(ProductService $service)
    {
        $this->service = $service;
    }

    public function index()
    {
        $products = $this->service->all();
        return Inertia::render('admin/dashbord', compact('products'));
    }

    public function create()
    {
        return Inertia::render('admin/create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
            'stock' => 'required|integer',
            'photo' => 'nullable|image|max:2048',
        ]);

       try {
        $this->service->store($request);
        return redirect()->route('dashboard')->with('success', '✅ Product added successfully!');
    } catch (\Exception $e) {
        return redirect()->back()->with('error', '❌ Failed to add product: ' . $e->getMessage())->withInput();
    }
    }

    public function edit(Product $product)
    {
        return Inertia::render('admin/edit', ['product' => $product
    ]);

    }

    public function update(Request $request, Product $product)
{
    $this->service->update($request, $product   );

        return redirect()->route('dashboard')
            ->with('success', 'Product updated successfully.');
}

public function destroy(Product $product)
    {
        $this->service->delete($product);
return redirect()->route('dashboard')->with('success', 'Product deleted successfully.');
    }        
}
