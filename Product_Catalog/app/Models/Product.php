<?php

namespace App\Models;
use App\Models\Orders;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use App\Models\Item_oder;
class Product extends Model
{
    use HasFactory;
        protected $fillable = [
        'name', 'description', 'price', 'stock', 'photo',
    ];

     public function item_oder(): HasMany
    {
        return $this->hasMany(Item_oder::class);
    }


    




}
