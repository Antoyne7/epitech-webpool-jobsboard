<template>
  <div>
    <OfferForm :on-submit="ajoutOffre"/>
  </div>
</template>

<script>
import OfferForm from "~/components/forms/OfferForm";
import AjaxServices from "@/services/ajaxServices";
export default {
  head() {
    return {
      title: "Jobs - ajout d'offres"
    }
  },
  name: "Add",
  components: {
    OfferForm
  },
  methods: {
    ajoutOffre (data) {
      const formdata = new FormData()

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

      AjaxServices.pushInformations('listeOffres', formdata)
        .then(data => {

        })
        .catch(error => {
          console.dir(error)
        })
    }
  }
}
</script>

<style scoped>

</style>
