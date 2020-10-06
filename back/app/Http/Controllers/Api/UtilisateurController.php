<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Utilisateur;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;

class UtilisateurController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        return response(Utilisateur::all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        if (Utilisateur::create
        ([
            'nom' => $request['nom'],
            'prenom' => $request['prenom'],
            'email' => $request['email'],
            'password' => Hash::make($request['password']),
            'image' => 'imageURL',
            'cv' => 'cvURL'
        ])
        ) {
            return response()->json([
                'success' => '1'
            ]);
        } else {
            return response()->json([
                'success' => '-1'
            ]);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param Utilisateur $utilisateur
     * @return Response
     */
    public function show(Utilisateur $utilisateur)
    {
        return response($utilisateur);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param Utilisateur $utilisateur
     * @return Response
     */
    public function update(Request $request, Utilisateur $utilisateur)
    {
        return response($utilisateur->update([
            'nom' => $request['nom'],
            'prenom' => $request['prenom'],
            'email' => $request['email'],
            'password' => Hash::make($request['password']),
        ]));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Utilisateur $utilisateur
     * @return Response
     * @throws Exception
     */
    public function destroy(Utilisateur $utilisateur)
    {
        return response($utilisateur->delete());
    }
}
