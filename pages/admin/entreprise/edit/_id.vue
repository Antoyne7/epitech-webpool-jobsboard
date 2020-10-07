<template>
  <div>
    <b-button to=".">
      back
    </b-button>
    <BasicDataForm classe="entreprise" />
  </div>
</template>

<script>
import BasicDataForm from "@/components/forms/BasicDataForm";
export default {
  name: "Edit",
  components: {
    BasicDataForm
  }
}
</script>

<style scoped>

</style>
