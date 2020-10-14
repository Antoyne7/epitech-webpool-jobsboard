<template>
  <b-col lg="4" md="6" cols="12">
    <div class="card-container">
      <h3>{{ title }}</h3>
      <br v-if="title.length < 22">
      <!--      <p>{{localisation}}</p>-->
      <p>{{ descriptionFunc(shortDescription) }}</p>
      <br v-if="shortDescription.length < 100">
      <div class="type-container">
        <span v-for="type in typesOffres">{{ type.nom }}</span>
      </div>

      <img :src="img" alt="Image de l'offre">
      <b-row class="admin-buttons w-100 mt-3 justify-content-end" v-if="adminView">
        <b-button class="mx-2">
          TOGL
        </b-button>
        <b-button class="mx-2">
          EDIT
        </b-button>
        <b-button class="ml-2">
          VIEW
        </b-button>
      </b-row>
      <nuxt-link :title="title_card" v-else :to="{name:'slug', params:{slug: linkId}}">
        <button :disabled="isDisable">En savoir plus</button>
      </nuxt-link>
    </div>
  </b-col>
</template>

<script>

export default {
  name: "JobCard",
  data() {
    return {
      title_card: null,
      isDisable: false,
      candidatures: null,
      typesOffres: [],
    }
  },
  props: ['title', 'shortDescription', 'img', 'linkId', 'localisation', 'adminView', 'types'],
  created() {
    this.typesOffres = this.types;
    console.log(this.typesOffres)
    this.title_card = this.title
    if (!this.adminView && this.$auth.user.candidatures) {
      this.candidatures = this.$auth.user.candidatures;
      this.candidatures.forEach((el) => {
        if (el.offre_id === this.linkId) {
          this.title_card = "Vous avez déjà postulé à cette offre !";
          this.isDisable = true;
        }
      })
    }
  },
  methods: {
    descriptionFunc(desc) {
      if (desc.length > 100) {
        return desc.slice(0, 100) + "..."
      } else {
        return desc
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.card-container {
  background: white;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  height: 600px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  @media(max-width: 1100px) {
    height: 540px;
  }
  @media(max-width: 992px) {
    height:640px;
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

  .type-container {
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    height: fit-content;

    span {
      margin: 5px;
      font-size: 1.3rem;
      background: var(--primary-jobs);
      border: solid 1px var(--primary-jobs);
      border-radius: 5px;
      color: white;
      font-weight: 500;
      text-transform: capitalize;
      padding: 5px 10px;

    }
  }
}
</style>
