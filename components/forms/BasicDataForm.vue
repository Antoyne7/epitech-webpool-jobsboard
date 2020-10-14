<template>
  <b-modal id="basic-form-modal" hide-header hide-footer>
    <div class="main px-3">
      <h2 class="mb-4"><slot></slot></h2>
      <b-form @submit.prevent="submitFunction({ id: id, nom: nom })">
        <label class="d-none" for="nom">Nom</label>
        <input
          v-model="nom"
          type="text"
          id="nom"
          name="nom"
          placeholder="Entrez un nom"
        />
        <div class="d-flex justify-content-center mt-4">
          <b-button class="mx-auto" type="submit">Enregistrer</b-button>
        </div>
      </b-form>
    </div>
  </b-modal>
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
  data() {
    return {
      id: null,
      nom: ""
    }
  },
  methods: {
    updateData() {
      console.log('update');
      if (this.dataObject !== null) {
        this.id = this.dataObject.id;
        this.nom = this.dataObject.nom;
      }
    }
  },
  watch: {
    dataObject: {
      handler: 'updateData'
    }
  }
};
</script>

<style scoped lang="scss">
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
  &[type="submit"] {
    background: var(--primary-jobs);
    padding: 8px 12px;
    text-transform: uppercase;
    font-weight: bold;
  }
}

.container-cards {
  margin: 30px auto;
}

.main {
  max-width: 420px;
  margin: 30px auto 40px;

  input {
    width: 100%;
    padding: 6px 12px;
    border-radius: 0;
    border: 1px solid black;
  }
}
</style>
