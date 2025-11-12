<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\RekamMedis;
use App\Models\Pasien;
use App\Models\Dokter;

class RekamMedisSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Ensure at least one patient and one doctor exist
        $pasien = Pasien::first();
        if (!$pasien) {
            $pasien = Pasien::factory()->create();
        }

        $dokter = Dokter::first();
        if (!$dokter) {
            $dokter = Dokter::factory()->create();
        }

        // Create a medical record
        RekamMedis::firstOrCreate(
            [
                'id_pasien' => $pasien->id_pasien,
                'id_dokter' => $dokter->id_dokter,
                'tanggal_kunjungan' => '2025-11-10',
            ],
            [
                'diagnosis' => 'Demam dan sakit kepala',
                'tindakan' => 'Pemberian obat penurun panas',
                'catatan' => 'Pasien disarankan istirahat cukup.',
            ]
        );

        RekamMedis::firstOrCreate(
            [
                'id_pasien' => $pasien->id_pasien,
                'id_dokter' => $dokter->id_dokter,
                'tanggal_kunjungan' => '2025-11-11',
            ],
            [
                'diagnosis' => 'Batuk kering',
                'tindakan' => 'Pemberian obat batuk',
                'catatan' => 'Hindari minuman dingin.',
            ]
        );
    }
}