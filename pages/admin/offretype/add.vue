<template>
  <BasicDataForm :submit-function="create">
    Créer un nouveau type de contrat
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
    create (offretype) {
      const formdata = new FormData()
      formdata.append('nom', offretype.nom)
      ajaxServices.pushInformations('typeOffres', formdata)
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
