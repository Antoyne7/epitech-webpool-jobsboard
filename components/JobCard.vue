<template>
  <b-col lg="4" md="6" cols="12">
    <div class="card-container">
      <div v-if="pourvuValue && adminView" id="pourvu-tag">
        Pourvu
      </div>
      <div id="candids-tag" v-else-if="countNewCandidatures() > 0 && adminView">
        {{ countNewCandidatures() }}
      </div>

      <h3>{{ title }}</h3>
      <br v-if="title.length < 22" />
      <!-- <div v-if="offre.ville">{{ offre.ville }}</div> -->
      <p>{{ descriptionFunc(shortDescription) }}</p>

      <br v-if="shortDescription.length < 100" />
      <div class="type-container">
        <span v-for="type in typesOffres" :key="'type' + type.id">{{
          type.nom
        }}</span>
      </div>
      <img :src="img" alt="Image de l'offre" />
      <b-row
        class="admin-buttons w-100 mt-3 justify-content-end"
        v-if="adminView"
      >
        <b-button
          @click="$emit('delete-offre')"
          variant="danger"
          class="mr-auto danger"
        >
          <b-icon-trash-fill></b-icon-trash-fill>
        </b-button>
        <b-button
          class="mx-2"
          :class="!pourvuValue ? '' : 'btn-success'"
          @click="toggleOffre"
        >
          <b-icon-check class="w-100"></b-icon-check>
        </b-button>
        <b-button
          variant="primary"
          :to="{ name: 'admin-offre-slug-edit', params: { slug: linkId } }"
          class="mx-2 my-0 d-flex align-items-center justify-content-center bg-blue-jobs"
        >
          <svg
            style="width: 90%"
            width="32"
            height="32"
            viewBox="0 0 32 32"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              d="M27.5 26.125H4.5C3.94687 26.125 3.5 26.5719 3.5 27.125V28.25C3.5 28.3875 3.6125 28.5 3.75 28.5H28.25C28.3875 28.5 28.5 28.3875 28.5 28.25V27.125C28.5 26.5719 28.0531 26.125 27.5 26.125ZM8.05313 23.5C8.11563 23.5 8.17813 23.4938 8.24063 23.4844L13.4969 22.5625C13.5594 22.55 13.6188 22.5219 13.6625 22.475L26.9094 9.22812C26.9383 9.19921 26.9613 9.16487 26.977 9.12707C26.9927 9.08927 27.0008 9.04874 27.0008 9.00781C27.0008 8.96688 26.9927 8.92636 26.977 8.88855C26.9613 8.85075 26.9383 8.81641 26.9094 8.7875L21.7156 3.59063C21.6563 3.53125 21.5781 3.5 21.4937 3.5C21.4094 3.5 21.3313 3.53125 21.2719 3.59063L8.025 16.8375C7.97812 16.8844 7.95 16.9406 7.9375 17.0031L7.01562 22.2594C6.98522 22.4268 6.99609 22.5991 7.04727 22.7613C7.09846 22.9236 7.18842 23.071 7.30937 23.1906C7.51562 23.3906 7.775 23.5 8.05313 23.5V23.5Z"
              fill="white"
            />
          </svg>
        </b-button>
        <b-button
          variant="primary"
          :to="{ name: 'slug', params: { slug: linkId } }"
          class="ml-2 mr-0 my-0 d-flex align-items-center justify-content-center bg-blue-jobs"
        >
          <svg
            style="width: 90%"
            xmlns="http://www.w3.org/2000/svg"
            width="48"
            height="48"
            viewBox="0 0 48 48"
          >
            <title>voir</title>
            <g class="nc-icon-wrapper" fill="white">
              <path
                d="M24 9C14 9 5.46 15.22 2 24c3.46 8.78 12 15 22 15s18.54-6.22 22-15C42.54 15.22 34.01 9 24 9zm0 25c-5.52 0-10-4.48-10-10s4.48-10 10-10 10 4.48 10 10-4.48 10-10 10zm0-16c-3.31 0-6 2.69-6 6s2.69 6 6 6 6-2.69 6-6-2.69-6-6-6z"
              />
            </g>
          </svg>
        </b-button>
      </b-row>
      <nuxt-link
        :title="title_card"
        v-else
        :to="{ name: 'slug', params: { slug: linkId } }"
      >
        <!--   :to="{ name: 'slug', params: { slug: stringToSlug(title, linkId), id: linkId }}"-->
        <button :disabled="isDisable">En savoir plus</button>
      </nuxt-link>
    </div>
  </b-col>
