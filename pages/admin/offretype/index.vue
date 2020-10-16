<template>
  <div>
    <DataDeletion route="/admin/offretype"
                  message-success="Le type de contrat a bien été supprimé !"
                  :with-success="true"
                  @deletion="deletionComplete()"
                  title="Attention"
                  ref="deleteComponent" type="typeoffres"
                  :data-id="toDelete"
    >Voulez-vous vraiment supprimer ce type de contrat ?
    </DataDeletion>

    <BasicDataForm
      id="formmodal"
      :data-object="toEdit"
      :submit-function="formSubmitFunc"
      :error="error"
      :errMsg="errMsg"
    >
      {{ formText }}
    </BasicDataForm>

    <ModalSuccess
      :route="$route"
      id="modal-success"
      :message="successText"
      :isCentered="true"
    />

    <b-container class="my-5">
      <b-row class="justify-content-between">
        <BackButton/>
        <div>
          <b-button
            class="new-offre"
            variant="light"
            @click="openFormModal('create')"
          >
            <b-icon-plus-square class="mr-2" />
            Nouveau type de contrat
          </b-button>
        </div>
      </b-row>
    </b-container>

    <b-container class="px-3 container-cards">
      <div
        class="container-cards"
        v-if="listeTypeOffres.length > 0 && loaded === true"
      >
        <DataCard
          v-for="typeOffre in listeTypeOffres"
          v-bind:key="typeOffre.id"
          :delete-function="deleteFunction"
          :data="typeOffre"
          @edit="openFormModal('edit', typeOffre)"
        >
          {{ typeOffre.nom }}
        </DataCard>
      </div>
      <div class="msg" v-else-if="loaded === true">
        Il n'y a aucune entreprise dans la base de données.
      </div>
      <b-row v-else>
        <ContentLoader
          v-for="skeleton in 9"
          :key="'skeletonTypeOffre' + skeleton"
          height="44"
          width="1300"
          class="w-100 skeleton"
        />
      </b-row>
    </b-container>
  </div>
</template>

<script>
import DataCard from "@/components/DataCard";
import BasicDataForm from "@/components/forms/BasicDataForm";
import DataDeletion from "@/components/DataDeletion";
import ModalSuccess from "@/components/ModalSuccess";
import param from "@/param/param";
import {ContentLoader} from "vue-content-loader";
import BackButton from "@/components/BackButton";

export default {
  head() {
    return {
      title: 'Jobs - type de contrats'
    }
  },
  name: "Index",
  components: {
    BackButton,
    DataCard,
    DataDeletion,
    BasicDataForm,
    ModalSuccess,
    ContentLoader
  },
  data() {
    return {
      listeTypeOffres: [],
      toDelete: null,
      toEdit: null,
      formText: null,
      formType: "create",
      successText: null,
      loaded: false,
      error: false,
      errMsg: ''
    };
  },
  created() {
    this.updateList();
    const self = this;
    this.$nuxt.$on("deletion", function() {
      self.updateList();
    });
  },
  methods: {
    deletionComplete() {
      this.updateList();
    },
    deleteFunction(id) {
      this.toDelete = id;
      this.$refs.deleteComponent.deleteModal(this.toDelete);
    },
    updateList() {
      this.loaded = false;
      this.$axios.$get("/back/api/typeoffres").then(promise => {
        this.listeTypeOffres = promise;
        const self = this;
        setTimeout(() => (self.loaded = true), 200);
      });
    },
    setError(msg = null) {
      this.error = true
      this.errMsg = msg || param.message.errDefault
    },
    openFormModal(type, objet) {
      this.error = false
      this.errMsg = ''
      this.formType = type;
      if (type === "create") {
        this.toEdit = null;
        this.formText = "Creez un nouveau type de contrat.";
      } else {
        this.toEdit = objet;
        this.formText = `Modifiez le type de contrat ${objet.nom}.`;
      }
      this.$bvModal.show("basic-form-modal");
    },
    create(objet) {
      const formdata = new FormData();
      formdata.append("nom", objet.nom);
      this.$axios.$post("/back/api/typeoffres", formdata).then(response => {
        console.log(response)
        if (response.status_code === 200) {
          this.updateList();
          this.successText = "Type de contrat crée.";
          this.$bvModal.show("modal-success");
          this.$bvModal.hide("basic-form-modal");
        } else {
          this.setError(response.message)
        }
      })
        .catch(e => {
          console.dir(e)
          this.setError()
        });
    },
    update(objet) {
      // Update, afficher animation success puis retour a la liste des entreprise
      this.$axios
        .$put("/back/api/typeoffres/" + objet.id, objet)
        .then((data) => {
          if (data.status_code === 200) {
          this.updateList();
          this.successText = "Modifications effectuées.";
          this.$bvModal.show("modal-success");
          this.$bvModal.hide("basic-form-modal");
          } else {
            this.setError(data.message)
          }
        })
        .catch(e => this.setError());
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
