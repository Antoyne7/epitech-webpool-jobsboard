<?php

namespace App\Http\Controllers;

use App\Models\Utilisateur;
use Illuminate\Http\Request;
use App\Utilities\ProxyRequest;

class AuthController extends Controller
{
    //
    protected $proxy;

    public function __construct(ProxyRequest $proxy)
    {
        $this->proxy = $proxy;
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

        $resp = $this->proxy->grantPasswordToken(
            $user->email,
            request('password')
        );

        return response([
            'token' => $resp->access_token,
            'expiresIn' => $resp->expires_in,
            'statusCode' => 200,
            'message' => 'Your account has been created',
        ], 201);

    }


    public function login()
    {
        $user = Utilisateur::where('email', request('email'))->first();

        abort_unless($user, 404, 'This combination does not exists.');
        abort_unless(
            \Hash::check(request('password'), $user->password),
            403,
            'This combination does not exists.'
        );

        $resp = $this->proxy
            ->grantPasswordToken(request('email'), request('password'));

        return response([
            'token' => $resp->access_token,
            'expiresIn' => $resp->expires_in,
            'message' => 'You have been logged in',
        ], 200);
    }

    public function refreshToken()
    {
        $resp = $this->proxy->refreshAccessToken();

        return response([
            'token' => $resp->access_token,
            'expiresIn' => $resp->expires_in,
            'message' => 'Token has been refreshed.',
        ], 200);
    }

    public function logout()
    {

        $token = request()->user()->token();
        $token->delete();

        cookie()->queue(cookie()->forget('refresh_token'));

        return response([
            'message' => 'You have been successfully logged out',
        ], 200);
    }
}
