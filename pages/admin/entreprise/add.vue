<template>
  <BasicDataForm :submit-function="create">
    Créer une nouvelle entreprise
  </BasicDataForm>
</template>

<script>
import BasicDataForm from "@/components/forms/BasicDataForm";
import ajaxServices from "@/services/ajaxServices";

export default {
  name: "add",
  components: {
    BasicDataForm
  },
  methods: {
    create(entreprise) {
      const formdata = new FormData()
      formdata.append('nom', entreprise.nom)
      ajaxServices.pushInformations('entreprises', formdata)
        .then(data => {
          if (data.id) {
            this.$router.back()
          }
        })
        .catch(e => console.log(e))
    }
  }
}
</script>

<style scoped>

</style>
