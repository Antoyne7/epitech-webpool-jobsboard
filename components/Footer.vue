<template>
  <footer>
    <b-container>
      <b-row>
        <h2 class="col-lg-4 col-md-4 col-12">Job's</h2>
        <b-col cols="12" lg="4" md="4">Projet réalisé dans le cadre d’un exercice pédagogique à Epitech Strasbourg
        </b-col>
        <b-col lg="4" md="4" cols="12" class="social-media">
          <a href="https://instagram.com" target="_blank">
            <img src="/icons/instagram.svg" alt="Icône Instagram">
          </a>
          <a href="https://facebook.com" target="_blank">
            <img src="/icons/facebook.svg" alt="Icône Facebook">
          </a>
          <a href="https://twitter.com" target="_blank">
            <img src="/icons/twitter.svg" alt="Icône Twitter">
          </a>
        </b-col>
      </b-row>
    </b-container>
  </footer>
</template>

<script>
export default {
  name: "Footer"
}
</script>

<style scoped lang="scss">
footer {
  background: white;
  box-shadow: 0px -2px 4px rgba(0, 0, 0, 0.1);

  > .container {
    padding: 40px 20px;

    div:nth-child(2) {
      display: flex;
      align-items: center;
      text-align: center;
      font-size: 16px;
      font-weight: 300;
      font-style: italic;
      @media (max-width: 768px) {
        margin: 50px 0;
        justify-content: center;
      }
    }
  }

  h2 {
    font-family: Rubik, sans-serif;
    font-size: 4.8rem;
    text-transform: uppercase;
    font-weight: 900;
    color: var(--primary-jobs);
    margin: auto;

    @media (max-width: 768px) {
      text-align: center;
    }
  }

  .social-media {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    @media (max-width: 768px) {
      justify-content: center;
    }

    img {
      margin: 0 10px;
    }
  }
}
</style>
