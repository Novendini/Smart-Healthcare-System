<?php

namespace Database\Factories;

use App\Models\Obat;
use Illuminate\Database\Eloquent\Factories\Factory;

class ObatFactory extends Factory
{
    protected $model = Obat::class;

    public function definition()
    {
        return [
            'nama_obat' => $this->faker->word,
            'kategori' => $this->faker->word,
            'harga' => $this->faker->randomFloat(2, 10000, 100000),
            'stok' => $this->faker->numberBetween(10, 100),
        ];
    }
}