<template>
  <div class="searchBar">
    <b-container>
      <b-row class="input-containers">
        <b-col md="3" lg="3" cols="12">
          <input type="text" placeholder="Localisation">
        </b-col>
        <b-col md="1" lg="1" cols="0"></b-col>
        <b-col md="4" lg="4" cols="12">
          <input type="search" placeholder="Le job de vos rêves">
        </b-col>
        <b-col md="1" lg="1" cols="0"></b-col>
        <b-col md="3" lg="3" cols="12">
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

  input, select {
    appearance: none;
    width: 100%;
    height: 50px;
    border: solid black 1px;
    font-size: 14px;
    font-weight: 300;
    padding: 0 10px;
  }
  select {
    &:after {
      content: url("static/icons/ic_chevron_right_48px.svg");
    }
  }
}
</style>
