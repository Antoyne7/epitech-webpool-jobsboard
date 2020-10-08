<template>
  <div>
    <SearchBar/>
    <b-container class="container-cards">
      <b-row>
        <JobCard v-for="offre in showOffres" :title="offre.nom"
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
import AjaxServices from "~/services/ajaxServices"

export default {
  components: {JobCard, SearchBar},
  // middleware: 'auth',
  data() {
    return {
      listeOffres: [],
      listeToShow: [],
      nbrShowed: 1,
    }
  },
  created() {
    AjaxServices.getListe('listeOffres').then(promise => {
      console.log(promise)
      this.listeOffres = promise;
    })
  },
  methods: {
    //Honnêtement ce code est assez immonde donc bon
    //TODO: Changer cette fonctionnatée immonde
    showMore() {
      if ((this.nbrShowed * 6) < this.listeOffres.length) {
        this.nbrShowed++;
        this.goto()
      }
    },
    goto() {
      if (document.querySelectorAll('.container-cards .row > div').length > 6) {
        let number = (6 * (this.nbrShowed - 1) + 1);
        document.querySelector(".container-cards .row div:nth-child(" + number + ")").scrollIntoView()
      } else {
        setTimeout(this.goto, 50);
      }
    },
  },
  computed: {
    showOffres() {
      if (typeof window !== "undefined") {
        if (window.innerWidth < 992) {
          this.listeToShow = [...this.listeOffres].slice(0, 6 * this.nbrShowed)
        } else {
          this.listeToShow = [...this.listeOffres].slice(0, 6 * this.nbrShowed)
        }
      }
      return this.listeToShow
    }
  }
  ,

}
</script>
<style lang="scss">
html {
  scroll-behavior: smooth;
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

