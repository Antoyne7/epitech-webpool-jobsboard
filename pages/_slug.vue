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
    <button v-b-modal.modal>
      Postuler
    </button>
    <b-modal class="modal-offre" size="lg" id="modal" hide-footer hide-header>
      <h2>{{ offre.nom }}
        <span>
        <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48"
             viewBox="0 0 48 48"><title>
            ic_location_on_48px</title>
            <g class="nc-icon-wrapper" fill="#111111">
              <path
                d="M24 4c-7.73 0-14 6.27-14 14 0 10.5 14 26 14 26s14-15.5 14-26c0-7.73-6.27-14-14-14zm0 19c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5z"/>
            </g>
          </svg>
          {{ offre.localisation }}
      </span>
      </h2>
      <div class="tags-container">
        <Tag v-for="tag in offre.tags" :text="tag.nom"/>
      </div>
      <p>{{ offre.short_description }}</p>
      <h2>Votre candidature</h2>
      <div class="slider-btn-container">
        <label class="switch">
          <input v-model="profilCv" type="checkbox">
          <span class="slider round"></span>
        </label>
        <span>Utiliser le cv du profil<a><img src="/icons/eye.svg" alt="Voir le cv"></a></span>
      </div>
      <div class="msg">
        <textarea placeholder="Votre message" name="message" id="message" cols="30" rows="10"></textarea>
        <label v-show="!profilCv" for="image">Chargez votre CV <img src="/icons/ic_file_upload_48px.svg"
                                                           alt="Icône upload de fichier"></label>

        <input type="file" name="image" id="image" accept="image/gif, image/jpeg, image/png, application/pdf"/>
        <button>Envoyer</button>
      </div>
    </b-modal>
  </b-container>
</template>

<script>
import AjaxServices from '~/services/ajaxServices'
import Tag from '~/components/Tag'

export default {
  name: "_slug",
  middleware: 'auth',
  data() {
    return {
      id: 0,
      offre: null,
      profilCv: false,
    }
  },
  methods: {
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


/* Mise en forme page */
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

.offre-row {
  margin: 40px 0;


  @media(max-width: 992px) {
    margin: 40px 0 20px;
  }

  .separator {
    @media (max-width: 992px) {
      display: none;
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

/* Mise en forme modale */
.modal-dialog {
  padding: 10px;

  .msg {
    display: flex;
    flex-direction: column;
    align-items: center;

  }

  .modal-body {
    padding: 15px;
  }

  h2 {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    font-weight: bold;
    font-size: 2.4rem;
    margin-bottom: 0;

    &:last-of-type {
      margin: 20px 0;

    }

    span {
      display: flex;
      align-items: center;
      font-family: Roboto, sans-serif;
      font-size: 1.8rem;
      font-weight: normal;
    }

  }

  svg {
    margin-left: 10px;
    width: 32px;

    g {
      fill: var(--primary-jobs);
    }
  }


  .tags-container {
    margin: 10px 0 15px;
    @media (max-width: 992px) {
      margin: 0;
      margin-bottom: 10px;
    }
  }

  p {
    font-size: 1.6rem;
    margin-bottom: 10px;
  }

  textarea {
    width: 100%;
    padding: 10px;
    font-size: 1.4rem;
    font-weight: 300;
    resize: none;
  }

  button {
    margin: 20px auto 10px;
    display: block;
  }

  input[type=file] {
    display: none;
  }

  label[for=image] {
    font-size: 1.4rem;
    font-weight: 300;
    padding: 15px 20px;
    border: solid 1px black;
    margin: 20px auto 0;
    text-align: center;
    display: flex;
    cursor: pointer;

    img {
      width: 18px;
    }
  }
}

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
  margin: 20px 10px;
}

.desc-container p {
  font-family: Roboto, sans-serif;
  font-weight: 400;
  font-size: 1.6rem;
}

/* Slider switch */

.slider-btn-container {
  display: flex;
  align-items: center;
  margin: 10px 0;


  > span:last-of-type {
    margin-left: 15px;
    font-size: 16px;

    a {
      margin-left: 10px;
      height: fit-content;
      cursor: pointer;

      img {
        width: 32px;
      }
    }
  }
}

.switch {
  position: relative;
  display: inline-block;
  width: 60px;
  height: 34px;
}

/* Hide default HTML checkbox */
.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider:before {
  position: absolute;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: var(--primary-jobs);
}

input:focus + .slider {
  box-shadow: 0 0 1px var(--primary-jobs);
}

input:checked + .slider:before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

.slider.round {
  border-radius: 34px;
}

.slider.round:before {
  border-radius: 50%;
}
</style>
