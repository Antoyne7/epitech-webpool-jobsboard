<template>
  <div>
    <SearchBar/>
    <b-container>
      <b-row>
        <b-button :to="{ name: 'admin-offre-add' }" block variant="primary" size="lg">
          Ajouter une nvl offre
        </b-button>
        <b-button :to="{ name: 'admin-offretype' }" block variant="primary" size="lg">
          Gestion types de contrats
        </b-button>
        <b-button :to="{ name: 'admin-entreprise' }" block variant="primary" size="lg">
          Gestion des entreprises
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
                 admin-view="true"
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
    this.$axios.$get('/back/api/offres').then(promise => {
      console.log(promise)
      this.listeOffres = promise;
    })
  }
}
</script>

<style scoped>

</style>
