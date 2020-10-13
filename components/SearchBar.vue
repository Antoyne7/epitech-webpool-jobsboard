<template>
  <div class="searchBar">
    <b-container>
      <b-row class="input-containers">
        <b-col class="position-relative" md="3" lg="3" cols="12">
          <input type="text" placeholder="Localisation">
          <img class="icone" src="/icons/ic_my_location_48px.svg" alt="Trouvez votre localisation">
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
          <select @change="type($event)"  name="contract" id="contract">
            <option style="" v-for="type in typeoffres" :value="type.id" :type="type">{{ type.nom }}</option>
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
      typeoffres: []
    }
  },
  created() {
    this.$axios.$get('/back/api/typeoffres').then((promise) => {
      this.typeoffres = promise
    })
  },
  methods: {
    type(event){
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
</style>
