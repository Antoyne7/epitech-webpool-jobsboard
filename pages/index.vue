<template>
  <ListeOffres :admin-view="false" />
</template>

<script>
import ListeOffres from "~/components/ListeOffres";

export default {
  name: "Index",
  components: { ListeOffres },
  middleware: "auth",
};
</script>
<style lang="scss">

</style>
