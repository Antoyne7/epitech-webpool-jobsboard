<template>
  <b-container>
    <h2>Ajout {{ classe }}</h2>
    <b-form @submit="preSubmit($event)">
      <label for="nom">Nom</label>
      <input type="text" id="nom" name="nom" placeholder="Entrez un nom">

      <b-button variant="primary">Enregistrer</b-button>
    </b-form>
  </b-container>
</template>

<script>
export default {
  name: "BasicDataForm",
  props: [
    'classe',
    'submitFunction'
  ],
  data () {
    return {
      nom: ''
    }
  },
  methods: {
    preSubmit (event) {
      event.preventDefault()
      console.log()
      this.submitFunction()
    }
  }
}
</script>

<style scoped>

</style>
