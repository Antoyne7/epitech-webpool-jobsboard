<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Entreprise;

use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class EntrepriseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        return response(Entreprise::all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {

        try {
            $request->validate([
                'nom' => 'required|unique:entreprises|max:128,nom,' . $request['id']
            ]);
        } catch (\Exception $exception) {
            return response([
                'status_code' => 422,
                'error_code' => 1,
                'error' => $exception,
                'message' => "Ce nom est déjà utilisé pour une autre entreprise.",
            ]);
        }

        try {
            Entreprise::create([
                'nom' => $request['nom']
            ]);
        } catch (\Exception $exception) {
            return response([
                'status_code' => 500,
                'error_code' => 2,
                'error' => $exception,
                'message' => "Une erreur s'est produite.",
            ]);
        }
        return response([
            'status_code' => 200,
            'message' => "Créée.",
        ]);
    }

    /**
     * Display the specified resource.
     *

     * @param Entreprise  $entreprise
     * @return Response
     */
    public function show(Entreprise $entreprise)
    {
        return response($entreprise);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param Entreprise $entreprise
     * @return Response
     */
    public function update(Request $request, Entreprise $entreprise)
    {
        try {
            $request->validate([
                'nom' => 'required|unique:entreprises|max:128,nom,' . $request['id']
            ]);
        } catch (\Exception $exception) {
            return response([
                'status_code' => 422,
                'error_code' => 1,
                'error' => $exception,
                'message' => "Le nom est déjà utilisé pour une autre entreprise.",
            ]);
        }
        $data = json_decode($request->getContent());

        try {
            $entreprise->update([
                'nom' => $data->nom
            ]);
        } catch (\Exception $exception) {
            return response([
                'status_code' => 500,
                'error_code' => 2,
                'error' => $exception,
                'message' => "Impossible d'appliquer les modifications.",
            ]);
        }

        return response([
            'status_code' => 200,
            'message' => "Modifié.",
        ]);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Entreprise $entreprise
     * @return Response
     * @throws Exception
     */
    public function destroy(Entreprise $entreprise)
    {
        return response($entreprise->delete());
    }
}
