<template>
  <div>
    <DataDeletion ref="deleteComponent" type="entreprises" :data-id="toDelete"
      >On supprime mon pote entreprise
    </DataDeletion>

    <BasicDataForm
      id="formmodal"
      :data-object="toEdit"
      :submit-function="formSubmitFunc"
    >
      {{ formText }}
    </BasicDataForm>

    <ModalSuccess :route="$route" id="modal-success" :message="successText" :isCentered="true" />

    <!-- Boutons back et ajout -->
    <b-container class="my-5">
      <b-row class="justify-content-between">
        <b-button
          variant="light"
          @click="$router.back()"
          class="back text-uppercase font-weight-bold d-flex align-items-center"
        >
          <img
            src="~/static/icons/ic_chevron_right_48px.svg"
            alt="Retour page précédente"
          />
          Retour
        </b-button>
        <div>
          <!-- :to="{ name: 'admin-entreprise-add' }" -->
          <b-button
            class="new-offre"
            variant="light"
            @click="openFormModal('create')"
          >
            <b-icon-plus-square class="mr-2" />
            Nouvelle entreprise
          </b-button>
        </div>
      </b-row>
    </b-container>

    <b-container>
      <div class="container-cards" v-if="entreprises.length > 0 && loaded === true">
        <DataCard
          v-for="entreprise in entreprises"
          v-bind:key="entreprise.id"
          :data="entreprise"
          :delete-function="deleteFunction"
          @edit="openFormModal('edit', entreprise)"
        >
          {{ entreprise.nom }}
        </DataCard>
      </div>   
      <div class="msg" v-else-if="loaded === true">
        Il n'y a aucune entreprise dans la base de données.
      </div>
      <b-row class="px-4" v-else>
        <ContentLoader
          v-for="skeleton in 9"
          :key="'skeletonEntreprise' + skeleton"
          height="44"
          width="1400"
          class="w-100 skeleton"
        />
      </b-row>
    </b-container>
    
  </div>
</template>

<script>
import DataCard from "@/components/DataCard";
import AjaxServices from "@/services/ajaxServices";
import BasicDataForm from "@/components/forms/BasicDataForm";
import DataDeletion from "@/components/DataDeletion";
import ModalSuccess from "@/components/ModalSuccess";
import { ContentLoader } from "vue-content-loader";

export default {
  name: "Index",
  components: {
    DataCard,
    DataDeletion,
    BasicDataForm,
    ModalSuccess,
    ContentLoader
  },
  data() {
    return {
      entreprises: [],
      toDelete: null,
      toEdit: null,
      formText: null,
      formType: "create",
      successText: null,
      loaded: false
    };
  },
  created() {
    this.updateList();
    const self = this;
    this.$nuxt.$on("deletion", function() {
      console.log("emit recept");
      self.updateList();
    });
  },
  methods: {
    deleteFunction(id) {
      this.toDelete = id;
      this.$refs.deleteComponent.deleteModal(this.toDelete);
    },
    updateList() {
      this.loaded = false
      AjaxServices.getListe("entreprises").then(promise => {
        this.entreprises = promise;
        const self = this
        setTimeout(() => self.loaded = true, 200)
      });
    },
    openFormModal(type, objet) {
      this.formType = type;
      if (type === "create") {
        this.toEdit = null;
        this.formText = "Creez une nouvelle entreprise.";
      } else {
        this.toEdit = objet;
        this.formText = `Modifiez l'entreprise ${objet.nom}.`;
      }
      this.$bvModal.show("basic-form-modal");
    },
    create(objet) {
      const formdata = new FormData();
      formdata.append("nom", objet.nom);
      this.$axios
        .$post("/back/api/entreprises", formdata)
        .then(data => {
          if (data.id) {
            this.updateList();
            this.successText = 'Entreprise créer.'
            this.$bvModal.show('modal-success')
            this.$bvModal.hide("basic-form-modal");
          }
        })
        .catch(e => console.log(e));
    },
    update(objet) {
      // Update, afficher animation success puis retour a la liste des entreprise
      this.$axios
        .$put("/back/api/entreprises/" + objet.id, objet)
        .then(() => {
          this.updateList();
          this.successText = 'Modification effectuée.'
          this.$bvModal.show('modal-success')
          this.$bvModal.hide("basic-form-modal");
        })
        .catch(e => console.log(e));
    }
  },
  computed: {
    formSubmitFunc() {
      if (this.formType === "create") {
        return this.create;
      } else {
        return this.update;
      }
    }
  }
};
</script>

<style scoped lang="scss">
.skeleton {
  margin: 4px 0;
  height: 44px;
  border-radius: 0.3rem;
  overflow: hidden;
}

button,
a,
p,
div {
  font-size: 1.6rem;
}

button,
a {
  border-radius: 6px;
  padding: 6px 12px;
  &.new-offre {
    font-weight: bold;
  }
  &.back {
    img {
      transform: rotate(180deg);
      width: 24px;
    }
  }
}

.container-cards {
  margin: 30px auto;
}
</style>
