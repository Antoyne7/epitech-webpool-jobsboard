<template>
  <div>
    <b-container class="mt-4">
      <b-row>
        <b-button :to="{ name: 'admin' }" block variant="primary" size="lg">
          back
        </b-button>
        <b-button :to="{ name: 'admin-entreprise-add' }">
          Ajout nouvelle entreprise
        </b-button>
      </b-row>
    </b-container>
    <b-container class="container-cards">
        <DataCard v-for="entreprise in entreprises" v-bind:key="entreprise.id" :to="'./entreprise/edit/' + entreprise.id">
          {{ entreprise.nom }}
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
      entreprises: [],
    }
  },
  created() {
    AjaxServices.getListe('entreprises').then(promise => {
      console.log(promise)
      this.entreprises = promise;
    })
  }
}
</script>

<style scoped>

</style>
