<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Offre extends Model
{
    use HasFactory;

    protected $hidden = ['updated_at'];
    protected $fillable = [
        'nom',
        'code_ville',
        'ville',
        'code_departement',
        'short_description',
        'description',
        'entreprise',
        'tag',
        'offretype',
        'created_at'
    ];

    public function tags()
    {
        return $this->belongsToMany(Tag::class);
    }

    public function typeOffres()
    {
        return $this->belongsToMany(TypeOffre::class);
    }

    public function candidatures()
    {
        return $this->hasMany(Candidature::class);
    }

    public function entreprise()
    {
        return $this->belongsTo(Entreprise::class);
    }
}
