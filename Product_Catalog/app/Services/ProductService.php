<?php

namespace App\Services;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Log;
class ProductService
{

    
    public function all()
    {
        return Product::paginate(10);
    }

    public function store(Request $request)
    {
        $data = $request->only(['name', 'description', 'price', 'stock']);
        
        if ($request->hasFile('photo')) {
            $data['photo'] = $request->file('photo')->store('products', 'public');
        }

        return Product::create($data);
    }

    public function update(Request $request, Product $product)
    {
        
         
        
    $validatedData = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'stock' => 'required|integer|min:0',
            'photo' => 'nullable|image|max:2048',
        ]);

        if ($request->hasFile('photo')) {
            if ($product->photo) {
                Storage::disk('public')->delete($product->photo);
            }
            $validatedData['photo'] = $request->file('photo')->store('products', 'public');
        } else {
            $validatedData['photo'] = $product->photo;
        }

        $product->update($validatedData);

        return $product;

    }

    public function delete(Product $product)
    {
       
        
        if ($product->photo && Storage::disk('public')->exists($product->photo)) {
            Storage::disk('public')->delete($product->photo);
        }
        
        return $product->delete();
    }

    public function filter(Request $request)
    {
        $query = Product::query();

        if ($request->filled('name')) {
            $query->where('name', 'like', '%' . $request->input('name') . '%');
        }

        return $query->paginate(5)->appends(request()->query());
    }
}