<template>
  <b-container v-if="offre">
    <b-row class="offre-row">
      <b-col cols="12" lg="5" md="6">
        <img :src="offre.image" alt="Image de l'offre">
      </b-col>
      <b-col class="separator" lg="1" md="1"></b-col>
      <b-col lg="6" md="6" cols="12">
        <h3>{{ offre.nom }}</h3>
        <div v-if="offre.tags.length > 0" class="tags-container">
          <Tag v-for="tag in offre.tags" :text="tag.nom"/>
        </div>
        <div class="localisation">
          <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 48 48"><title>
            ic_location_on_48px</title>
            <g class="nc-icon-wrapper" fill="#111111">
              <path
                d="M24 4c-7.73 0-14 6.27-14 14 0 10.5 14 26 14 26s14-15.5 14-26c0-7.73-6.27-14-14-14zm0 19c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5z"/>
            </g>
          </svg>
          {{ offre.localisation }}
        </div>
        <p>{{ offre.short_description }}</p>
      </b-col>
    </b-row>
    <b-row class="desc-container m-0">
      <b-col lg="10" md="12" cols="12">
        <p>
          {{ offre.description }}
        </p>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import AjaxServices from '~/services/ajaxServices'
import Tag from '~/components/Tag'

export default {
  name: "_slug",
  data() {
    return {
      id: 0,
      offre: null,
    }
  },
  created() {
    this.id = this.$route.params.slug;
    AjaxServices.getInformations('listeOffres', this.id).then((promise) => {
      console.log(promise)
      this.offre = promise;
      console.log(this.offre.tags)
    })

  }
}
</script>

<style lang="scss" scoped>
.offre-row {
  margin: 40px 0;

  @media(max-width: 992px){
    margin: 40px 0 20px;
  }
  .separator {
    @media (max-width: 992px) {
      display: none;
    }
  }

  .tags-container {
    display: flex;
    margin: 15px 0;

    @media (max-width: 992px) {
      margin: 5px 0;
    }

    div:not(:first-of-type) {
      margin: 0 20px;
    }
  }

  .localisation {
    margin: 15px 0;
    display: flex;
    align-items: center;

    @media (max-width: 992px) {
      margin: 5px 0;
    }

    svg {
      width: 36px;
      margin-right: 10px;

      path {
        fill: var(--primary-jobs);
      }
    }
  }

  div {
    img {
      width: 100%;
    }

    h3 {
      font-size: 3rem;
      font-weight: 900;
    }

    p {
      font-family: Roboto, sans-serif;
      font-size: 1.6rem;
    }
  }


}

.desc-container p {
  font-family: Roboto, sans-serif;
  font-weight: 400;
  font-size: 1.6rem;
}
</style>
