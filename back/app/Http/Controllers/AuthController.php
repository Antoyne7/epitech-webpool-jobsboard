<?php

namespace App\Http\Controllers;

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

    }

    public function login()
    {

    }

    public function refreshToken()
    {

    }

    public function logout()
    {

    }
}
