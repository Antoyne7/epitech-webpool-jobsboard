<template>
  <div>
    <ModalSuccess
      :is-centered="true"
      route="/admin/offre/add"
      message="L'entreprise à bien été créer"
      id="modal-succ-entreprise"
    />
    <ModalSuccess
      :is-centered="true"
      route="/admin"
      :message="msgOffre"
      id="modal-succ-offre"
    />
    <b-modal
      id="modal-entreprise"
      title="Nouvelle entreprise"
      hide-footer
      hide-header
      centered
    >
      <label class="d-block" for="nom-entreprise"
        >Ajoutez une nouvelle entreprise</label
      >
      <input
        v-model="entreprise.add"
        type="text"
        name="nom-entreprise"
        id="nom-entreprise"
        placeholder="Nom de l'entreprise"
      />
      <button class="btn bg-jobs mt-4 mr-2" @click="entrepriseSubmit">
        Enregistrer
      </button>
      <button class="btn btn-danger mt-4" @click="hideEntrepriseModal">
        Annuler
      </button>
    </b-modal>
    <b-container>
      <b-row class="mt-3">
        <b-col v-if="offre && offre.pourvu" id="pourvu-text" cols="12">
          <b-icon-check></b-icon-check>
          Cette offre est pourvu.
        </b-col>

        <div class="mx-auto rounded w-100 mb-4 p-4">
          <form
            autocomplete="off"
            @submit="preSubmit($event, offre)"
            class="d-flex flex-wrap"
          >
            <label for="nom" class="d-none">Intitulé de l'offre</label>
            <div class="position-relative w-100 titre-container">
              <input
                v-model="offre.nom"
                type="text"
                name="nom"
                id="nom"
                value="Titre de l'offre"
              />
              <img
                class="position-absolute"
                :src="editIcone"
                alt="edit icone"
              />
            </div>

            <div class="col-md-6 px-0 pr-md-4">
              <!-- Entreprise -->
              <div class="d-flex flex-wrap mt-5 position-relative">
                <label for="entreprise">Entreprise</label>
                <div
                  class="entreprise-input autocomplete-input position-relative col-10 px-0"
                >
                  <input
                    type="text"
                    v-model="entreprise.search"
                    name="entreprise"
                    id="entreprise"
                    @click="entreprise.showList = true"
                    @focus="entreprise.showList = true"
                    @keyup.esc="entreprise.showList = false"
                    placeholder="entreprise"
                  />
                  <ul
                    id="entreprise-autocomplete"
                    class="position-absolute w-100 bg-white autocomplete-list"
                    v-if="entrepriseFilter.length > 0 && entreprise.showList"
                  >
                    <!-- Autocomplete list -->
                    <li
                      v-for="entreprise in entrepriseFilter"
                      v-bind:key="entreprise.id"
                      @click="setEntreprise(entreprise)"
                    >
                      {{ entreprise.nom }}
                    </li>
                  </ul>
                </div>
                <div class="px-2 col-2">
                  <button
                    type="button"
                    v-b-modal.modal-entreprise
                    class="bg-jobs font-weight-bold h-100 rounded-lg w-100 btn btn-primary"
                  >
                    +
                  </button>
                </div>
              </div>

              <!-- Tags -->
              <div class="my-5">
                <label for="tags"
                  >Tags (select multiple ou checkboxes stylisé?)</label
                >
                <input
                  v-model="tagsText"
                  type="text"
                  name="tags"
                  id="tags"
                  placeholder="tag1, tag2, tag3"
                  @keyup="updateTags"
                />
                <p>Les tags doivent être séparer par une virgule</p>

                <div v-if="offre.tags.length > 0" class="mt-2">
                  <Tag
                    v-for="tag in offre.tags"
                    v-bind:key="tag"
                    class="d-inline-block m-1"
                    :text="tag"
                  />
                </div>
              </div>

              <!-- Localisation -->
              <div class="d-flex flex-wrap mt-5 mb-4 position-relative">
                <label for="localisation">Localisation de l'offre</label>
                <div
                  class="position-relative autocomplete-input w-100"
                  :class="{
                    toggled:
                      localisationFilter.length > 0 && localisation.showList
                  }"
                >
                  <input
                    type="text"
                    v-model="localisation.search"
                    @keyup="updateLocalisation"
                    @focus="localisation.showList = true"
                    @click="localisation.showList = true"
                    @keyup.esc="localisation.showList = false"
                    name="localisation"
                    id="localisation"
                    placeholder="Strasbourg"
                  />
                </div>
                <ul
                  id="localisation-autocomplete"
                  class="position-absolute autocomplete-list w-100 bg-white"
                  v-if="localisationFilter.length > 0 && localisation.showList"
                >
                  <!-- Autocomplete list -->
                  <li
                    class="localisation-item"
                    v-for="localisation in localisationFilter"
                    v-bind:key="localisation.code"
                    @click="setLocalisation(localisation)"
                  >
                    {{ localisation.nom }} {{ localisation.codesPostaux[0] }},
                    {{ localisation.departement.nom }}
                  </li>
                </ul>
              </div>
            </div>

            <div
              class="position-relative d-flex align-items-center justify-content-center col-md-6 px-0"
              id="file-container"
            >
              <input
                type="file"
                accept="image/*,.pdf"
                id="image"
                class="h-100 w-100 position-absolute"
                @change="updatePreviewImg($event)"
              />
              <img
                class="mx-auto d-block mh-100 mw-100"
                :src="$getImage(preview)"
                alt="Prévisualisation de l'image"
              />
            </div>

            <div class="col-md-6 px-0 mb-4">
              <label class="d-block mt-4">Type de contrat</label>
              <CheckboxButton
                v-for="type in typeOffres"
                v-bind:key="type.id"
                class="d-inline-block"
                :value="type.nom"
                :label="type.nom"
              />
            </div>

            <div class="col-md-6 px-0 my-4">
              <label class="d-block" for="shortDescription"
                >Description courte</label
              >
              <textarea
                class="d-block w-100"
                rows="5"
                v-model="offre.shortDescription"
                name="shortDescription"
                id="shortDescription"
                placeholder="Entrez une description courte"
                maxlength="160"
              />
              <small
                :class="{ 'text-danger': offre.shortDescription.length > 120 }"
              >
                {{ offre.shortDescription.length }}/160
              </small>
            </div>

            <div class="col-12 d-flex px-0 flex-wrap">
              <label class="d-block w-100" for="description"
                >Description détaillée</label
              >
              <p class="w-100 text-secondary">
                Il est possible d’utiliser
                <a
                  href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
                  >Markdown</a
                >
                pour écrire votre description, plus d’information sur
                l’utilisation de Markdown
                <a
                  href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet"
                  >ici</a
                >.
              </p>
              <div class="col-md-6 px-0">
                <textarea
                  class="d-block w-100"
                  rows="12"
                  v-model="offre.description"
                  name="description"
                  id="description"
                />
              </div>
              <div
                class="col-md-6 d-none d-md-block"
                v-html="compiledDescription"
              ></div>
            </div>
            <Alert class="text-center w-100 mt-5" v-show="error" type="error" :msg="errorMsg" />

            <div class="d-flex col-12 mt-4">
              <button
                class="submit bg-jobs btn mx-auto mt-3 px-4 py-3"
                type="submit"
              >
                Enregistrer
              </button>
            </div>
          </form>
        </div>
        <ListeCandidatures :offre="offre" />
      </b-row>
    </b-container>
  </div>
