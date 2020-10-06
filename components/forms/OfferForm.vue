<template>
  <div>
    <b-modal id="modal-entreprise" title="Nouvelle entreprise" hide-footer hide-header centered>
      <label class="d-block" for="nom-entreprise">Ajoutez une nouvelle entreprise</label>
      <input v-model="entreprise.nom" type="text" name="nom-entreprise" id="nom-entreprise"
             placeholder="Nom de l'entreprise">
      <button class="btn bg-jobs mt-4 mr-2" @click="entrepriseSubmit">Enregistrer</button>
      <button class="btn btn-danger mt-4" @click="hideEntrepriseModal">Annuler</button>
    </b-modal>
    <b-container>
      <b-row>
        <div class="mx-auto rounded w-100 mt-3 mb-4 p-4">
          <form autocomplete="off" @submit="preSubmit($event, offre)" class="d-flex flex-wrap">
            <label for="nom" class="d-none">Intitulé de l'offre</label>
            <div class="position-relative w-100 titre-container">
              <input v-model="offre.nom" type="text" name="nom" id="nom"
                     value="Titre de l'offre">
              <img class="position-absolute" :src="editIcone" alt="edit icone"/>
            </div>

            <div class="col-md-6 px-0 pr-md-4">
              <!-- Entreprise -->
              <div class="d-flex flex-wrap mt-5">
                <label for="entreprise">Entreprise</label>
                <input class="col-10" type="text" v-model="offre.entreprise.nom" name="entreprise" id="entreprise"
                       placeholder="entreprise">
                <div class="px-2 col-2">
                  <button v-b-modal.modal-entreprise class="bg-jobs h-100 rounded-lg w-100 btn btn-primary">+</button>
                </div>
                <p>Entreprise séléctionné: {{ offre.entreprise.nom }}</p>
              </div>

              <!-- Tags -->
              <div class="my-5">
                <label for="tags">Tags (select multiple ou checkboxes stylisé?)</label>
                <input v-model="tagsText" type="text" name="tags" id="tags" placeholder="tag1, tag2, tag3"
                       @keyup="updateTags">
                <small>Les tags doivent être séparer par une virgule</small>

                <div v-if="offre.tags.length > 0" class="mt-2">
                  <Tag v-for="tag in offre.tags" v-bind:key="tag" class="d-inline-block m-1" :text="tag"/>
                </div>
              </div>

              <!-- Localisation -->
              <div class="d-flex flex-wrap mt-5 position-relative">
                <label for="localisation">Localisation de l'offre</label>
                <input type="text" v-model="localisation.search" @keyup="updateLocalisation" @focus="localisation.showList = true"
                       name="localisation" id="localisation" placeholder="Strasbourg">
                <ul id="localisation-autocomplete" class="position-absolute w-100 bg-white rounded"
                    v-if="localisationFilter.length > 0 && localisation.showList"> <!-- Autocomplete list -->
                  <li class="localisation-item" v-for="localisation in localisationFilter" v-bind:key="localisation.key"
                      @click="setLocalisation(localisation)">
                    {{ localisation.nom }} {{ localisation.codesPostaux[0] }}, {{ localisation.departement.nom }}
                  </li>
                </ul>
                <p>Localisation:
                  <span v-if="localisation.selected">{{ localisation.selected.nom }} {{ localisation.selected.codesPostaux[0] }}, {{ localisation.selected.departement.nom }}</span>
                  <span v-else>Toute la France</span>
                </p>
              </div>
            </div>

            <div class="position-relative d-flex align-items-center justify-content-center col-md-6 px-0"
                 id="file-container">
              <input type="file" id="image" class="h-100 w-100 position-absolute" @change="updatePreviewImg($event)"/>
              <img class="mx-auto d-block mh-100 mw-100" :src="preview" alt="Prévisualisation de l'image">
            </div>

            <div class="col-md-6 px-0">
              <label class="d-block mt-4">Type de contrat</label>
              <CheckboxButton class="d-inline-block" value="alternance" label="alternance"/>
              <CheckboxButton class="d-inline-block" value="cdi" label="CDI"/>
              <CheckboxButton class="d-inline-block" value="cdd" label="CDD"/>
              <CheckboxButton class="d-inline-block" value="stage" label="stage"/>
            </div>


            <div class="col-md-6 px-0 my-4">
              <label class="d-block" for="shortDescription">Description courte</label>
              <textarea class="d-block w-100" rows="5" v-model="offre.shortDescription" name="shortDescription"
                        id="shortDescription"/>
            </div>

            <div class="col-12 d-flex px-0 flex-wrap">
              <label class="d-block w-100" for="description">Description détaillée</label>
              <p class="w-100 text-secondary">
                Il est possible d’utiliser <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet">Markdown</a>
                pour écrire votre description, plus d’information sur l’utilisation de Markdown
                <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet">ici</a>.
              </p>

              <div class="col-md-6 px-0">
                <textarea class="d-block w-100"
                          rows="12"
                          v-model="description"
                          name="description"
                          id="description"
                          @keyup="updateDescriptions"/>
              </div>
              <div class="col-md-6 d-none d-md-block" v-html="offre.description"></div>
            </div>

            <div class="d-flex col-12 mt-4">
              <button class="bg-jobs btn mx-auto mt-3 px-4 py-3" type="submit">Enregistrer</button>
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
import camera from '~/static/icons/camera.svg'
import edit from '~/static/icons/edit.svg'

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
      default: null
    }
  },
  data() {
    return {
      preview: camera,
      editIcone: edit,
      types: [],
      description: '',
      tagsText: '',
      localisation: {
        search: '',
        list: [],
        selected: null,
        showList: false
      },
      offre: {
        nom: 'Titre de l\'offre',
        entreprise: {
          id: null,
          nom: null,
        },
        tags: [],
        image: null,
        offreType: [],
        shortDescription: '',
        description: '',
        localisation: {
          codeDepartement: null,
          codeVille: null,
          ville: ''
        }
      },
      entreprise: {
        nom: ''
      }
    }
  },
  methods: {
    preSubmit(event, offre) {
      event.preventDefault()
      console.log('pre submit de l\'ajout d\'offre')
      this.offre.offreType = this.$store.state.offretype.types
      this.offre.image = document.querySelector('input[type="file"]').files[0]
      this.onSubmit(offre)
    },
    updateDescriptions() {
      this.offre.description = this.compiledDescription
    },
    updateTags() {
      console.log('update tags')
      this.offre.tags = this.compiledTags
    },
    updatePreviewImg(event) {
      this.preview = window.URL.createObjectURL(event.target.files[0])
    },
    async updateLocalisation() {
      if (this.localisation.search.length === 3) {
        this.localisation.list = await this.$axios.$get('https://geo.api.gouv.fr/communes?nom=' + this.localisation.search + '&fields=nom,code,codesPostaux,codeDepartement,departement,codeRegion&format=json&geometry=centre')
        this.localisation.showList = true
      } else if (this.localisation.search.length < 3) {
        this.localisation.list = []
      }
    },
    entrepriseSubmit() {
      console.log('Creation nouvelle entreprise avec pour nom:', this.entreprise.nom)
      // this.$axios.$post()
      this.hideEntrepriseModal()
    },
    hideEntrepriseModal() {
      this.$bvModal.hide('modal-entreprise')
    },
    initDescription() {
      this.offre.description = '# Détail de l\'offre\n' +
        '---\n' +
        'Écrivez les détails de votre offre ici\n' +
        '\n' +
        '## Missions\n' +
        'Vous pouvez faire différentes parties\n' +
        '- Avec des listes\n' +
        '- non ordonnées\n' +
        '1. mais aussi\n' +
        '2. ordonnées'
      this.updateDescriptions()
    },
    setLocalisation(localisation) {
      this.localisation.search = ''
      this.localisation.selected = localisation
      this.offre.localisation.codeDepartement = localisation.departement.code
      this.offre.localisation.codeVille = localisation.code
      this.offre.localisation.ville = localisation.nom
      this.localisation.showList = false
    },
  },
  computed: {
    compiledDescription() {
      return marked(this.description)
    },
    compiledTags() {
      return this.tagsText.split(',').map(tag => tag.trim().toLowerCase()).filter(tag => tag.length > 0)
    },
    localisationFilter() {
      const sorted = this.localisation.list.filter(localisation =>
        localisation.nom.toLowerCase().includes(this.localisation.search.toLowerCase().trim()))
      if (sorted.length > 6) {
        return sorted.slice(0,6)
      } else {
        return sorted
      }
    }
  },
  mounted() {
    if (marked) {
      this.initDescription()
    }
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

.btn.bg-jobs {
  background-color: var(--primary-jobs);
  color: white;
}

div#file-container {
  background-color: transparent;
  border: 2px solid black;
  border-radius: 4px;
  height: 300px;

  &:hover::after {
    content: url('~static/icons/camera.svg');
    position: absolute;
    pointer-events: none;
    height: 36px;
    opacity: .8;
  }

  &:hover::before {
    content: '';
    background-color: #000;
    opacity: .2;
    position: absolute;
    pointer-events: none;
    width: 100%;
    height: 100%;
  }
}

.titre-container {
  padding-left: 30px;

  & img {
    left: 0;
    top: 50%;
    transform: translateY(-50%);
  }
}

#localisation-autocomplete {
  top: 40px;
  z-index: 100;
  list-style: none;
  padding: 6px 0;
  li {
    padding: 4px 12px;
    cursor: pointer;

    &:hover {
      background-color: #EEEEEE;
    }
  }
}

</style>
