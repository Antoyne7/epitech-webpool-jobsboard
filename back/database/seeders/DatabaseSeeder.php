<?php

namespace Database\Seeders;

use App\Models\Candidature;
use App\Models\Entreprise;
use App\Models\Offre;
use App\Models\Tag;
use App\Models\TypeOffre;
use App\Models\Utilisateur;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        Entreprise::factory(10)->create();
        Utilisateur::factory(15)->create();
        Tag::factory(6)->create();
        TypeOffre::factory(7)->create();
        Offre::factory()->count(10)->create()->each(function ($offre) {
            $ids = range(1, 6);
            shuffle($ids);
            $offre->tags()->attach(array_slice($ids, 0, rand(1, 4)));
            shuffle($ids);
            $offre->typeOffres()->attach(array_slice($ids, 0, rand(1, 4)));
        });
        Candidature::factory()
            ->has(
                Offre::factory()->count(1)
            )
            ->has(
                Utilisateur::factory()->count(1)
            )
            ->count(25)
            ->create();
    }
}
