<?php

namespace App\Http\Controllers;

use App\Models\Resep;
use Illuminate\Http\Request;

/**
 * @OA\Tag(
 *     name="Resep",
 *     description="API untuk mengelola resep"
 * )
 */
class ResepController extends Controller
{
    /**
     * @OA\Get(
     *     path="/api/resep",
     *     tags={"Resep"},
     *     summary="Get all resep",
     *     description="Ambil semua resep dengan filter opsional",
     *     @OA\Parameter(
     *         name="status",
     *         in="query",
     *         description="Filter berdasarkan status resep (contoh: pending, proses, selesai)",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         name="tanggal",
     *         in="query",
     *         description="Filter berdasarkan tanggal resep (format: YYYY-MM-DD)",
     *         required=false,
     *         @OA\Schema(type="string", format="date")
     *     ),
     *     @OA\Response(response=200, description="Success")
     * )
     */
    public function index(Request $request)
    {
        $query = Resep::query();

        if ($request->has('status')) {
            $query->where('status', $request->status);
        }

        if ($request->has('tanggal')) {
            $query->whereDate('tanggal_resep', $request->tanggal);
        }

        return $query->get();
    }

    /**
     * @OA\Post(
     *     path="/api/resep",
     *     tags={"Resep"},
     *     summary="Create new resep",
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="id_rekam_medis", type="integer"),
     *             @OA\Property(property="tanggal_resep", type="string", format="date"),
     *             @OA\Property(property="status", type="string")
     *         )
     *     ),
     *     @OA\Response(response=201, description="Created")
     * )
     */
    public function store(Request $request)
    {
        $resep = Resep::create($request->all());
        return response()->json($resep, 201);
    }

    /**
     * @OA\Get(
     *     path="/api/resep/{id}",
     *     tags={"Resep"},
     *     summary="Get resep by ID",
     *     @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")),
     *     @OA\Response(response=200, description="Success")
     * )
     */
    public function show($id)
    {
        return Resep::findOrFail($id);
    }

    /**
     * @OA\Put(
     *     path="/api/resep/{id}",
     *     tags={"Resep"},
     *     summary="Update resep",
     *     @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")),
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string")
     *         )
     *     ),
     *     @OA\Response(response=200, description="Updated")
     * )
     */
    public function update(Request $request, $id)
    {
        $resep = Resep::findOrFail($id);
        $resep->update($request->all());
        return response()->json($resep);
    }

    /**
     * @OA\Delete(
     *     path="/api/resep/{id}",
     *     tags={"Resep"},
     *     summary="Delete resep",
     *     @OA\Parameter(name="id", in="path", required=true, @OA\Schema(type="integer")),
     *     @OA\Response(response=200, description="Deleted")
     * )
     */
    public function destroy($id)
    {
        Resep::destroy($id);
        return response()->json(['message' => 'Resep deleted']);
    }
}
