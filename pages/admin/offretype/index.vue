<template>
  <div>
    <DataDeletion ref="deleteComponent" type="typeOffres" :data-id="toDelete">On supprime mon pote typeoffre
    </DataDeletion>

    <BasicDataForm
      id="formmodal"
      :data-object="toEdit"
      :submit-function="formSubmitFunc"
    >
      {{ formText }}
    </BasicDataForm>

    <ModalSuccess :route="$route" id="modal-success" :message="successText" :isCentered="true" />


    <b-container class="my-5">
      <b-row class="justify-content-between">
        <b-button variant="light" @click="$router.back()" class="back text-uppercase font-weight-bold d-flex align-items-center">
          <img src="~/static/icons/ic_chevron_right_48px.svg" alt="Retour page précédente">
          Retour
        </b-button>
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

    
    <b-container class="container-cards">
      <DataCard v-for="typeOffre in listeTypeOffres" 
                v-bind:key="typeOffre.id" 
                :delete-function="deleteFunction"
                :data="typeOffre"
                @edit="openFormModal('edit', typeOffre)"
                >
        {{ typeOffre.nom }}
      </DataCard>
    </b-container>
  </div>
</template>

<script>
import DataCard from "@/components/DataCard";
import BasicDataForm from "@/components/forms/BasicDataForm";
import DataDeletion from "@/components/DataDeletion";
import ModalSuccess from "@/components/ModalSuccess";

export default {
  name: "Index",
  components: {
    DataCard,
    DataDeletion,
    BasicDataForm,
    ModalSuccess
  },
  data() {
    return {
      listeTypeOffres: [],
      toDelete: null,
      toEdit: null,
      formText: null,
      formType: "create",
      successText: null
    }
  },
  created() {
    this.updateList()
    const self = this
    this.$nuxt.$on('deletion', function () {
      console.log('emit recept')
      self.updateList()
    })
  },
  methods: {
    deleteFunction(id) {
      this.toDelete = id
      this.$refs.deleteComponent.deleteModal(this.toDelete)
    },
    updateList() {
      this.$axios.$get("/back/api/typeoffres").then(promise => {
        this.listeTypeOffres = promise;
      })
    },
    openFormModal(type, objet) {
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
      this.$axios
        .$post("/back/api/typeoffres", formdata)
        .then(data => {
          if (data.id) {
            this.updateList();
            this.successText = 'Type de contrat créer.'
            this.$bvModal.show('modal-success')
            this.$bvModal.hide("basic-form-modal");
          }
        })
        .catch(e => console.log(e));
    },
    update(objet) {
      // Update, afficher animation success puis retour a la liste des entreprise
      this.$axios
        .$put("/back/api/typeoffres/" + objet.id, objet)
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
}
</script>

<style scoped lang="scss">
button, a, p, div {
  font-size: 1.6rem;
}

button, a {
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
