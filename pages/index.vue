<template>
  <div>
    <SearchBar @type="changeType($event)" @query="searchQuery($event)"/>
    <b-container class="container-cards">
      <b-row v-if="showOffres.length > 0">
        <ContentLoader v-for="skeleton in 6" v-show="!charged" height="500"
                       class="skeleton col-lg-4 col-md-6 col-12 w-100 skeleton"/>
        <JobCard v-for="offre in showOffres" :title="offre.nom"
                 :short-description="offre.short_description"
                 :linkId="offre.id"
                 :img="offre.image"
                 :localisation="offre.localisation"
        />

      </b-row>
      <div class="msg" v-else>
        Il n'y a aucune offre disponibles pour vos critères.
      </div>
      <button v-show="showBtn" @click="showMore()" class="btn-show">Voir plus</button>
    </b-container>
  </div>
</template>

<script>
import SearchBar from "~/components/SearchBar";
import JobCard from "~/components/JobCard";
import AjaxServices from "~/services/ajaxServices"
import {ContentLoader} from 'vue-content-loader';

export default {
  name: 'Index',
  components: {JobCard, SearchBar, ContentLoader},
  middleware: 'auth',
  data() {
    return {
      listeOffres: [],
      listeOffresCopie: [],
      listeToShow: [],
      nbrShowed: 1,
      nbr: 0,
      showBtn: true,
      charged: false,
      queryString: null,
      typeOffreSelected: 0,
    }
  },
  created() {
    this.$auth.fetchUser();
    AjaxServices.getListe('listeOffres').then(promise => {
      console.log(promise)
      this.listeOffres = promise;
      this.listeOffresCopie = this.listeOffres
      this.charged = true;
    })
  },
  methods: {
    changeType(type) {
      this.typeOffreSelected = type;
      if (!this.queryString) {
        this.findTypes();
      } else {
        this.searchQuery(this.queryString)
      }
    },

    findTypes() {
      if (this.typeOffreSelected != 0) {
        this.nbrShowed = 1;
        this.nbr = 0;
        this.listeOffres = [];
        this.listeOffresCopie.forEach((offre) => {
          let i = 0;
          offre.typeoffres.forEach((typeoffre) => {
            if ((typeoffre.id == this.typeOffreSelected || this.typeOffreSelected === 0) && i === 0) {
              i++
              this.listeOffres.push(offre)
            }
          })
        })
      } else {
        this.listeOffres = this.listeOffresCopie;
      }
      this.changeButtonState();
    },

    searchQuery(queryString) {
      this.listeOffres = [];
      this.nbrShowed = 1;
      this.nbr = 0;
      this.queryString = queryString;
      this.listeOffresCopie.forEach((offre) => {
        if (offre.nom.toLowerCase().includes(queryString.toLowerCase())) {
          let i = 0;
          offre.typeoffres.forEach((typeoffre) => {
            if ((typeoffre.id == this.typeOffreSelected || this.typeOffreSelected == 0) && i === 0) {
              i++
              this.listeOffres.push(offre)
            }
          })
        }
      })
      this.changeButtonState();

    },
    changeButtonState() {
      let number = 0
      if (this.nbrShowed * this.nbr === 0) {
        number = 6
      } else {
        number = this.nbrShowed * this.nbr === 0;
      }

      this.showBtn = this.listeOffres.length > number;
    },

    //Honnêtement ce code est assez immonde donc bon, désolé
    //TODO: Changer cette fonctionalitée immonde
    showMore() {
      this.showBtn = false
      if ((this.nbrShowed * 6) < this.listeOffres.length) {
        this.nbrShowed++;
        this.goto()
      }
    },

    goto() {
      this.nbr = (6 * (this.nbrShowed - 1) + 7);
      if (document.querySelector(".container-cards .row div:nth-child(" + this.nbr + ")")) {
        document.querySelector(".container-cards .row div:nth-child(" + this.nbr + ")").scrollIntoView()
        if (this.listeOffres.length > this.nbrShowed * this.nbr) {
          this.showBtn = true
        }
      } else {
        setTimeout(this.goto, 50);
      }
    }
  },
  computed: {
    showOffres() {
      this.listeToShow = [...this.listeOffres].slice(0, 6 * this.nbrShowed)
      return this.listeToShow
    }
  }
}
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

.msg {
  font-size: 2rem;
  text-align: center;
}
</style>

