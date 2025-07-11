<?php

namespace App\Services;

use App\Models\Orders;
use App\Models\Product;
use App\Models\Item_oder; 
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Auth;
class OrderService
{
    public function checkout($user)
    {
        $carts = Session::get('cart', []);

        if (empty($carts)) {
            throw new \Exception('Cart is empty!');
        }

        DB::beginTransaction();

        try {
           
            
            $total = 0;
            foreach ($carts as $cart) {
                $product = Product::find($cart['product_id']);
                if (!$product) {
                    throw new \Exception("Product not found!");
                }

                $total += $cart['quantity'] * $product->price;
            }

      
            
            $order = Orders::create([
                'user_id' => $user->id,
                'total' => $total,
            ]);

           
            
            foreach ($carts as $cart) {
                $product = Product::find($cart['product_id']);

                if ($product->stock < $cart['quantity']) {
                    throw new \Exception("Not enough stock for {$product->name}");
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

     
            
            Session::forget('cart');

            DB::commit();
            return $order;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }


    public function getOrdersForUser()
    {
        $user = Auth::user();

        if ($user->usertype === 'admin') {
            
            return Orders::with(['item_oder.product', 'user'])->get();
        } else {
            
            
            return Orders::with(['item_oder.product'])
                         ->where('user_id', $user->id)
                         ->get();
        }
    }
}
