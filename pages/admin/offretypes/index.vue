<template>
  <div>
    <b-container class="mt-4">
      <b-row>
        <b-button :to="{ name: 'admin' }" block variant="primary" size="lg">
          back
        </b-button>
      </b-row>
    </b-container>
    <b-container class="container-cards">
      <b-row>
        les types
        <div>

        </div>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import JobCard from "@/components/JobCard"
import SearchBar from "@/components/SearchBar"
import AjaxServices from "@/services/ajaxServices";

export default {
  name: "Index",
  components: {
    JobCard,
    SearchBar
  },
  data() {
    return {
      listeOffres: [],
    }
  },
  created() {
    AjaxServices.getListe('listeOffres').then(promise => {
      console.log(promise)
      this.listeOffres = promise;
    })
  }
}
</script>

<style scoped>

</style>
