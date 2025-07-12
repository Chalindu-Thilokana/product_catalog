<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Services\OrderService;
use App\Models\Item_oder;
use App\Models\Product; 
use App\Models\Orders;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Inertia\Inertia;
class OdersController extends Controller
{
    //
/*        public function create(Request $request)
    {
        $user = auth()->user(); // Authenticated user
        $carts = Session::get('cart', []);

        if (empty($carts)) {
            return redirect()->back()->with('error', 'Cart is empty!');
        }

        DB::beginTransaction();

        try {
            // 1. Calculate total
            $total = 0;
            foreach ($carts as $cart) {
                $product = Product::find($cart['product_id']);
                if (!$product) {
                    DB::rollBack();
                    return redirect()->back()->with('error', "Product not found!");
                }
                $total += $cart['quantity'] * $product->price;
            }

            // 2. Create Order
            $order = Orders::create([
                'user_id' => $user->id,
                'total' => $total,
            ]);

            // 3. Create Order Items + reduce stock
            foreach ($carts as $cart) {
                $product = Product::find($cart['product_id']);

                if ($product->stock < $cart['quantity']) {
                    DB::rollBack();
                    return redirect()->back()->with('error', "Not enough stock for {$product->name}");
                }

                $product->stock -= $cart['quantity'];
                $product->save();

                Item_oder::create([
                    'order_id' => $order->id,
                    'product_id' => $product->id,
                    'quantity' => $cart['quantity'],
                    'price' => $product->price,
                ]);
            }

            // 4. Clear cart
            Session::forget('cart');

            DB::commit();

            // Optional: Show order or redirect anywhere
            return redirect()->route('dashboard')->with('success', 'Order placed successfully!');
        } catch (\Exception $e) {
            DB::rollBack();
            return redirect()->back()->with('error', 'Something went wrong: ' . $e->getMessage());
        }
    }
        */


 protected OrderService $service;

    public function __construct(OrderService $orderService)
    {
        $this->service = $orderService;
    }

    public function create(Request $request)
    {
        try {
            $user = auth()->user();
            $order = $this->service->checkout($user);

            return redirect()->route('cart.index')->with('success', 'Order placed successfully!');
        } catch (\Exception $e) {
            return redirect()->back()->with('error', $e->getMessage());
        }
    }


   

    public function index()
    {
        $orders = $this->service->getOrdersForUser();
        return Inertia::render('web/oders/oder_index', compact('orders'));
    }

     public function show()
    {
        $orders = $this->service->getOrdersForUser();
       // return Inertia::render('admin/oders/oder', compact('orders'));
           //return Inertia::render('admin/oders/oder', compact('orders', 'orderCount'));

 return Inertia::render('admin/oders/oder', [
        'orders' => $orders['orders'],
        'orderCount' => $orders['orderCount'],
    ]);
    }
}
