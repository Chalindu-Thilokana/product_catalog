<?php

namespace App\Services;

use Illuminate\Support\Facades\Session;


class CartService
{
    protected $sessionKey = 'cart';

    public function getAll()
    {
       // $cart = Session::get('cart', []);
       
      return Session::get($this->sessionKey,   [ ]);
        
    }

    public function add($productId, $userId, $quantity = 1)
    {
        $cart = $this->getAll();

        if (isset($cart[$productId])) {
            $cart[$productId]['quantity'] += $quantity;
        } else {
            $cart[$productId] = [
                'product_id' => $productId,
                'user_id' => $userId,
                'quantity' => $quantity,
            ];
          //  dd($cart);
        }

        Session::put($this->sessionKey, $cart);
       // dd(session('cart'));

    }

    public function update($productId, $quantity)
    {
        $cart = $this->getAll();

        if (isset($cart[$productId])) {
            if ($quantity < 1) {
                $this->remove($productId);
                return;
            }
            $cart[$productId]['quantity'] = $quantity;
            Session::put($this->sessionKey, $cart);
        }
    }

    public function remove($productId)
    {
        $cart = $this->getAll();

        if (isset($cart[$productId])) {
            unset($cart[$productId]);
            Session::put($this->sessionKey, $cart);
        }
    }

    public function clear()
    {
        Session::forget($this->sessionKey);
    }
}
