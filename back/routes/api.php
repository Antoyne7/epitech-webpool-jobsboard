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
|
*/

//Route::middleware('auth:api')->get('/user', function (Request $request) {
//    return $request->user();
//});

//Route::get('contact', [ContactsController::class, 'create'])->name('contact.create');
//Route::post('contact', [ContactsController::class, 'store'])->name('contact.store');

Route::apiResource('offres', \App\Http\Controllers\Api\OffreController::class);
Route::apiResource('utilisateurs', \App\Http\Controllers\Api\UtilisateurController::class);
Route::apiResource('tags', \App\Http\Controllers\Api\TagController::class);
Route::apiResource('entreprises', \App\Http\Controllers\Api\EntrepriseController::class);
Route::apiResource('typeoffres', \App\Http\Controllers\Api\TypeOffreController::class);
Route::apiResource('candidatures', \App\Http\Controllers\Api\CandidatureController::class);
