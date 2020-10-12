<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Candidature extends Model
{
    use HasFactory;

    protected $fillable = [
        'text', 'utilisateur_id', 'cv', 'offre_id','useprofilecv'
    ];

    public function offre()
    {
        return $this->belongsTo(Offre::class);
    }

    public function utilisateur()
    {
        return $this->belongsTo(Utilisateur::class);
    }
}
