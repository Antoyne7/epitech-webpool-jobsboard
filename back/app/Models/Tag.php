<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tag extends Model
{
    use HasFactory;

    protected $hidden = [
        'created_at'
    ];

    protected $visible = ['id', 'nom'];

    public function offres()
    {
        return $this->belongsToMany(Offre::class);
    }
}
