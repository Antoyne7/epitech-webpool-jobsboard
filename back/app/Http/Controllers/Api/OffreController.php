<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Entreprise;
use App\Models\Offre;
use App\Models\Tag;
use App\Models\TypeOffre;
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
        // https://laravel.com/docs/8.x/eloquent-relationships#inserting-and-updating-related-models

        $entreprise = Entreprise::find($request->entreprise);

        $offre = new Offre();
        $offre->nom = $request['nom'];
        $offre->description = $request['description'];
        $offre->code_ville = $request['codeVille'];
        $offre->ville = $request['ville'];
        $offre->code_departement = $request['codeDepartement'];
        $offre->short_description = $request['shortDescription'];
        $offre->image = $request->file('image')->store('offreimgs');
        $offre->entreprise()->associate($entreprise);

        if ($offre->save()) {
            foreach (json_decode($request['tags']) as $tagNom) {
                $tagsTemp = Tag::where('nom', $tagNom)->get();
                if (sizeof($tagsTemp) > 0) {
                    $tag = $tagsTemp[0];
                } else {
                    $tag = Tag::create([
                        'nom' => $tagNom
                    ]);
                }
                $offre->tags()->save($tag);
            }
            foreach (json_decode($request['offretype']) as $typeOffreNom) {
                $typeOffreTemp = TypeOffre::where('nom', $typeOffreNom)->get();
                if (sizeof($typeOffreTemp) > 0) {
                    $typeOffre = $typeOffreTemp[0];
                } else {
                    $typeOffre = TypeOffre::create([
                        'nom' => $typeOffreNom
                    ]);
                }
                $offre->typeOffres()->save($typeOffre);
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
        // https://laravel.com/docs/8.x/eloquent-relationships#inserting-and-updating-related-models


        $offre->nom = $request['nom'];
        $offre->description = $request['description'];
        $offre->short_description = $request['shortDescription'];
        if ($request['codeVille']) {
            $offre->code_ville = $request['codeVille'];
            $offre->ville = $request['ville'];
            $offre->code_departement = $request['codeDepartement'];
        }
        if ($request->file('image')) {
            $offre->image = $request->file('image')->store('offreimgs');
        }

        $entreprise = Entreprise::find($request->entreprise);
        $offre->entreprise()->associate($entreprise);
        if ($offre->save()) {
            foreach (json_decode($request['tags']) as $tagNom) {
                $tagsTemp = Tag::where('nom', $tagNom)->get();
                if (sizeof($tagsTemp) > 0) {
                    $tag = $tagsTemp[0];
                } else {
                    $tag = Tag::create([
                        'nom' => $tagNom
                    ]);
                }
                $offre->tags()->save($tag);
            }
            foreach (json_decode($request['offretype']) as $typeOffreNom) {
                $typeOffreTemp = TypeOffre::where('nom', $typeOffreNom)->get();
                if (sizeof($typeOffreTemp) > 0) {
                    $typeOffre = $typeOffreTemp[0];
                } else {
                    $typeOffre = TypeOffre::create([
                        'nom' => $typeOffreNom
                    ]);
                }
                $offre->typeOffres()->save($typeOffre);
            }
            return response(1);
        } else {
            return response(0);
        }
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

    /**
     * Toggle pourvu on offer.
     *
     * @param Offre $offre
     * @return Response
     * @throws Exception
     */
    public function toggle(Offre $offre)
    {
        $offre->pourvu = !$offre->pourvu;
        return response($offre->save());
    }
}
