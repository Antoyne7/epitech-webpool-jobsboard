<template>
  <div>
    <OfferForm  :on-submit="ajoutOffre"/>
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
    }
  }
}
</script>

<style scoped>

</style>
