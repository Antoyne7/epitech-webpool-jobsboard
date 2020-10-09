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
      // Update, afficher animation success puis retour a la liste des entreprise
      ajaxServices.updateInformations('entreprises', this.entreprise.id, entreprise)
        .then(() => {
          this.$router.back()
        })
        .catch(e => console.log(e))
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
