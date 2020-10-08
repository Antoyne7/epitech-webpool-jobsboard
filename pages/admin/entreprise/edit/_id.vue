<template>
  <BasicDataForm :submit-function="updateData" :data-object="entreprise">
    Editer l'entreprise {{ entreprise.nom }}
  </BasicDataForm>
</template>

<script>
import BasicDataForm from "@/components/forms/BasicDataForm";
import ajaxServices from "@/services/ajaxServices";

export default {
  name: "Edit",
  components: {
    BasicDataForm
  },
  data() {
    return {
      entreprise: {
        id: null,
        nom: ''
      }
    }
  },
  methods: {
    updateData(entreprise) {
      console.log('init: ', this.entreprise)
      console.log('updated: ', entreprise)
      // Update, afficher animation success puis retour a la liste des entreprise
      // ajaxServices.updateInformations()
    }
  },
  created() {
    if (!this.$route.params.id) {
      this.$router.back()
    }
    ajaxServices.getInformations('entreprises', this.$route.params.id)
      .then(data => {
        this.entreprise = data
      })
      .catch(e => console.log(e))
  }
}
</script>

<style scoped>

</style>