</template>

<script>
import Tag from "~/components/Tag";
import CheckboxButton from "~/components/forms/CheckboxButton";
import camera from "~/static/icons/camera.svg";
import edit from "~/static/icons/edit.svg";
import AjaxServices from "~/services/ajaxServices";
import modalSuccess from "@/components/modalSuccess";
import Lightbox from "~/components/Lightbox";
import Alert from "~/components/Alert";
import ListeCandidatures from "~/components/ListeCandidatures";

export default {
  name: "OfferForm",
  components: {
    Tag,
    CheckboxButton,
    modalSuccess,
    Lightbox,
    Alert,
    ListeCandidatures
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
      error: false,
      errorMsg: '',
      msgOffre: "L'offre à bien été créer",
      typeOffres: [],
      preview: camera,
      editIcone: edit,
      types: [],
      description: "",
      tagsText: "",
      localisation: {
        search: "",
        list: [],
        showList: false
      },
      entreprise: {
        search: "",
        list: [],
        showList: false,
        add: ""
      },
      offre: {
        nom: "Titre de l'offre",
        entreprise: {
          id: null,
          nom: null
        },
        tags: [],
        image: null,
        offreType: [],
        shortDescription: "",
        description: "",
        localisation: {
          codeDepartement: null,
          codeVille: null,
          ville: ""
        },
        pourvu: false,
        candidatures: []
      }
    };
  },
  methods: {
    preSubmit(event, offre) {
      event.preventDefault();
      console.log("pre submit de l'ajout d'offre");
      if (offre.pourvu === 1) {
        this.errorMsg = 'Impossible de modifié l\'offre car celle-ci est déjà pourvu.'
        this.error = true
        return
      }
      this.offre.offreType = this.$store.state.offretype.types;
      this.offre.image = document.querySelector('input[type="file"]').files[0];
      this.$bvModal.show("modal-succ-offre");
      this.onSubmit(offre);
    },
    updateTags() {
      this.offre.tags = this.compiledTags;
    },
    updatePreviewImg(event) {
      this.preview = window.URL.createObjectURL(event.target.files[0]);
    },
    entrepriseSubmit() {
      const entrepriseFormdata = new FormData();
      entrepriseFormdata.append("nom", this.entreprise.add);
      AjaxServices.pushInformations("entreprises", entrepriseFormdata)
        .then(data => {
          this.hideEntrepriseModal();
          this.$bvModal.show("modal-succ-entreprise");
        })
        .catch(e => console.log(e));
    },
    hideEntrepriseModal() {
      this.$bvModal.hide("modal-entreprise");
    },
    initDescription() {
      this.offre.description =
        "# Détail de l'offre\n" +
        "---\n" +
        "Écrivez les détails de votre offre ici\n" +
        "\n" +
        "## Missions\n" +
        "Vous pouvez faire différentes parties\n" +
        "- Avec des listes\n" +
        "- non ordonnées\n" +
        "1. mais aussi\n" +
        "2. ordonnées";
    },

    setLocalisation(localisation) {
      this.localisation.search = `${localisation.nom} ${localisation.codesPostaux[0]}, ${localisation.departement.nom}`;
      this.offre.localisation.codeDepartement = localisation.departement.code;
      this.offre.localisation.codeVille = localisation.code;
      this.offre.localisation.ville = localisation.nom;
      this.localisation.showList = false;
    },

    async updateLocalisation() {
      if (this.localisation.search.length === 3) {
        this.localisation.list = await this.$axios.$get('https://geo.api.gouv.fr/communes?nom=' + this.localisation.search + '&fields=nom,code,codesPostaux,codeDepartement,departement,codeRegion&format=json&geometry=centre')
        this.localisation.showList = true
      } else if (this.localisation.search.length < 3) {
        this.localisation.list = []
      }
    },
    setEntreprise(entreprise) {
      this.entreprise.search = entreprise.nom;
      this.offre.entreprise.nom = entreprise.nom;
      this.offre.entreprise.id = entreprise.id;
      this.entreprise.showList = false;
    },
  },
  computed: {
    compiledDescription() {
      if (typeof marked !== "undefined") {
        return marked(this.offre.description);
      } else {
        return "";
      }
    },
    compiledTags() {
      return this.tagsText
        .split(",")
        .map(tag => tag.trim().toLowerCase())
        .filter(tag => tag.length > 0);
    },
    localisationFilter() {
      const sorted = this.localisation.list.filter(localisation =>
        localisation.nom
          .toLowerCase()
          .includes(this.localisation.search.toLowerCase().trim())
      );
      if (sorted.length > 6) {
        return sorted.slice(0, 6);
      } else {
        return sorted;
      }
    },
    entrepriseFilter() {
      const sorted = this.entreprise.list.filter(entreprise =>
        entreprise.nom
          .toLowerCase()
          .includes(this.entreprise.search.toLowerCase().trim())
      );
      if (sorted.length > 6) {
        return sorted.slice(0, 6);
      } else {
        return sorted;
      }
    },
    property() {
      return { cv: this.$getImage(this.candidatureToShow.cv) };
    }
  },
  async mounted() {
    this.initDescription();
    this.entreprise.list = await AjaxServices.getListe("entreprises");
    // Pour init les types d'offres après que le store sois rempli
    const typeOffres = await AjaxServices.getListe("typeOffres");

    if (this.$route.params.slug) {
      this.msgOffre = "L'offre à bien été modifiée";
      AjaxServices.getInformations("listeOffres", this.$route.params.slug)
        .then(data => {
          this.offre.nom = data.nom;
          this.offre.description = data.description;
          this.description = data.description;
          this.offre.shortDescription = data.short_description;
          this.preview = data.image;
          let tags = [];
          data.tags.forEach(tag => tags.push(tag.nom));
          this.tagsText = tags.join();
          this.updateTags();
          this.$store.commit("offretype/setTypes", data.typeoffres);
          this.$axios
            .$get(
              `https://geo.api.gouv.fr/communes/${data.code_ville}?fields=nom,code,codesPostaux,codeDepartement,departement,codeRegion&format=json&geometry=centre`
            )
            .then(loc => {
              if (loc.code === data.code_ville + "") {
                this.setLocalisation(loc);
              }
            });
          this.setEntreprise(data.entreprise);
          this.offre.pourvu = data.pourvu;
          this.typeOffres = typeOffres;
          this.offre.candidatures = data.candidatures;
        })
        .catch(e => console.log(e));
    } else {
      this.typeOffres = typeOffres;
    }
  },
  beforeDestroy() {
    this.$store.commit("offretype/removeTypes");
  }
};
</script>

