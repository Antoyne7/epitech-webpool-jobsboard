<template>
  <div>
    <SearchBar />
    <DataDeletion @deletion="refreshOffres" type="offres" ref="offreDeletion">
      Supprimer l'offre ?
    </DataDeletion>
    <b-container>
      <b-row>
        <b-button
          :to="{ name: 'admin-offre-add' }"
          block
          variant="primary"
          size="lg"
        >
          Ajouter une nvl offre
        </b-button>
        <b-button
          :to="{ name: 'admin-offretype' }"
          block
          variant="primary"
          size="lg"
        >
          Gestion types de contrats
        </b-button>
        <b-button
          :to="{ name: 'admin-entreprise' }"
          block
          variant="primary"
          size="lg"
        >
          Gestion des entreprises
        </b-button>
      </b-row>
    </b-container>
    <b-container class="container-cards">
      <b-row>
        <JobCard
          v-for="offre in listeOffres"
          v-bind:key="offre.id"
          :offreProp="offre"
          admin-view="true"
          @deleteOffre="$refs.offreDeletion.deleteModal(offre.id)"
        />
      </b-row>
    </b-container>
  </div>
</template>

<script>
import JobCard from "@/components/JobCard";
import SearchBar from "@/components/SearchBar";
import DataDeletion from "@/components/DataDeletion";

export default {
  name: "Index",
  components: {
    JobCard,
    SearchBar,
    DataDeletion
  },
  data() {
    return {
      listeOffres: []
    };
  },
  methods: {
    async refreshOffres() {
      this.listeOffres = await this.$axios.$get("/back/api/offres")
        .then(promise => {
          this.listeOffres = [...promise];
          console.log(this.listeOffres)
        });
    }
  },
  mounted() {
    this.refreshOffres();
  }
};
</script>

<style scoped></style>
