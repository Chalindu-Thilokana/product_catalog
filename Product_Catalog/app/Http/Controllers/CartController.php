<?php

namespace App\Http\Controllers;

use App\Services\CartService;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\Product;
use Illuminate\Support\Facades\Session;

class CartController extends Controller
{
    protected $cartService;

    public function __construct(CartService $cartService)
    {
        $this->cartService = $cartService;
    }

    public function index( )
    {
$cart = $this->cartService->getAll();
        $productIds = array_keys($cart);
        $products = Product::whereIn('id', $productIds)->get()->keyBy('id');

        $items = [];

        foreach ($cart as $productId => $item) {
            if (isset($products[$productId])) {
                $product = $products[$productId];
                $product->price = (float) $product->price;

                $items[] = [
                    'product_id' => $productId,
                    'user_id' => auth()->id(),
                    'quantity' => $item['quantity'],
                    'product' => $product,
                    'total' => (float) $product->price * $item['quantity'],
                ];
            }
        }

        return Inertia::render('web/cart/cart_index', [
            'cartItems' => $items,
        ]);
    }

    public function add(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'sometimes|integer|min:1',
        ]);

        $quantity = $request->quantity ?? 1;
        $this->cartService->add($request->product_id, auth()->id(), $quantity);

        return back()->with('success', 'Added to cart!');
    }

    public function update(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|integer|min:1',
        ]);

        $this->cartService->update($request->product_id, $request->quantity);

        return back()->with('success', 'Cart updated!');
    }

    public function remove(Request $request)
    {
        $request->validate([
            'product_id' => 'required|exists:products,id',
        ]);

        $this->cartService->remove($request->product_id);

        return back()->with('success', 'Item removed!');
    }

    public function clear()
    {
        $this->cartService->clear();

        return back()->with('success', 'Cart cleared!');
    }
}
