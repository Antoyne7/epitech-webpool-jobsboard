<template>
  <div>

    <DataDeletion ref="deleteComponent" type="entreprises" :data-id="toDelete">On supprime mon pote entreprise
    </DataDeletion>

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

      <DataCard v-for="entreprise in entreprises" v-bind:key="entreprise.id"
                :data="entreprise" :to="'./entreprise/edit/' + entreprise.id"
                :delete-function="deleteFunction">
        {{ entreprise.nom }}
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
      entreprises: [],

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
    updateList() {
      AjaxServices.getListe('entreprises').then(promise => {
        this.entreprises = promise;
      })
    }
  }
}
</script>

<style scoped>

</style>
