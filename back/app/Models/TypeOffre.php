<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TypeOffre extends Model
{
    use HasFactory;

    protected $visible = ['id', 'nom'];


    protected $fillable = [
        'nom'
    ];

    public function offres()
    {
        return $this->belongsToMany(Offre::class);
    }
}
