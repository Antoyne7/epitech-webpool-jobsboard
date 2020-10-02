<template>
  <div>
    <SearchBar/>
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
import SearchBar from "~/components/SearchBar";
import JobCard from "~/components/JobCard";
import AjaxServices from "~/services/ajaxServices"

export default {
  components: {JobCard, SearchBar},
  data() {
    return {
      listeOffres: null,
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
<style scoped lang="scss">
.container-cards {
  margin: 70px auto 50px;
}
</style>

