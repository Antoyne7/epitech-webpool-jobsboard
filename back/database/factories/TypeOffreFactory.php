<?php

namespace Database\Factories;

use App\Models\TypeOffre;
use Illuminate\Database\Eloquent\Factories\Factory;

class TypeOffreFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = TypeOffre::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        $types = [
            'contrat apprentissage',
            'contrat professionalisation',
            'temps plein',
            'alternance',
            'CDI',
            'CDD',
            'freelance'
        ];
        return [
            'nom' => $this->faker->unique()->randomElement($types)
        ];
    }
}
