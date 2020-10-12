<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Candidature;
use Illuminate\Http\Request;

class CandidatureController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return response(Candidature::with('offre.entreprise')->get());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     */
    public function store(Request $request)
    {
        try {
            $request->validate([
                'idUser' => 'integer|required',
                'idOffre' => 'integer|required',
                'text' => 'required|min:6',
            ]);
        } catch (\Exception $err) {
            return response()->json([
                'status_code' => 422,
                'error_code' => 11,
                'error' => $err,
                'message' => "Aucun texte n'a été envoyé",
            ]);
        }

        if ($request->file('cv')) {
            $resultCv = $request->file('cv')->store('fileUser');
        } else if (strlen($request['cv']) > 5) {
            $resultCv = $request['cv'];
        } else {
            return response()->json([
                'status_code' => 422,
                'error_code' => 12,
                'message' => "Aucun CV n'a été envoyé",
            ]);
        }

        Candidature::create([
            'text' => $request['text'],
            'cv' => $resultCv,
            'offre_id' => $request['idOffre'],
            'utilisateur_id' => $request['idUser'],
            'useprofilecv' => 1,
        ]);

        return response([
            'statusCode' => 200,
            'message' => 'Candidature crée',
        ], 201);
    }

    /**
     * Display the specified resource.
     *
     * @param Candidature $candidature
     * @return \Illuminate\Http\Response
     */
    public function show(Candidature $candidature)
    {
        return response($candidature);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
