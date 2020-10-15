<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\TypeOffre;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class TypeOffreController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        return response(TypeOffre::all());
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
                'nom' => 'required|unique:type_offres|max:128,nom,' . $request['id']
            ]);
        } catch (\Exception $exception) {
            return response([
                'status_code' => 422,
                'error_code' => 1,
                'error' => $exception,
                'message' => "Ce nom est déjà utilisé pour un autre type d'offre.",
            ]);
        }

        try {
            return TypeOffre::create([
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
            'message' => "Créer.",
        ]);

        
    }

    /**
     * Display the specified resource.
     *
     * @param TypeOffre $typeoffre
     * @return Response
     */
    public function show(TypeOffre $typeoffre)
    {
        return response($typeoffre);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param TypeOffre $typeoffre
     * @return Response
     */
    public function update(Request $request, TypeOffre $typeoffre)
    {
        try {
            $request->validate([
                'nom' => 'required|unique:type_offres|max:128,nom,' . $request['id']
            ]);
        } catch (\Exception $exception) {
            return response([
                'status_code' => 422,
                'error_code' => 1,
                'error' => $exception,
                'message' => "Le nom est déjà utilisé pour un autre type d'offre.",
            ]);
        }

        $data = json_decode($request->getContent());

        try {
            $typeoffre->update([
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
     * @param TypeOffre $typeoffre
     * @return Response
     * @throws Exception
     */
    public function destroy(TypeOffre $typeoffre)
    {
        return response($typeoffre->delete());
    }
}
