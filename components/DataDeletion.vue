<template>
  <b-modal id="delete-modal" title="Modal de suppression" hide-footer hide-header>
    <p class="my-4">
      <slot></slot> id:   {{ toDelete }}
    </p>
    <b-button @click="deleteData">del</b-button>
  </b-modal>
</template>

<script>
import ajaxServices from "@/services/ajaxServices";

export default {
  name: "BasicDataDeletion",
  props: [
    'type',
    'dataId'
  ],
  data () {
    return {
      toDelete: null
    }
  },
  methods: {
    deleteModal(id) {
      this.toDelete = id
      this.$bvModal.show('delete-modal')
    },
    deleteData() {
      // ajaxpost
      ajaxServices.deleteInformations(this.type, this.toDelete)
        .then(() => {
          this.$bvModal.hide('delete-modal')
          this.$nuxt.$emit('deletion')

          console.log('jai emit')
        })
        .catch(e => console.log(e))
    }
  }
}
</script>

<style scoped>

</style>
