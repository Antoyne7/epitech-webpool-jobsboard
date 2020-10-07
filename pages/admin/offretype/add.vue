<template>
  <div>
    <b-button to=".">
      back
    </b-button>
    <BasicDataForm classe="Type d'offre" />
  </div>
</template>

<script>
import BasicDataForm from "@/components/forms/BasicDataForm";
export default {
  name: "add",
  components: {
    BasicDataForm
  }
}
</script>

<style scoped>

</style>
