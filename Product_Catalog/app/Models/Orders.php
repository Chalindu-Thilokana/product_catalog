<?php

namespace App\Models;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Orders extends Model
{
    use HasFactory;
      protected $fillable = [
        'user_id', 'total',
    ];


    public function user()
    {
        return $this->belongsTo(User::class , 'user_id');
    }


    public function item_oder()
    {
        return $this->hasMany(Item_oder::class, 'order_id');
    }

  
}


    
