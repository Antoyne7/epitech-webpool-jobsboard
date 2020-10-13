<template>
  <div>
    <SearchBar />
    <b-container class="container-cards">
      <b-row>
        <ContentLoader
          v-for="skeleton in 6"
          v-bind:key="'skeleton'+skeleton"
          v-show="!charged"
          height="500"
          class="skeleton col-lg-4 col-md-6 col-12 w-100 skeleton"
        />
        <JobCard
          v-for="offre in showOffres"
          v-bind:key="offre.id"
          :title="offre.nom"
          :short-description="offre.short_description"
          :linkId="offre.id"
          :img="offre.image"
          :localisation="offre.localisation"
        />
      </b-row>
      <button @click="showMore()" class="btn-show">Voir plus</button>
    </b-container>
  </div>
</template>

<script>
import SearchBar from "~/components/SearchBar";
import JobCard from "~/components/JobCard";
import AjaxServices from "~/services/ajaxServices";
import { ContentLoader } from "vue-content-loader";

export default {
  name: "Index",
  components: { JobCard, SearchBar, ContentLoader },
  middleware: "auth",
  data() {
    return {
      listeOffres: [],
      listeToShow: [],
      nbrShowed: 1,
      charged: false
    };
  },
  created() {
    this.$auth.fetchUser();
    this.$axios.$get("/back/api/offres").then(promise => {
      console.log(promise);
      this.listeOffres = promise;
      this.charged = true;
    });
  },
  methods: {
    //Honnêtement ce code est assez immonde donc bon
    //TODO: Changer cette fonctionalitée immonde
    showMore() {
      if (this.nbrShowed * 6 < this.listeOffres.length) {
        this.nbrShowed++;
        this.goto();
      }
    },
    goto() {
      let number = 6 * (this.nbrShowed - 1) + 7;
      if (
        document.querySelector(
          ".container-cards .row div:nth-child(" + number + ")"
        )
      ) {
        document
          .querySelector(".container-cards .row div:nth-child(" + number + ")")
          .scrollIntoView();
      } else {
        setTimeout(this.goto, 50);
      }
    }
  },
  computed: {
    showOffres() {
      if (typeof window !== "undefined") {
        if (window.innerWidth < 992) {
          this.listeToShow = [...this.listeOffres].slice(0, 6 * this.nbrShowed);
        } else {
          this.listeToShow = [...this.listeOffres].slice(0, 6 * this.nbrShowed);
        }
      }
      return this.listeToShow;
    }
  }
};
</script>
<style lang="scss">
html {
  scroll-behavior: smooth;
}

.skeleton {
  margin: 20px 0;
}

.container-cards {
  margin: 70px auto 50px;
}

.btn-show {
  width: 220px;
  height: 50px;
  background: var(--primary-jobs);
  border: none;
  border-radius: 5px;
  color: white;
  font-weight: 700;
  font-size: 18px;
  text-transform: uppercase;
  margin: 30px auto 10px;
  display: block;
}
</style>
