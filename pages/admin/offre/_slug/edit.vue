<template>
  <div>
    <OfferForm :is-modif="true" :on-submit="editOffre"/>
  </div>
</template>

<script>
import OfferForm from "~/components/forms/OfferForm";
import AjaxServices from "@/services/ajaxServices";
export default {
  head() {
    return {
      title: "Jobs - modification offre "
    }
  },
  name: "Add",
  components: {
    OfferForm
  },
  methods: {
    editOffre (data) {
      const formdata = new FormData()
      formdata.append('_method', 'put')
      formdata.append('nom', data.nom)
      formdata.append('ville', data.localisation.ville)
      formdata.append('codeVille', data.localisation.codeVille)
      formdata.append('codeDepartement', data.localisation.codeDepartement)
      formdata.append('image', data.image)
      formdata.append('tags', JSON.stringify(data.tags))
      formdata.append('offretype', JSON.stringify(data.offreType))
      formdata.append('entreprise', data.entreprise.id)
      formdata.append('shortDescription', data.shortDescription)
      formdata.append('description', data.description )
      this.$axios.$post('/back/api/offres/' + this.$route.params.slug, formdata)
        .then(data => {
        })
        .catch(error => {
          console.dir(error)
        })
    }
  },
}
</script>

<style scoped>

</style>
