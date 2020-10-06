<?php

namespace Database\Factories;

use App\Models\Offre;
use Illuminate\Database\Eloquent\Factories\Factory;

class OffreFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Offre::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'nom' => $this->faker->sentence(3),
            'code_departement' => 67,
            'code_ville' => $this->faker->numberBetween(67000,67500),
            'short_description' => $this->faker->text(),
            'description' => $this->faker->realText(600),
            'image' => $this->faker->imageUrl(),
            'entreprise_id' => $this->faker->numberBetween(1,10)
        ];
    }
}
