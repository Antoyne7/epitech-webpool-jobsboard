<template>
  <b-container>
    <b-button class="mb-4" @click="$router.back()">
      back
    </b-button>
    <h2><slot></slot></h2>
    <b-form @submit.prevent="submitFunction({ id: id, nom: nom })">
      <label for="nom">Nom</label>
      <input v-model="nom" type="text" id="nom" name="nom" placeholder="Entrez un nom">
      <b-button type="submit" variant="primary">Enregistrer</b-button>
    </b-form>
  </b-container>
</template>

<script>
export default {
  name: "BasicDataForm",
  props: {
    dataObject: {
      type: Object,
      required: false,
      default: null
    },
    submitFunction: {
      type: Function,
      required: true
    }
  },
  data () {
    return {
      id: null,
      nom: ''
    }
  },
  mounted() {
    if (this.dataObject) {
      this.id = this.dataObject.id
      this.nom = this.dataObject.nom
    }
  }
}
</script>

<style scoped>

</style>
