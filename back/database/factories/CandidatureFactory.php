<?php

namespace Database\Factories;

use App\Models\Candidature;
use Illuminate\Database\Eloquent\Factories\Factory;

class CandidatureFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = Candidature::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'useprofilecv' => $this->faker->boolean,
            'cv' => $this->faker->url,
            'text' => $this->faker->text(),
            'utilisateur_id' => $this->faker->numberBetween(1,15),
            'offre_id' => $this->faker->numberBetween(1,10)
        ];
    }
}
