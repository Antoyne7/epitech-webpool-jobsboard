<template>
  <div>
    <b-container class="mt-4">
      <b-row>
        <b-button :to="{ name: 'admin' }" block variant="primary" size="lg">
          back
        </b-button>
        <b-button :to="{ name: 'admin-offretype-add' }">
          Ajout nouveau type offre
        </b-button>
      </b-row>
    </b-container>
    <b-container class="container-cards">
        <DataCard v-for="typeOffre in listeTypeOffres" v-bind:key="typeOffre.id">
          {{ typeOffre.nom }}
        </DataCard>
    </b-container>
  </div>
</template>

<script>
import DataCard from "@/components/DataCard"
import AjaxServices from "@/services/ajaxServices";

export default {
  name: "Index",
  components: {
    DataCard
  },
  data() {
    return {
      listeTypeOffres: [],
    }
  },
  created() {
    AjaxServices.getListe('typeOffres').then(promise => {
      console.log(promise)
      this.listeTypeOffres = promise;
    })
  }
}
</script>

<style scoped>

</style>
