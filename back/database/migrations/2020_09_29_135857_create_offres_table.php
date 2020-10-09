<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOffresTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::disableForeignKeyConstraints();
        Schema::create('offres', function (Blueprint $table) {
            $table->id();
            $table->string('nom');
            $table->integer('code_ville')->nullable();
            $table->string('ville')->nullable();
            $table->integer('code_departement')->nullable();
            $table->text('short_description')->nullable();
            $table->longText('description')->nullable();
            $table->string('image')->nullable();
            $table->timestamps();
            $table->unsignedBigInteger('entreprise_id');
            $table->foreign('entreprise_id')
                ->references('id')
                ->on('entreprises')
                ->onDelete('restrict')
                ->onUpdate('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('offres');
    }
}
