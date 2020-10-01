<template>
  <b-col lg="4" md="6" cols="12">
    <div class="card-container">
      <h3>{{ title }}</h3>
      <br v-if="title.length < 22">
<!--      <p>{{localisation}}</p>-->
      <p>{{ descriptionFunc(shortDescription) }}</p>
      <br v-if="shortDescription.length < 100">
      <img :src="img" alt="Image de l'offre">
      <nuxt-link :to="link">
        <button>En savoir plus</button>
      </nuxt-link>
    </div>
  </b-col>
</template>

<script>
export default {
  name: "JobCard",
  props: ['title', 'shortDescription', 'img', 'link','localisation'],
  methods: {
    descriptionFunc(desc) {
      if (desc.length > 100) {
        return desc.slice(0, 100) + "..."
      } else {
        return desc
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.card-container {
  background: white;
  padding: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  height: 500px;
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  @media(max-width: 1100px) {
    height: 430px;
  }
  @media(max-width: 992px) {
    height: 460px;
  }
  margin: 15px 0;

  button {
    width: 220px;
    height: 50px;
    background: var(--primary-jobs);
    border: none;
    border-radius: 5px;
    color: white;
    font-weight: 700;
    font-size: 18px;
    text-transform: uppercase;
  }

  img {
    width: 100%;
  }

  h3 {
    font-size: 1.8rem;
    font-weight: 700;
    text-transform: uppercase;
    text-align: center;
    padding: 0 0 10px;
  }

  p {
    font-size: 1.4rem;
  }

  a {
    display: block;
    width: fit-content;
    margin: 10px auto;
    align-self: flex-end;
  }
}
</style>
