<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Obat;

class ObatSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Obat::firstOrCreate(
            ['nama_obat' => 'Paracetamol 500mg'],
            [
                'kategori' => 'Analgesik',
                'harga' => 5000.00,
                'stok' => 100,
            ]
        );

        Obat::firstOrCreate(
            ['nama_obat' => 'Amoxicillin 500mg'],
            [
                'kategori' => 'Antibiotik',
                'harga' => 15000.00,
                'stok' => 50,
            ]
        );

        Obat::firstOrCreate(
            ['nama_obat' => 'Loratadine 10mg'],
            [
                'kategori' => 'Antihistamin',
                'harga' => 8000.00,
                'stok' => 75,
            ]
        );
    }
}