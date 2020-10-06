<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
*/
Route::apiResource('offres', \App\Http\Controllers\Api\OffreController::class);
Route::apiResource('utilisateurs', \App\Http\Controllers\Api\UtilisateurController::class);
Route::apiResource('tags', \App\Http\Controllers\Api\TagController::class);
Route::apiResource('entreprises', \App\Http\Controllers\Api\EntrepriseController::class);
Route::apiResource('typeoffres', \App\Http\Controllers\Api\TypeOffreController::class);
Route::apiResource('candidatures', \App\Http\Controllers\Api\CandidatureController::class);

Route::middleware('guest')->group(function () {
    Route::post('register', '\App\Http\Controllers\AuthController@register')->name('register');
    Route::post('login', '\App\Http\Controllers\AuthController@login')->name('login');
    Route::post('refresh-token', '\App\Http\Controllers\AuthController@refreshToken')->name('refreshToken');
});

//Route::middleware('auth:api')->group(function () {
    Route::post('logout', '\App\Http\Controllers\AuthController@logout')->name('logout');
//});
