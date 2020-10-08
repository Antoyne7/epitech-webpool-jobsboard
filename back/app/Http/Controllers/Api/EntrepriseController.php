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
        return Entreprise::create([
            'nom' => $request['nom']
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
        $data = json_decode($request->getContent());
        return response($entreprise->update([
            'nom' => $data->nom
        ]));
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
