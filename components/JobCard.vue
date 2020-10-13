<template>
  <b-col lg="4" md="6" cols="12">z
    <div class="card-container">
      <h3>{{ offre.nom }}</h3>
      <br v-if="offreProp.nom.length < 22" />
      <!-- <div v-if="offre.ville">{{ offre.ville }}</div> -->
      <p>{{ descriptionFunc(offre.short_description) }}</p>
      <br v-if="offre.short_description && offre.short_description.length < 100" />
      <img :src="offre.image" alt="Image de l'offre" />
      <b-row
        class="admin-buttons w-100 mt-3 justify-content-end"
        v-if="adminView">
        <p>
          {{ getNewOffers() }}
        </p>
        <p
          class="d-flex align-items-center m-0 mr-2"
          v-if="Number(pourvuValue) === 1">
          Pourvu !
        </p>
        <b-button
          class="mx-2"
          :class="Number(pourvuValue) === 0 ? '' : 'btn-success'"
          @click="toggleOffre">
          <b-icon-check class="w-100"></b-icon-check>
        </b-button>
        <b-button
          :to="{ name: 'admin-offre-slug-edit', params: { slug: offre.id } }"
          class="mx-2 my-0 d-flex align-items-center justify-content-center bg-blue-jobs">
          <b-icon-pencil-square></b-icon-pencil-square>
        </b-button>
        <b-button @click="$emit('delete-offre')" class="ml-2 btn-danger">
          <b-icon-trash-fill></b-icon-trash-fill>
        </b-button>
      </b-row>
      <nuxt-link
        :title="title_card"
        v-else
        :to="{ name: 'slug', params: { slug: offre.id } }">
        <button :disabled="isDisable">En savoir plus</button>
      </nuxt-link>
    </div>
  </b-col>
</template>

<script>
export default {
  name: "JobCard",
  props: [
    "offreProp",
    "adminView"
  ],
  data() {
    return {
      offre: [...this.offreProp],
      pourvuValue: this.offreProp.pourvu,
      title_card: null,
      isDisable: false,
      candidatures: null
    };
  },
  created() {
    this.title_card = this.offre.nom;
    if (!this.adminView && this.$auth.user.candidatures) {
      this.candidatures = this.$auth.user.candidatures;
      this.candidatures.forEach(el => {
        if (el.offre_id === this.offre.id) {
          this.title_card = "Vous avez déjà postulé à cette offre !";
          this.isDisable = true;
        }
      });
    }
  },
  methods: {
    descriptionFunc(desc) {
      if (desc && desc.length > 100) {
        return desc.slice(0, 100) + "...";
      } else {
        return desc;
      }
    },
    toggleOffre() {
      this.$axios
        .$put(`/back/api/offres/${this.offre.id}/toggle`)
        .then(() => (this.pourvuValue = !this.pourvuValue));
    },
    getNewOffers() {
      console.log(this.offre)
      return 'en cours'
    }
  }
};
</script>

<style lang="scss" scoped>
.card-container {
  background: white;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  height: 500px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  @media (max-width: 1100px) {
    height: 430px;
  }
  @media (max-width: 992px) {
    height: 540px;
  }
  margin: 15px 0;

  :not(.admin-buttons) button {
    width: 220px;
    height: 50px;
    background: var(--primary-jobs);
    border: none;
    border-radius: 5px;
    color: white;
    font-weight: 700;
    font-size: 18px;
    text-transform: uppercase;
  }

  button[disabled] {
    background: grey !important;
  }

  img {
    width: 100%;
  }

  h3 {
    font-size: 1.8rem;
    font-weight: 700;
    text-transform: uppercase;
    text-align: center;
    padding: 0 0 10px;
  }

  p {
    font-size: 1.4rem;
  }

  a {
    display: block;
    width: fit-content;
    margin: 10px auto;
    align-self: flex-end;
  }

  .admin-buttons button,
  .admin-buttons a {
    width: 42px;
    svg {
      width: 70%;
      height: auto;
    }
  }
  .admin-buttons a {
    height: 100%;
  }
}
</style>
