<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\Orders;  
use App\Models\Product;
class Item_oder extends Model
{
    use HasFactory;
protected $fillable = ['order_id', 'product_id', 'quantity', 'price'];


     public function orders(): BelongsTo
    {
        return $this->belongsTo(Orders::class , 'order_id');
    }

    // Product
    public function product(): BelongsTo
    {
        return $this->belongsTo(Product::class , 'product_id');
    }
}
