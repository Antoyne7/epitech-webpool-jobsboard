<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Offre;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class OffreController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        return response(Offre::with(['entreprise', 'tags', 'typeoffres'])->get());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        if ($request['image']) {
            $filename = time() . '.' . $request['image']->getClientOriginalExtension();
        }

        if (Offre::create([
            'nom' => $request['nom'],
            'code_ville' => $request['codeVille'],
            'ville' => $request['ville'],
            'code_departement' => $request['codeDepartement'],
            'shortDescription' => $request['shortDescription'],
            'description' => $request['description'],
            'image' => $request['image']['name'],
            'entreprise' => $request['entreprise'],
            'tag' => $request['tag'],
            'offretype' => $request['offretype'],
        ])) {
            if ($request['image']) {
                $request['image']->move(public_path('images'), $filename);
            }
            return response(1);
        } else {
            return response(0);
        }

    }

    /**
     * Display the specified resource.
     *
     * @param Offre $offre
     * @return Response
     */
    public function show(Offre $offre)
    {
        return response($offre);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param Offre $offre
     * @return Response
     */
    public function update(Request $request, Offre $offre)
    {
        return response("pas fait encore");
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Offre $offre
     * @return Response
     * @throws Exception
     */
    public function destroy(Offre $offre)
    {
        return response($offre->delete());
    }
}
