<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Utilisateur;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use League\CommonMark\Block\Element\Document;

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
     */
    public function update(Request $request, Utilisateur $utilisateur)
    {
        try {

//            On vérifie ici si l'addresse mail est valide et unique
            try {
                $request->validate([
                    'email' => 'email|unique:utilisateurs,email,' . $request['id']
                ]);
            } catch (\Exception $err) {
                return response()->json([
                    'status_code' => 422,
                    'error_code' => 11,
                    'message' => "L'adresse mail saisie est déjà utilisée",
                ]);
            }


//           Navré pour tous ces if imbriqués mais je savais pas comment faire autrement
//            Update: J'ai trouvé comment faire mais franchement j'ai la flemme de mettre à jour

//            On test d'abord si un mot de passe est présent dans la reqûete
            if (isset($request['password']) && $request['password'] !== "" && $request['password'] !== 'null' && $request['password'] !== null) {
//                On vérifie si le mdp est assez long
                if (strlen($request['password']) > 5) {
//                    Puis on vérifie si l'utilisateur upload un CV ou une photo ou les deux
                    if ($request->file('image') && $request->file('cv')) {
                        $resultImg = $request->file('image')->store('imgUser');
                        $resultCv = $request->file('cv')->store('fileUser');
                        return response($utilisateur->update([
                            'nom' => $request['nom'],
                            'prenom' => $request['prenom'],
                            'email' => $request['email'],
                            'cv' => $resultCv,
                            'image' => $resultImg,
                            'password' => Hash::make($request['password']),
                        ]));
                    } else if ($request->file('cv')) {
                        $resultCv = $request->file('cv')->store('fileUser');
                        return response($utilisateur->update([
                            'nom' => $request['nom'],
                            'prenom' => $request['prenom'],
                            'email' => $request['email'],
                            'cv' => $resultCv,
                            'password' => Hash::make($request['password'])
                        ]));
                    } else if ($request->file('image')) {
                        $resultImg = $request->file('image')->store('imgUser');
                        return response($utilisateur->update([
                            'nom' => $request['nom'],
                            'prenom' => $request['prenom'],
                            'email' => $request['email'],
                            'image' => $resultImg,
                            'password' => Hash::make($request['password']),
                        ]));
                    } else {
                        return response($utilisateur->update([
                            'nom' => $request['nom'],
                            'prenom' => $request['prenom'],
                            'email' => $request['email'],
                            'password' => Hash::make($request['password']),
                        ]));
                    }
                } else {
                    return response()->json([
                        'status_code' => 422,
                        'error_code' => 10,
                        'message' => 'Le mot de passe rentré est trop court',
                    ]);
                }
            } else if ($request->file('cv') && $request->file('image')) {
                $resultImg = $request->file('image')->store('imgUser');
                $resultCv = $request->file('cv')->store('fileUser');
                return response($utilisateur->update([
                    'nom' => $request['nom'],
                    'prenom' => $request['prenom'],
                    'email' => $request['email'],
                    'cv' => $resultCv,
                    'image' => $resultImg
                ]));
            } else if ($request->file('cv')) {
                $resultCv = $request->file('cv')->store('fileUser');
                return response($utilisateur->update([
                    'nom' => $request['nom'],
                    'prenom' => $request['prenom'],
                    'email' => $request['email'],
                    'cv' => $resultCv,
                ]));
            } else if ($request->file('image')) {
                $resultImg = $request->file('image')->store('imgUser');
                return response($utilisateur->update([
                    'nom' => $request['nom'],
                    'prenom' => $request['prenom'],
                    'email' => $request['email'],
                    'image' => $resultImg,
                ]));
            } else {
                return response($utilisateur->update([
                    'nom' => $request['nom'],
                    'prenom' => $request['prenom'],
                    'email' => $request['email'],
                ]));
            }
        } catch (\Exception $error) {
            return response()->json([
                'status_code' => 500,
                'message' => 'Error in modification',
                'error' => $error,
            ]);
        }
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
