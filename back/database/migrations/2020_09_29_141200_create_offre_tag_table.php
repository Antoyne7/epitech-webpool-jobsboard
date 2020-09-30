<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOffreTagTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('offre_tag', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->unsignedBigInteger('offre_id');
            $table->foreign('offre_id')
                ->references('id')
                ->on('offres')
                ->onDelete('cascade')
                ->onUpdate('restrict');
            $table->unsignedBigInteger('tag_id');
            $table->foreign('tag_id')
                ->references('id')
                ->on('tags')
                ->onDelete('cascade')
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
        Schema::dropIfExists('offre_tag');
    }
}