<style lang="scss" scoped>
h2 {
  font-size: 2.4rem;
}

a,
button {
  font-size: 1.6rem;
  &.contact,
  &.submit {
    padding: 12px;
    display: block;
    text-align: center;
    margin: 0 auto;
    background: var(--primary-jobs);
    border: none;
    width: 245px;
    height: 55px;
    color: white;
    font-size: 2rem;
    text-transform: uppercase;
    font-weight: 900;
    font-family: roboto, sans-serif;
    border-radius: 5px;
  }
}

input,
select {
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

small {
  font-size: 1.2rem;
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

::v-deep p,
::v-deep li {
  font-size: 1.6rem;
}

#pourvu-text {
  font-size: 5rem;
  font-weight: 700;
  color: var(--green);
  margin-top: 20px;
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
    content: url("~static/icons/camera.svg");
    position: absolute;
    pointer-events: none;
    height: 36px;
    opacity: 0.8;
  }

  &:hover::before {
    content: "";
    background-color: #000;
    opacity: 0.2;
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

.autocomplete-input {
  &::after {
    content: url("~@/static/icons/ic_chevron_right_48px.svg");
    position: absolute;
    right: 0;
    bottom: -6px;
    height: 48px;
    width: 48px;
    transform: scale(0.6) rotate(-90deg);
    transition: transform 0.3s ease;
  }
  &.toggled::after {
    transform: scale(0.6) rotate(90deg);
  }
}
.autocomplete-list {
  top: 32px;
  z-index: 100;
  width: 100%;
  list-style: none;
  padding: 6px 0;
  position: relative;
  border-radius: 0 0 6px 6px;
  border: 2px solid black;
  li {
    padding: 4px 12px;
    cursor: pointer;
    position: relative;
    &.localisation-item {
      padding: 4px 12px 4px 38px;
    }
    &.localisation-item::after {
      content: url("~@/static/icons/ic_location_on_48px.svg");
      transform: scale(0.5);
      display: block;
      position: absolute;
      top: -10px;
      left: -4px;
    }
    &:hover {
      background-color: #eeeeee;
    }
  }
}


</style>
