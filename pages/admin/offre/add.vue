<template>
  <div>
    <OfferForm :on-submit="ajoutOffre"/>
  </div>
</template>

<script>
import OfferForm from "~/components/forms/OfferForm";
export default {
  name: "Add",
  components: {
    OfferForm
  },
  methods: {
    ajoutOffre (data) {
      console.log('data:', data)
      const formdata = new FormData()
      formdata.append('nom', data.nom)
      formdata.append('ville', data.localisation.ville)
      formdata.append('codeVille', data.localisation.codeVille)
      formdata.append('codeDepartement', data.localisation.codeDepartement)
      formdata.append('image', data.image)
      formdata.append('tags', data.tags)
      formdata.append('offretype', data.offreType)
      formdata.append('entreprise', data.entreprise.id)

      this.$axios.$post('http://localhost/EPITECH/PROJETS/JOBBOARD/T-WEB-501-STG-5-1-jobboard-lucas.michalet/back/public/api/offres', formdata)
        .then(data => {
          console.log(data)
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
