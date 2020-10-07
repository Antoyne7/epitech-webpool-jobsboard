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
      console.log('creer l\'entreprise:', entreprise)
      // ajaxServices.pushInformations()
    }
  }
}
</script>

<style scoped>

</style>
