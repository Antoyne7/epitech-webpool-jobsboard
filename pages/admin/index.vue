<template>
  <ListeOffres :admin-view="true" />
</template>

<script>
import ListeOffres from "~/components/ListeOffres";

export default {
  head() {
    return {
      title: 'Jobs - administration'
    }
  },
  name: "Index",
  components: { ListeOffres },
  middleware: "auth",
};
</script>
<style lang="scss">

</style>
