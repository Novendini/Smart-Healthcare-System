<?php

namespace Database\Factories;

use App\Models\RekamMedis;
use App\Models\Pasien;
use App\Models\Dokter;
use Illuminate\Database\Eloquent\Factories\Factory;

class RekamMedisFactory extends Factory
{
    protected $model = RekamMedis::class;

    public function definition()
    {
        return [
            'id_pasien' => Pasien::factory(),
            'id_dokter' => Dokter::factory(),
            'id_janji_temu' => null,
            'tanggal_kunjungan' => $this->faker->date(),
            'diagnosis' => $this->faker->sentence(),
            'tindakan' => $this->faker->sentence(),
            'catatan' => $this->faker->paragraph(),
        ];
    }
}