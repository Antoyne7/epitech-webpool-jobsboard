<template>
  <div>
    <b-container>
      <b-row>
        <div class="mx-auto form-container rounded mt-3 mb-4 p-4 bg-white">
          <form @submit="preSubmit($event, offre)">
            <h2>
              Ajouter une offre
            </h2>

            <div>
              <label for="nom">Intitulé de l'offre</label>
              <input type="text" v-model="offre.nom" name="nom" id="nom" placeholder="Intitulé de l'offre">
            </div>

            <div>
              <label for="entreprise">Entreprise</label>
              <input type="text" v-model="offre.entreprise" name="entreprise" id="entreprise" placeholder="Entreprise">
            </div>

            <div>
              <label class="d-block" for="image">Illustration de l'offre</label>
              <input class="mt-0" type="file" name="image" id="image">
            </div>

            <div>
              <label for="tags">Tags (select multiple ou checkboxes stylisé?)</label>
              <input v-model="tagsText" type="text" name="tags" id="tags" placeholder="tag1, tag2, tag3" @keyup="updateTags">
              <small>Les tags doivent être séparer par une virgule</small>

              <div v-if="offre.tags.length > 0" class="mt-2">
                <Tag v-for="tag in offre.tags" v-bind:key="tag" class="d-inline-block m-1" :text="tag" />
              </div>
            </div>


            <div>
              <label>Type de contrat</label>
              <CheckboxButton class="d-inline-block" value="beep" label="beep"/>
              <CheckboxButton class="d-inline-block" value="boop" label="boop"/>
            </div>


            <div>
              <label class="d-block" for="shortDescription">Description courte</label>
              <textarea class="d-block w-100" rows="5" v-model="shortDescription" name="shortDescription" id="shortDescription"
                        @keypress="updateDescriptions"/>
            </div>

            <div>
              <label class="d-block" for="description">Description détaillée</label>
              <textarea class="d-block w-100" rows="12" v-model="description" name="description" id="description"
                        @keypress="updateDescriptions"/>
            </div>

            <div class="d-flex">
              <button class="btn mx-auto mt-3" type="submit">Enregistrer</button>
            </div>
          </form>
        </div>
      </b-row>
    </b-container>
  </div>

</template>

<script>
import Tag from '~/components/Tag'
import CheckboxButton from "~/components/forms/CheckboxButton";
export default {
  name: "OfferForm",
  head() {
    return {
      script: [
        {src: 'https://cdn.jsdelivr.net/npm/marked/marked.min.js'}
      ]
    }
  },
  components: {
    Tag,
    CheckboxButton
  },
  props: {
    onSubmit: {
      type: Function,
      required: true
    },
    add: {
      type: Boolean,
      required: false,
      default: false
    },
    offer: {
      type: Object,
      required: false,
      default: {}
    }
  },
  data() {
    return {
      types: [],
      shortDescription: '',
      description: '',
      tagsText: '',
      offre: {
        nom: '',
        ville: null,
        departement: null,
        entreprise: null,
        tags: [],
        offreType: [],
        shortDescription: '',
        description: ''
      }
    }
  },
  methods: {
    preSubmit (event, offre) {
      event.preventDefault()
      console.log('pre submit de l\'ajout d\'offre')
      this.offre.offreType = this.$store.state.offretype.types
      this.onSubmit(offre)
    },
    updateDescriptions () {
      this.offre.shortDescription = this.compiledShortDescription
      this.offre.description = this.compiledDescription
    },
    updateTags () {
      console.log('update tags')
      this.offre.tags = this.compiledTags
    }
  },
  computed: {
    compiledShortDescription() {
      return marked(this.shortDescription)
    },
    compiledDescription() {
      return marked(this.description)
    },
    compiledTags() {
      return this.tagsText.split(',').map(tag => tag.trim().toLowerCase()).filter(tag => tag.length > 0)
    }
  }
}
</script>

<style lang="scss" scoped>
.form-container {
  width: 460px;
}

h2 {
  font-size: 2.4rem;
}

input, label, select {
  font-size: 1.6rem;
  display: block;
  width: 100%;
  margin-top: 20px;
}
input {
  padding: 5px 10px;
  border-radius: 4px;
  border: 1px solid black;
}
label {
  display: none;
}

button {
  font-size: 1.6rem;
}

small {
  font-size: 1rem;
  margin-top: 2px;
  margin-left: 2px;
  display: block;
}

textarea {
  resize: none;
  font-size: 1.6rem;
}


</style>
