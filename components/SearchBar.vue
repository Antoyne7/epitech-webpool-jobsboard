<template>
  <div class="searchBar">
    <b-container>
      <b-row class="input-containers">
        <b-col class="position-relative" md="3" lg="3" cols="12">
          <input v-model="location.name" type="text" placeholder="Localisation">

          <ul id="localisation-autocomplete" class="position-absolute w-100 bg-white rounded"
              v-if="localisationFilter.length > 0"> <!-- Autocomplete list -->
            <li class="localisation-item" v-for="localisation in localisationFilter"
                :key="localisation.code"
                @click="setLocalisation(localisation)">
              {{ localisation.nom }}
              <span
                v-if="!localisation.codeRegion">
                {{ localisation.codesPostaux[0] }},
                {{ localisation.departement.nom }}
              </span>
              <span v-else>
                {{ localisation.code }}
              </span>
            </li>
          </ul>

          <div v-show="locationLoading" class="lds-ring">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
          </div>
          <img @click="locate()" class="icone" src="/icons/ic_my_location_48px.svg" alt="Trouvez votre localisation">
        </b-col>
        <b-col class="separator" md="1" lg="1" cols="0">
          <div class="vr"></div>
        </b-col>
        <b-col class="position-relative" md="4" lg="4" cols="12">
          <input @keyup="search($event)" :query="search" type="search" placeholder="Le job de vos rêves">
          <img class="icone" src="/icons/ic_search_48px.svg" alt="Cherchez un emploi en particulier">
        </b-col>
        <b-col class="separator" md="1" lg="1" cols="0">
          <div class="vr"></div>
        </b-col>
        <b-col md="3" lg="3" cols="12">
          <select @change="type($event)" name="contract" id="contract">
            <option selected :value="0">Tous les types</option>
            <option v-for="type in typeoffres" :value="type.id" :type="type">{{ type.nom }}</option>
          </select>
          <img class="icone rotate" src="/icons/ic_chevron_right_48px.svg" alt="Icone selecteur">
        </b-col>
      </b-row>
      <button class="submit">
        Rechercher
      </button>
    </b-container>
  </div>
</template>
<script>
export default {
  name: 'SearchBar',
  data() {
    return {
      query: null,
      locationLoading: false,
      locationData: null,
      typeoffres: [],
      listLoc: [],
      location: {
        code: null,
        name: null,
      }
    }
  },
  created() {
    this.$axios.$get('/back/api/typeoffres').then((promise) => {
      this.typeoffres = promise
    })
  },
  watch: {
    location: {
      async handler({name}) {
        if (name.length === 3) {
          this.listLoc = await this.$axios.$get('https://geo.api.gouv.fr/communes?nom=' + name + '&fields=nom,code,codesPostaux,codeDepartement,departement&format=json&geometry=centre')
          let listDepartement = await this.$axios.$get('https://geo.api.gouv.fr/departements?nom=' + name + '&fields=nom,code,codeRegion')
          listDepartement.forEach((el) => {
              this.listLoc.push(el)
            }
          )
          console.log(this.listLoc)
        } else if (name.length < 3) {
          this.listLoc = []
        }
      },
      deep: true
    }
  },
  computed: {
    localisationFilter() {
      const sorted = this.listLoc.filter(localisation => localisation.nom.toLowerCase().includes(this.location.name.toLowerCase().trim()));
      [...sorted].forEach((element) => {
        if (element.codeRegion) {
          console.log('unshifted', element)
          sorted.unshift(element);
        }
      })
      if (sorted.length > 6) {
        return sorted.slice(0, 6)
      } else {
        return sorted
      }

    },
  },
  methods: {
    locate() {
      this.locationLoading = true;
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.getPosition)
      }
    },
    getPosition(position) {
      this.$axios.get("https://api-adresse.data.gouv.fr/reverse/" +
        "?lon=" + position.coords.longitude + "&" +
        "lat=" + position.coords.latitude + "", {
        transformRequest: (data, headers) => {
          delete headers.common['Authorization'];
        }
      }).then((resp) => {
        this.locationData = resp.data.features[0].properties;
        this.location.code = parseInt(this.locationData.citycode)
        this.location.name = this.locationData.city
        console.log(this.location)

        this.locationLoading = false
      }).catch((err) => {
        console.dir(err)
        this.locationLoading = false
      })
    },
    setLocalisation(loc) {
      console.log(loc)
    },
    type(event) {
      this.$emit('type', event.target.value);
    },
    search(event) {
      this.$emit('query', event.target.value);
    }
  }
}
</script>
<style scoped lang="scss">
.searchBar {
  background: white;
  margin: 50px 0;
  padding-bottom: 28px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);

  .input-containers {
    padding: 30px 0;

    div:nth-child(3) {
      @media(max-width: 768px) {
        margin: 20px 0;
      }
    }
  }

  .submit {
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
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
  }

  .separator {
    display: flex;
    justify-content: center;
    align-items: center;
    @media(max-width: 768px) {
      display: none;
    }

    .vr {
      width: 100%;
      height: 1px;
      background: black;
      transform: rotate(90deg);
    }
  }

  input:first-of-type {
    &:after {
      content: " ";
      width: 30px;
      height: 30px;
      background: red;

    }
  }

  .icone {
    width: 24px;
    height: auto;
    position: absolute;
    right: 25px;
    top: 50%;
    transform: translateY(-50%);
  }

  .rotate {
    transform: translateY(-50%) rotate(90deg);
  }

  input, select {
    position: relative;
    appearance: none;
    width: 100%;
    height: 50px;
    border: solid black 1px;
    font-size: 14px;
    font-weight: 300;
    padding: 0 10px;

  }

}

//Style chargement
.lds-ring {
  position: absolute;
  width: 25px;
  height: 25px;
  display: flex;
  justify-content: center;
  align-items: center;
  margin: auto;
  top: 50%;
  transform: translateY(-50%);
  right: 55px;
}

.lds-ring div {
  box-sizing: border-box;
  display: block;
  position: absolute;
  width: 20px;
  height: 20px;
  margin: 3px;
  border: 3px solid var(--primary-jobs);
  border-radius: 50%;
  animation: lds-ring 1.2s cubic-bezier(0.5, 0, 0.5, 1) infinite;
  border-color: var(--primary-jobs) transparent transparent transparent;
}

.lds-ring div:nth-child(1) {
  animation-delay: -0.45s;
}

.lds-ring div:nth-child(2) {
  animation-delay: -0.3s;
}

.lds-ring div:nth-child(3) {
  animation-delay: -0.15s;
}

@keyframes lds-ring {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
</style>
