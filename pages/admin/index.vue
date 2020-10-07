<template>
  <div>
    <b-container>
      liste des differentes offres avec bouton d'édition (bouton pour dire que l'offre est pourvu ?)
      <div>
        bouton pour creer une nouvelle offre
      </div>
      sidebar pour voir les dernieres candidatures ?
      navigation a gauche avec candidatures ajout d'offre gestion des tags et gestion type offre ?
    </b-container>
    <SearchBar/>
    <b-container>
      <b-row>
        <b-button :to="{ name: 'admin-offre-add' }" block variant="primary" size="lg">
          Ajouter une nvl offre
        </b-button>
        <b-button :to="{ name: 'admin-offretypes' }" block variant="primary" size="lg">
          Gestion types de contrats
        </b-button>
      </b-row>
    </b-container>
    <b-container class="container-cards">
      <b-row>
        <JobCard v-for="offre in listeOffres" :title="offre.nom"
                 :short-description="offre.short_description"
                 :linkId="offre.id"
                 :img="offre.image"
                 :localisation="offre.localisation"
        />
      </b-row>
    </b-container>
  </div>
</template>

<script>
import JobCard from "@/components/JobCard"
import SearchBar from "@/components/SearchBar"
import AjaxServices from "@/services/ajaxServices";

export default {
  name: "Index",
  components: {
    JobCard,
    SearchBar
  },
  data() {
    return {
      listeOffres: [],
    }
  },
  created() {
    AjaxServices.getListe('listeOffres').then(promise => {
      console.log(promise)
      this.listeOffres = promise;
    })
  }
}
</script>

<style scoped>

</style>
