<template>
  <div>
    <DataDeletion ref="deleteComponent" type="typeOffres" :data-id="toDelete">On supprime mon pote typeoffre
    </DataDeletion>
    <b-container class="my-5">
      <b-row class="justify-content-between">
        <b-button variant="light" @click="$router.back()" class="back text-uppercase font-weight-bold d-flex align-items-center">
          <img src="~/static/icons/ic_chevron_right_48px.svg" alt="Retour page précédente">
          Retour
        </b-button>
        <div>
          <b-button class="new-offre" variant="light" :to="{ name: 'admin-offretype-add' }">
            <b-icon-plus-square class="mr-2" />
            Nouveau type de contrat
          </b-button>
        </div>
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
    updateList() {
      AjaxServices.getListe('typeOffres').then(promise => {
        this.listeTypeOffres = promise;
      })
    }
  }
}
</script>

<style scoped lang="scss">
button, a, p, div {
  font-size: 1.6rem;
}

button, a {
  border-radius: 6px;
  padding: 6px 12px;
  &.new-offre {
    font-weight: bold;
  }
  &.back {
    img {
      transform: rotate(180deg);
      width: 24px;
    }
  }
}

.container-cards {
  margin: 30px auto;
}

</style>
