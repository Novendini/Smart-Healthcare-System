<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\Pengguna;
use App\Models\Pasien;
use App\Models\Dokter;
use App\Models\RekamMedis;
use App\Models\Obat;
use App\Models\Resep;

class ResepApiTest extends TestCase
{
    use RefreshDatabase;

    protected $pasienUser;
    protected $dokter;
    protected $pasien;
    protected $obat;
    protected $rekamMedis;
    protected $resep;

    protected function setUp(): void
    {
        parent::setUp();

        // Create a user with the 'pasien' role and authenticate
        $this->pasienUser = Pengguna::factory()->create(['role' => 'pasien']);
        $this->pasien = Pasien::factory()->create(['id_pengguna' => $this->pasienUser->id_pengguna]);

        // Create a doctor
        $penggunaDokter = Pengguna::factory()->create(['role' => 'dokter']);
        $this->dokter = Dokter::factory()->create(['id_pengguna' => $penggunaDokter->id_pengguna]);

        // Create a medicine
        $this->obat = Obat::factory()->create();

        // Create a medical record
        $this->rekamMedis = RekamMedis::factory()->create([
            'id_pasien' => $this->pasien->id_pasien,
            'id_dokter' => $this->dokter->id_dokter,
        ]);

        // Create a prescription to be used in tests
        $this->resep = Resep::create([
            'id_rekam_medis' => $this->rekamMedis->id_rekam_medis,
            'tanggal_resep' => now()->toDateString(),
            'status' => 'menunggu',
        ]);

        $this->resep->obat()->attach($this->obat->id_obat, [
            'jumlah' => 10,
            'dosis' => '3x1',
            'instruksi' => 'Setelah makan'
        ]);

        $this->actingAs($this->pasienUser, 'sanctum');
    }

    /** @test */
    public function it_can_get_all_resep()
    {
        $response = $this->getJson('/api/resep');

        $response->assertStatus(200)
            ->assertJsonStructure([
                '*' => [
                    'id_resep',
                    'status',
                    'rekam_medis' => [
                        'pasien' => ['pengguna' => ['nama_lengkap']],
                        'dokter' => ['pengguna' => ['nama_lengkap']],
                    ],
                    'obat' => [
                        '*' => ['nama_obat', 'pivot']
                    ]
                ]
            ])
            ->assertJsonFragment(['id_resep' => $this->resep->id_resep]);
    }

    /** @test */
    public function it_can_create_a_new_resep()
    {
        $obat2 = Obat::factory()->create();
        $payload = [
            'id_rekam_medis' => $this->rekamMedis->id_rekam_medis,
            'tanggal_resep' => '2025-11-13',
            'status' => 'menunggu',
            'details' => [
                [
                    'id_obat' => $this->obat->id_obat,
                    'jumlah' => 15,
                    'dosis' => '2x1',
                    'instruksi' => 'Pagi dan malam',
                ],
                [
                    'id_obat' => $obat2->id_obat,
                    'jumlah' => 5,
                    'dosis' => '1x1',
                    'instruksi' => 'Jika perlu',
                ]
            ]
        ];

        $response = $this->postJson('/api/resep', $payload);

        $response->assertStatus(201)
            ->assertJsonFragment(['tanggal_resep' => '2025-11-13T00:00:00.000000Z']);

        $this->assertDatabaseHas('resep', ['id_rekam_medis' => $this->rekamMedis->id_rekam_medis]);
        $this->assertDatabaseHas('detail_resep', ['id_obat' => $this->obat->id_obat, 'jumlah' => 15]);
        $this->assertDatabaseHas('detail_resep', ['id_obat' => $obat2->id_obat, 'jumlah' => 5]);
    }

    /** @test */
    public function it_fails_to_create_resep_with_invalid_data()
    {
        $payload = [
            'id_rekam_medis' => 999, // Non-existent
            'details' => [], // Empty details
        ];

        $response = $this->postJson('/api/resep', $payload);

        $response->assertStatus(422)
            ->assertJsonValidationErrors(['id_rekam_medis', 'tanggal_resep', 'status', 'details']);
    }

    /** @test */
    public function it_can_get_a_single_resep()
    {
        $response = $this->getJson('/api/resep/' . $this->resep->id_resep);

        $response->assertStatus(200)
            ->assertJsonFragment(['id_resep' => $this->resep->id_resep])
            ->assertJsonFragment(['nama_obat' => $this->obat->nama_obat]);
    }

    /** @test */
    public function it_can_update_a_resep()
    {
        $obatBaru = Obat::factory()->create();
        $payload = [
            'id_rekam_medis' => $this->rekamMedis->id_rekam_medis,
            'tanggal_resep' => $this->resep->tanggal_resep->format('Y-m-d'),
            'status' => 'diserahkan',
            'details' => [
                [
                    'id_obat' => $obatBaru->id_obat,
                    'jumlah' => 20,
                    'dosis' => '4x1',
                    'instruksi' => 'Terbaru',
                ]
            ]
        ];

        $response = $this->putJson('/api/resep/' . $this->resep->id_resep, $payload);

        $response->assertStatus(200)
            ->assertJsonFragment(['status' => 'diserahkan']);

        $this->assertDatabaseHas('resep', ['id_resep' => $this->resep->id_resep, 'status' => 'diserahkan']);
        $this->assertDatabaseMissing('detail_resep', ['id_resep' => $this->resep->id_resep, 'id_obat' => $this->obat->id_obat]);
        $this->assertDatabaseHas('detail_resep', ['id_resep' => $this->resep->id_resep, 'id_obat' => $obatBaru->id_obat, 'jumlah' => 20]);
    }

    /** @test */
    public function it_can_delete_a_resep()
    {
        $response = $this->deleteJson('/api/resep/' . $this->resep->id_resep);

        $response->assertStatus(200)
            ->assertJson(['message' => 'Resep berhasil dihapus']);

        $this->assertSoftDeleted('resep', ['id_resep' => $this->resep->id_resep]);
    }
}
