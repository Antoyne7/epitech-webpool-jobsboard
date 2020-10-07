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
      console.log('data:', offretype)
      // ajaxServices.pushInformations()
    }
  }
}
</script>

<style scoped>

</style>
