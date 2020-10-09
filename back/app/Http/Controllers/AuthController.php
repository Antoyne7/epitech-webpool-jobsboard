<?php

namespace App\Http\Controllers;

use App\Models\Utilisateur;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        try {
            $request->validate([
                'email' => 'email|required',
                'password' => 'required'
            ]);
            $credentials = request(['email', 'password']);
            if (!Auth::attempt($credentials)) {
                return response()->json([
                    'status_code' => 500,
                    'message' => 'Unauthorized'
                ]);
            }
            $user = Utilisateur::where('email', $request->email)->first();
            if (!Hash::check($request->password, $user->password, [])) {
                throw new \Exception('Error in Login');
            }
            $tokenResult = $user->createToken('authToken')->plainTextToken;
//            return response()->json([
//                'status_code' => 200,
//                'access_token' => $tokenResult,
//                'token_type' => 'Bearer',
//            ]);
            return $tokenResult;
        } catch (\Exception $error) {
            return response()->json([
                'status_code' => 500,
                'message' => 'Error in Login',
                'error' => $error,
            ]);
        }
    }

    public function user (Request $request) {
        return $request->user();
    }

    public function logout (Request $request) {
//        return $request->user()->currentAccessToken()->delete();
        return $request->getContent();
    }

    public function register()
    {
        $this->validate(request(), [
            'nom' => 'required',
            'prenom' => 'required',
            'email' => 'required|email|unique:utilisateurs',
            'password' => 'required',
        ]);

        $user = Utilisateur::create([
            'nom' => request('nom'),
            'prenom' => request('prenom'),
            'email' => request('email'),
            'password' => bcrypt(request('password')),
        ]);

        return response([
            'statusCode' => 200,
            'message' => 'Your account has been created',
        ], 201);

    }

    // // Revoke all tokens...
    //$user->tokens()->delete();
    //
    //// Revoke the user's current token...
    //$request->user()->currentAccessToken()->delete();
    //
    //// Revoke a specific token...
    //$user->tokens()->where('id', $id)->delete();
}
