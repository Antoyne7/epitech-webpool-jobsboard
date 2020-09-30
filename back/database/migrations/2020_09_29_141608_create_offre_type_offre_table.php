<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateOffreTypeOffreTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('offre_type_offre', function (Blueprint $table) {
            $table->id();
            $table->timestamps();
            $table->unsignedBigInteger('offre_id');
            $table->foreign('offre_id')
                ->references('id')
                ->on('offres')
                ->onDelete('cascade')
                ->onUpdate('restrict');
            $table->unsignedBigInteger('type_offre_id');
            $table->foreign('type_offre_id')
                ->references('id')
                ->on('type_offres')
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
        Schema::dropIfExists('offre_type_offre');
    }
}
