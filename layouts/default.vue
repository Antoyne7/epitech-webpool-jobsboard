<template>
  <div>
    <!-- <Navigation/> -->
    <Nuxt/>
    <!--<Footer/> -->
  </div>
</template>

<script>
import Navigation from "~/components/Navigation";
import Footer from "~/components/Footer";

export default {
  components: {Footer, Navigation}

}
</script>

<style lang="scss">
:root {
  --primary-jobs: #260592;
  --color-background: #FBFBFF
}

html {
  font-size: 62.5%;
}

body {
  background: var(--color-background);
}

header {
  background: white;
}

*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
}

</style>
