<template>
  <div class="w-100">
    <b-modal
      id="modal-candidature"
      title="Candidature"
      hide-footer
      hide-header
      centered
      size="lg"
    >
      <div v-if="candidatureToShow !== null" class="p-4">
        <h2>
          Candidature de {{ candidatureToShow.utilisateur.prenom }}
          {{ candidatureToShow.utilisateur.nom.toUpperCase() }}
        </h2>
        <p>Envoyé le {{ getDate(candidatureToShow.created_at) }}</p>
        <p>
          {{ candidatureToShow.text }}
        </p>
        <button
          @click="show = true"
          class="btn-outline-dark d-flex btn-cv align-items-center p-3 my-3"
        >
          <span class="mr-2">
            Voir le CV
          </span>
          <img
            id="cvShow"
            src="~/static/icons/eye.svg"
            style="width:30px;"
            alt="Voir le cv"
          />
        </button>
        <Lightbox
          v-bind="property"
          @hide="show = false"
          v-show="show"
        ></Lightbox>
        <div>
          <a
            :href="`mailto:${candidatureToShow.utilisateur.email}`"
            class="contact"
            target="__blank"
          >
            Contacter
          </a>
        </div>
      </div>
    </b-modal>
    <div
      v-if="offre && !offre.pourvu && offre.candidatures.length > 0"
      id="candidatures"
      class="mb-4"
    >
      <h2 class="col-12">Candidatures</h2>
      <div class="d-flex flex-wrap col-12">
        <div
          class="mb-3 col-sm-6 col-lg-4 col-12"
          v-for="candidature in offre.candidatures"
          v-bind:key="candidature.id"
        >
          <div class="card p-4">
            <div class="card-title">
              <img
                v-if="candidature.utilisateur.image"
                :src="$getImage(candidature.utilisateur.image)"
                alt="Image de l'utilisateur"
              />
              <b-icon-person v-else scale="2" />
              <h4 class="d-flex flex-wrap mb-0 ml-3">
                {{ candidature.utilisateur.prenom }}
                {{ candidature.utilisateur.nom.toUpperCase() }}
              </h4>
            </div>
            <p>
              {{
                candidature.text.length > 50
                  ? candidature.text.slice(0, 50) + "..."
                  : candidature.text
              }}
            </p>
            <button
              type="button"
              class="bg-blue-jobs rounded-lg px-4 py-2"
              @click="showCandidature(candidature)"
            >
              Voir
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Lightbox from "~/components/Lightbox";

export default {
  name: "ListeCandidatures",
  components: {
    Lightbox
  },
  props: {
    offre: null
  },
  data() {
    return {
      candidatureToShow: null,
      show: false
    };
  },
  methods: {
    showCandidature(candidature) {
      this.candidatureToShow = candidature;
      this.$bvModal.show("modal-candidature");
      this.$axios.$get("/back/api/candidatures/" + candidature.id + "/seen");
    },
    getDate(dateString) {
      const date = new Date(dateString);
      const minutes =
        date.getMinutes() < 10 ? "0" + date.getMinutes() : date.getMinutes();
      // Pour une raison inconnue il faut month +1
      return `${date.getDate()}/${date.getMonth() +
        1}/${date.getFullYear()} ${date.getHours()}H${minutes}`;
    }
  }
};
</script>

<style scoped lang="scss">
a,
button {
  font-size: 1.6rem;
  &.btn-cv {
    background-color: transparent;
    &:hover {
      background-color: lightgray;
      color: black;
    }
  }
  &.contact,
  &.submit {
    background: transparent;
    border: 2px solid black;
    padding: 12px;
    text-decoration: none;
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
    &:hover {
      background-color: var(--primary-jobs-hover);
    }
  }
}

p {
  font-size: 1.6rem;
}

//  Candidature
.candidature {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  padding: 10px 15px;
  margin: 10px 0;

  h4 {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    font-weight: 500;
    font-size: 2rem;

    span {
      font-size: 1.6rem;
      font-weight: 400;
    }
  }

  p {
    margin-top: 10px;
    font-weight: 400;
    font-size: 1.6rem;
  }

  a {
    margin: 15px auto 10px;
    display: flex;
    width: 200px;
    height: 40px;
    background: var(--primary-jobs);
    justify-content: center;
    align-items: center;
    color: white;
    text-decoration: none;
    font-size: 1.6rem;
    text-transform: uppercase;
    font-weight: bold;
    border-radius: 5px;
  }
}

// cards
.card {
  height: 100%;

  display: flex;
  flex-direction: column;

  h4 {
    flex: 1 0 auto;
  }

  button {
    width: fit-content;
    margin: 0 auto;
  }

  .card-title {
    display: flex;
    align-items: center;
    img {
      width: 30px;
      height: 30px;
      border-radius: 30px;
      object-fit: cover;
    }
  }
}
</style>
