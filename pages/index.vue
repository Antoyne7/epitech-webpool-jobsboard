<template>
  <div>

    <SearchBar @changeData="handleChange($event)"/>
    <b-container class="container-cards">
      <b-row v-if="showOffres.length > 0 && charged === true">
        <JobCard
          v-for="offre in listeOffres"
          :title="offre.nom"
          :key="offre.id"
          :short-description="offre.short_description"
          :linkId="offre.id"
          :img="offre.image"
          :pourvu="offre.pourvu"
          :localisation="offre.localisation"
          :candidaturesProp="offre.candidatures"
          :types="offre.typeoffres" />
      </b-row>
      <div class="msg" v-else-if="charged === true">
        Il n'y a aucune offre disponibles pour vos critères.
      </div>
      <b-row v-else>
        <ContentLoader v-for="skeleton in 6" :key="'skeleton' + skeleton" v-show="!charged" height="500"
                       class="skeleton col-lg-4 col-md-6 col-12 w-100 skeleton"/>
      </b-row>
      <button v-show="showBtn" @click="showMore()" class="btn-show">Voir plus</button>
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
      listeOffresCopie: [],
      listeToShow: [],
      nbrShowed: 1,
      nbr: 0,
      showBtn: true,
      charged: false,
    }
  },
  created() {
    this.$auth.fetchUser();
    this.$axios.$get("/back/api/offres").then(data => {
      this.listeOffres = data;
      this.listeOffresCopie = [...this.listeOffres]
      this.charged = true;
    });
  },
  mounted() {

  },
  methods: {
    //On détecte ici chaques changements dans le composant searchbar et on récupère les données
    handleChange(event) {
      //On reset les variables de liste et celles sur le nombre de cartes à afficher pour pouvoir les ajuster
      this.listeOffres = [];
      this.nbrShowed = 1;
      this.nbr = 0;

      //On boucle sur chacune des offres de la copie de la liste des offres
      [...this.listeOffresCopie].forEach((offre) => {

          /************************************************************/
          /*Tri par type d'offre et ajout des offres à la liste finale*/
          /************************************************************/
          if (offre.typeoffres.length > 0) {
            //Si l'offre contient des types d'offres, alors on boucle parmis ces types d'offres
            offre.typeoffres.forEach((typeoffre) => {
              //Si il n'y a pas de type d'offre choisi ou si ce dernier est égal au type d'offre de l'offre, et que cette dernière n'est
              //pas déjà dans la liste, alors on l'ajoute dans listeOffres (qui affiche les offres à la fin)
              if ((event.selectedTypeOffre == 0 || typeoffre.id == event.selectedTypeOffre) && !this.listeOffres.includes(offre)) {
                this.listeOffres.push(offre);
              }
            })
            //Si l'offre en contient pas de type d'offre et qu'il n'y a pas de type d'offre choisi, on rajoute l'offre
            //  dans la liste finale
          } else if (event.selectedTypeOffre == 0) {
            this.listeOffres.push(offre)
          }

          /************************/
          /* Tri par localisation */
          /************************/
          //Si le code de la ville/dpt n'est pas égale à un de ceux présents dans l'offre alors on retire l'offre de la liste finale
          if (this.listeOffres.includes(offre) && event.location.name && event.location.name.length > 0 && ((event.location.code !== offre.code_ville) && (event.location.code !== offre.code_departement))) {
            let index = this.listeOffres.indexOf(offre)
            this.listeOffres.splice(index, 1)
          }

          /*********************/
          /* Tri par recherche */
          /*********************/
          //Si la string tapée par l'utilisateur n'est pas dans le nom de l'offre alors on retire cette dernière de la liste finale
          if (event.query && event.query.length > 0 && !offre.nom.toLowerCase().includes(event.query.toLowerCase()) && this.listeOffres.includes(offre)) {
            let index = this.listeOffres.indexOf(offre)
            this.listeOffres.splice(index, 1)
          }

        }
      )
      //Changement de l'affichage du bouton "voir plus"
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
        this.goto();
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

.msg {
  font-size: 2rem;
  text-align: center;
}
</style>
