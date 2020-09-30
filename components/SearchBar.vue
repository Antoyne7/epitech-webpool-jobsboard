<template>
  <div class="searchBar">
    <b-container>
      <b-row class="input-containers">
        <b-col md="4" lg="4" cols="12">
          <input type="text" placeholder="Localisation">
        </b-col>
        <b-col md="4" lg="4" cols="12">
          <input type="search" placeholder="Le job de vos rêves">
        </b-col>
        <b-col md="4" lg="4" cols="12">
          <select name="contract" id="contract">
            <option value="">Type de contrat</option>
          </select>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  name: 'SearchBar'
}
</script>
<style scoped lang="scss">
.searchBar {
  background: white;

  .input-containers {
    padding: 30px 0;
  }
}
</style>
