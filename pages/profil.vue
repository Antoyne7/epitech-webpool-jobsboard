<template>
  <b-container>
    <b-row class="ligne">
      <b-col lg="5" md="12" cols="12">
        <h2>Modifier vos informations</h2>
        <div class="position-relative d-flex align-items-center justify-content-center col-md-6 px-0"
             id="file-container">
          <input type="file" accept="image/gif, image/png, image/jpeg" id="image" class="h-100 w-100 position-absolute"
                 @change="updatePreviewImg($event)"/>
          <img :class="'mx-auto d-block mh-100 mw-100 '+ imgStyle" :src="preview"
               alt="Prévisualisation de l'image">
        </div>
        <form @submit.prevent="submit()" class="modifications" action="">
          <fieldset>
            <label>
              <input v-model="userInfo.nom" type="text">
            </label>
            <label>
              <input v-model="userInfo.prenom" type="text">
            </label>
            <label>
              <input v-model="userInfo.email" type="email">
            </label>
            <label>
              <input placeholder="Votre nouveau mot de passe" v-model="userInfo.password" type="password">
            </label>
            <label>
              <input placeholder="Confirmez votre mot de passe" v-model="userInfo.passwordConfirm" type="password">
            </label>
            <div class="d-flex justify-content-center align-items-center mt-3">
              <label for="cv">{{ action }} votre CV <img src="/icons/ic_file_upload_48px.svg"
                                                         alt="Icône upload de fichier"></label>

              <input @change="fileUpload($event)" type="file" name="cv" id="cv"
                     accept="image/gif, image/jpeg, image/png, application/pdf"/>
              <img @click="show = true" v-show="userInfo.cv !== null" id="cvShow" src="~/static/icons/eye.svg"
                   alt="Voir votre cv">
            </div>
            <lightbox v-bind="property" @hide="show = false" v-show="show"></lightbox>
          </fieldset>
          <button>Valider</button>
        </form>
      </b-col>
      <b-col class="separator" lg="1"/>
      <b-col lg="6" md="12" cols="12">
        <h2>Mes candidatures</h2>

        <div class="candidature">
          <h4>Nom de l'offre<span>Entreprise/localisation</span></h4>
          <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et
            dolore magna aliqua.</p>
          <nuxt-link to="/">Voir l'offre</nuxt-link>
        </div>

      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import camera from "static/icons/camera.svg";
import AjaxServices from "~/services/ajaxServices"
import Lightbox from "@/components/Lightbox";


export default {
  name: "profil",
  components: {
    Lightbox,
  },
  data() {
    return {
      preview: camera,
      imgStyle: 'not-updated',
      action: "Chargez",
      show: false,
      showSync: null,
      open: false,
      userInfo: {
        nom: null,
        prenom: null,
        email: null,
        password: null,
        passwordConfirm: null,
        cv: null
      },

    }
  },
  created() {
    //On fait une requête à l'API pour récupérer les informations de l'utilisateur et les affichers
    //TODO: Modifier l'ID pour que ce soit dynamique
    AjaxServices.getInformations('getUser', 10).then((promise) => {
      console.log(promise)
      this.userInfo = promise;
      console.log(this.userInfo)
      if (this.userInfo.image) {
        this.preview = this.userInfo.image;
        this.action = "Modifiez"
        this.imgStyle = 'updated'
      }
    }).catch((err) => {
      console.dir(err)
    })
  },
  methods: {
    submit() {

    },
    fileUpload(e) {
      let files = e.target.files || e.dataTransfer.files;
      if (!files.length)
        return;
      console.log(e.target.files)
    },
    updatePreviewImg(event) {
      //On change la data preview par l'url du fichier upload
      this.preview = window.URL.createObjectURL(event.target.files[0])
      //On change la classe de l'image pour enlever les styles liés à la caméra
      this.imgStyle = 'updated'
    },
  },
  computed: {
    property() {
      return {cv: this.userInfo.cv}
    }
  }
}
</script>

<style lang="scss" scoped>
.ligne {
  margin-top: 50px;

  h2 {
    font-size: 3rem;
    font-weight: bold;
    @media (max-width: 450px) {
      font-size: 2.6rem;
    }
  }

  .separator {
    @media (max-width: 992px) {
      display: none;
    }
  }

  //Mise en forme ajout image

  div#file-container {
    border-radius: 50%;
    height: 100px;
    width: 100px;
    margin: 30px auto 20px;
    background: rgba(0, 0, 0, .2);
    transition: all ease-in-out .2s;


    input {
      opacity: 0;
      border-radius: 50%;
      cursor: pointer;
    }

    img {
      z-index: -1;
    }


    //&:after {
    //  content: url('~static/icons/camera.svg');
    //  transform: translateX(-50%);
    //  position: absolute;
    //  left: 50%;
    //}

    img.not-updated {
      width: 28px;
      transition: all ease-in-out .2s;
    }

    img.updated {
      border-radius: 50%;
      height: 100%;
      width: 100%;
      object-fit: cover;
    }

    &:hover {
      background: rgba(0, 0, 0, .1);

      img {
        opacity: .5;


      }
    }
  }

  //  Mise en forme form
  .modifications {

    button {
      width: 240px;
      height: 50px;
      background: var(--primary-jobs);
      border: none;
      border-radius: 5px;
      color: white;
      text-transform: uppercase;
      font-size: 2.2rem;
      font-family: Roboto, sans-serif;
      font-weight: 900;
      display: block;
      margin: 20px auto 30px;
    }

    fieldset {
      display: flex;
      flex-direction: column;

      input {
        width: 100%;
        margin: 10px 0;
        height: 40px;
        border-radius: 0;
        border: 1px solid;
        padding-left: 10px;
        font-size: 1.4rem;
        font-weight: 300;

        &:focus {
          outline-color: var(--primary-jobs);
        }
      }

      input[type=file] {
        display: none;
      }

      label[for=cv] {
        font-size: 1.4rem;
        font-weight: 300;
        padding: 15px 20px;
        border: solid 1px black;
        margin: 0;
        text-align: center;
        display: flex;
        cursor: pointer;
        width: 50%;
        justify-content: center;

        &:hover {
          border-color: var(--primary-jobs);
        }

        img {
          width: 18px;
        }
      }

      img#cvShow {
        margin-left: 20px;
      }
    }
  }

  //  Candidature
  .candidature {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 10px 15px;
    margin: 10px 0;

    h4 {
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      font-weight: 500;
      font-size: 2rem;

      span {
        font-size: 1.6rem;
        font-weight: 400;
      }
    }

    p {
      margin-top: 10px;
      font-weight: 400;
      font-size: 1.6rem;
    }

    a {
      margin: 15px auto 10px;
      display: flex;
      width: 200px;
      height: 40px;
      background: var(--primary-jobs);
      justify-content: center;
      align-items: center;
      color: white;
      text-decoration: none;
      font-size: 1.6rem;
      text-transform: uppercase;
      font-weight: bold;
      border-radius: 5px;

    }
  }
}
</style>
