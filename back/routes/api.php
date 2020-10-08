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

Route::post('/login', '\App\Http\Controllers\AuthController@login')->name('login');

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/utilisateurs', '\App\Http\Controllers\Api\UtilisateurController@index');
    Route::get('/me', '\App\Http\Controllers\AuthController@user');
});