</template>

<script>
import editIcone from "~/static/icons/edit.svg";

export default {
  name: "JobCard",
  props: [
    "title",
    "shortDescription",
    "img",
    "linkId",
    "localisation",
    "adminView",
    "pourvu",
    "candidaturesProp",
    "types"
  ],
  data() {
    return {
      icones: {
        edit: editIcone
      },
      pourvuValue: this.pourvu,
      title_card: null,
      isDisable: false,
      candidatures: null,
      typesOffres: []
    };
  },
  created() {
    this.typesOffres = this.types;
    console.log(this.typesOffres);
    this.title_card = this.title;
    if (!this.adminView && this.$auth.user.candidatures) {
      this.candidatures = this.$auth.user.candidatures;
      this.candidatures.forEach(el => {
        if (el.offre_id === this.linkId) {
          this.title_card = "Vous avez déjà postulé à cette offre !";
          this.isDisable = true;
        }
      });
    }
  },

  methods: {
    stringToSlug(str, id) {
      str = str.replace(/^\s+|\s+$/g, ""); // trim
      str = str.toLowerCase();

      let from = "àáäâèéëêìíïîòóöôùúüûñç·/_,:;";
      let to = "aaaaeeeeiiiioooouuuunc------";
      for (let i = 0, l = from.length; i < l; i++) {
        str = str.replace(new RegExp(from.charAt(i), "g"), to.charAt(i));
      }

      str = str
        .replace(/[^a-z0-9 -]/g, "") // remove invalid chars
        .replace(/\s+/g, "-") // collapse whitespace and replace by -
        .replace(/-+/g, "-"); // collapse dashes
      return str + "-" + id;
    },
    descriptionFunc(desc) {
      if (desc && desc.length > 100) {
        return desc.slice(0, 100) + "...";
      } else {
        return desc;
      }
    },
    toggleOffre() {
      this.$axios
        .$put(`/back/api/offres/${this.linkId}/toggle`)
        .then(() => (this.pourvuValue = !this.pourvuValue));
    },
    countNewCandidatures() {
      return this.candidaturesProp.filter(candid => candid.seen === 0).length;
    }
  }
};
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
  @media (max-width: 1100px) {
    height: 540px;
  }
  @media (max-width: 992px) {
    height: 640px;
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

  #pourvu-tag,
  #candids-tag {
    font-size: 1.4rem;
    font-weight: bold;
    text-transform: uppercase;
    display: flex;
    justify-content: center;
    align-items: center;
    // box-shadow: 1px 4px 4px 0px rgba(0, 0, 0, 0.22); // c'est pas ouf
    position: absolute;
    top: 6px;
    left: 8px;
    padding: 1px 10px;
    color: white;
    border-radius: 6px;
  }
  #candids-tag {
    background-color: var(--red);
  }
  #pourvu-tag {
    background-color: var(--green);
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

  .admin-buttons {
    align-items: flex-end;
    & button,
    & a {
      width: 42px;
      height: 42px;
      border-radius: 5px;
      display: flex;
      align-items: center;
      justify-content: center;
      svg {
        width: 70%;
        height: auto;
      }
    }
    & button.danger {
      background-color: var(--red);
      &:hover {
        opacity: 0.9;
      }
    }
  }

  .type-container {
    width: 100%;
    display: flex;
    flex-wrap: wrap;
    height: fit-content;

    span {
      margin: 3px;
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
