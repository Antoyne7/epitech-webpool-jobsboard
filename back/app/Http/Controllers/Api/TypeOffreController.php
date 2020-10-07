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
        return TypeOffre::create([
            'nom' => $request['nom']
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  TypeOffre $typeOffre
     * @return Response
     */
    public function show(TypeOffre $typeOffre)
    {
        return response($typeOffre);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param  TypeOffre $typeOffre
     * @return Response
     */
    public function update(Request $request, TypeOffre $typeOffre)
    {
        return response($typeOffre->update([
            'nom' => $request['nom']
        ]));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param TypeOffre $typeOffre
     * @return Response
     * @throws Exception
     */
    public function destroy(TypeOffre $typeOffre)
    {
        return response($typeOffre->delete());
    }
}
