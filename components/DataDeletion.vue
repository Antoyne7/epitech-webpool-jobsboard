<template>
  <b-modal id="delete-modal" title="Modal de suppression" hide-footer hide-header>
    <p class="my-4">
      <slot></slot>
    </p>
    <b-button variant="secondary" class="mr-2" @click="deleteData">Oui, supprimer.</b-button>
    <b-button variant="primary" class="bg-blue-jobs"  @click="cancel">Annuler</b-button>
  </b-modal>
</template>

<script>
import ajaxServices from "@/services/ajaxServices";

export default {
  name: "BasicDataDeletion",
  props: [
    'type'
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
      this.$axios.$delete('/back/api/' + this.type + '/' + this.toDelete)
        .then(() => {
          this.$bvModal.hide('delete-modal')
          this.$emit('deletion')
          console.log('jai emit')
        })
        .catch(e => console.log(e))
    },
    cancel() {
      this.$bvModal.hide('delete-modal')
      this.toDelete = null
    }
  }
}
</script>

<style scoped>
  p, button {
    font-size: 1.6rem;
  }

  button {
    border-radius: 6px;
    padding: 4px 12px;
  }

</style>
