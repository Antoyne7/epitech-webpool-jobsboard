<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Tag;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class TagController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return Response
     */
    public function index()
    {
        return response(Tag::all());
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        return Tag::create([
           'nom' => $request['nom']
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  Tag  $tag
     * @return Response
     */
    public function show($tag)
    {
        return response($tag);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param Request $request
     * @param  Tag  $tag
     * @return Response
     */
    public function update(Request $request, Tag $tag)
    {
        return response($tag->update([
            'nom' => $request['nom']
        ]));
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param Tag $tag
     * @return void
     * @throws Exception
     */
    public function destroy(Tag $tag)
    {
        $tag->delete();
    }
}
