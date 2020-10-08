<template>
    <BasicDataForm :submit-function="updateData" :data-object="typeOffre">
      Editer le contrat: "{{ typeOffre.nom }}"
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
      typeOffre: {
        id: null,
        nom: ''
      }
    }
  },
  methods: {

    updateData(typeOffre) {
      console.log('init: ', this.typeOffre)
      console.log('updated: ', typeOffre)
      // Update, afficher animation success puis retour a la liste des entreprise
      // ajaxServices.updateInformations()
    }
  },
  created() {
    if (!this.$route.params.id) {
      this.$router.back()
    }
    ajaxServices.getInformations('typeOffres', this.$route.params.id)
      .then(data => {
        this.typeOffre = data
      })
      .catch(e => console.log(e))
  }
}
</script>

<style scoped>

</style>
