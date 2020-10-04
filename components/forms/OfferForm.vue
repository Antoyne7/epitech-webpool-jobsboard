<template>
  <div>
    <b-container>
      <b-row>
        <div class="mx-auto rounded w-100 mt-3 mb-4 p-4">
          <form @submit="preSubmit($event, offre)" class="d-flex flex-wrap">
            <label for="nom" class="d-none">Intitulé de l'offre</label>
            <input v-model="offre.nom" style="height: fit-content" type="text" name="nom" id="nom"
                   value="Titre de l'offre">

            <div class="col-sm-6">
              <div class="d-flex mt-5">
                <label for="entreprise">Entreprise</label>
                <input class="col-10" type="text" v-model="offre.entreprise" name="entreprise" id="entreprise"
                       placeholder="entreprise">
                <div class="px-2 col-2">
                  <button class="h-100 rounded-lg w-100 btn btn-primary">+</button>
                </div>
              </div>

              <div class="mt-5">
                <label for="tags">Tags (select multiple ou checkboxes stylisé?)</label>
                <input v-model="tagsText" type="text" name="tags" id="tags" placeholder="tag1, tag2, tag3"
                       @keyup="updateTags">
                <small>Les tags doivent être séparer par une virgule</small>

                <div v-if="offre.tags.length > 0" class="mt-2">
                  <Tag v-for="tag in offre.tags" v-bind:key="tag" class="d-inline-block m-1" :text="tag"/>
                </div>
              </div>

            </div>

            <div class="position-relative col-sm-6 px-0" style="background-color: lightgray">
              <input type="file" id="image" class="h-100 w-100 position-absolute" @change="updatePreviewImg($event)" />
              <img class="mx-auto d-block" :src="preview" alt="">
            </div>

            <div class="col-sm-6">
              <label class="d-block">Type de contrat</label>
              <CheckboxButton class="d-inline-block" value="alternance" label="alternance"/>
              <CheckboxButton class="d-inline-block" value="cdi" label="CDI"/>
              <CheckboxButton class="d-inline-block" value="cdd" label="CDD"/>
              <CheckboxButton class="d-inline-block" value="stage" label="stage"/>
            </div>


            <div class="col-sm-6 px-0 mt-4">
              <label class="d-block" for="shortDescription">Description courte</label>
              <textarea class="d-block w-100" rows="5" v-model="offre.shortDescription" name="shortDescription"
                        id="shortDescription"/>
            </div>

            <div class="col-12 row flex-wrap">
              <label class="d-block col-12" for="description">Description détaillée</label>
              <p class="col-12 text-secondary">
                Il est possible d’utiliser <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet">Markdown</a>
                pour écrire votre description, plus d’information sur l’utilisation de Markdown
                <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet">ici</a>.
              </p>

              <div class="col-sm-6">
                <textarea class="d-block w-100"
                          rows="12"
                          v-model="description"
                          name="description"
                          id="description"
                          @keyup="updateDescriptions"/>
              </div>
              <div class="col-sm-6" v-html="offre.description"></div>
            </div>

            <div class="d-flex col-12 mt-4">
              <button class="btn mx-auto mt-3 px-4 py-3" type="submit">Enregistrer</button>
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
      preview: '',
      types: [],
      description: '# Détail de l\'offre\n' +
        '---\n' +
        'Écrivez les détails de votre offre ici\n' +
        '\n' +
        '## Missions\n' +
        'Vous pouvez faire différentes parties\n' +
        '- Avec des listes\n' +
        '- non ordonnées\n' +
        '1. mais aussi\n' +
        '2. ordonnées',
      tagsText: '',
      offre: {
        nom: 'Titre de l\'offre',
        ville: null,
        departement: null,
        entreprise: null,
        tags: [],
        image: null,
        offreType: [],
        shortDescription: '',
        description: ''
      }
    }
  },
  methods: {
    preSubmit(event, offre) {
      event.preventDefault()
      console.log('pre submit de l\'ajout d\'offre')
      this.offre.offreType = this.$store.state.offretype.types
      this.onSubmit(offre)
    },
    updateDescriptions () {
      this.offre.description = this.compiledDescription
    },
    updateTags () {
      console.log('update tags')
      this.offre.tags = this.compiledTags
    },
    updatePreviewImg (event) {
      this.preview = window.URL.createObjectURL(event.target.files[0])
    }
  },
  computed: {
    compiledDescription() {
      return marked(this.description)
    },
    compiledTags() {
      return this.tagsText.split(',').map(tag => tag.trim().toLowerCase()).filter(tag => tag.length > 0)
    }
  },
  mounted() {
    this.updateDescriptions()
  }
}
</script>

<style lang="scss" scoped>
h2 {
  font-size: 2.4rem;
}

input, select {
  font-size: 1.6rem;
  display: block;
  width: 100%;
}

input {
  padding: 5px 10px;
  border-radius: 4px;
  border: 1px solid black;

  &#nom {
    background-color: transparent;
    border: none;
    outline: none;
    font-size: 3.6rem;
    font-weight: 700;
  }
  &#image {
    opacity: 0;
    cursor: pointer;
  }
}

label {
  display: none;
  font-size: 1.8rem;
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
  border-radius: 4px;
  padding-left: 6px;
}

::v-deep p, ::v-deep li {
  font-size: 1.6rem;
}

.btn {
  background-color: var(--primary-jobs);
  color: white;
}


</style>
