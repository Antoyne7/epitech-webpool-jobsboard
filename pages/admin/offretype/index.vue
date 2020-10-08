<template>
  <div>
    <DataDeletion ref="deleteComponent" type="typeOffres" :data-id="toDelete">On supprime mon pote typeoffre</DataDeletion>
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
      <DataCard v-for="typeOffre in listeTypeOffres" v-bind:key="typeOffre.id" :delete-function="deleteFunction"
                :to="'./offretype/edit/' + typeOffre.id"
                :data="typeOffre">
        {{ typeOffre.nom }}
      </DataCard>
    </b-container>
  </div>
</template>

<script>
import DataCard from "@/components/DataCard"
import AjaxServices from "@/services/ajaxServices";
import DataDeletion from "@/components/DataDeletion";

export default {
  name: "Index",
  components: {
    DataCard,
    DataDeletion
  },
  data() {
    return {
      listeTypeOffres: [],
      toDelete: null
    }
  },
  created() {
    this.updateList()
    const self = this
    this.$nuxt.$on('deletion', function () {
      console.log('emit recept')
      self.updateList()
    })
  },
  methods: {
    deleteFunction(id) {
      this.toDelete = id
      this.$refs.deleteComponent.deleteModal(this.toDelete)
    },
    updateList () {
      AjaxServices.getListe('typeOffres').then(promise => {
        this.listeTypeOffres = promise;
      })
    }
  }
}
</script>

<style scoped>

</style>
