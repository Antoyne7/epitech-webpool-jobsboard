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
              <input placeholder="Confirmez votre nouveau mot de passe" v-model="passwordConfirm"
                     type="password">
            </label>
            <div class="d-flex justify-content-center align-items-center mt-3">
              <label for="cv">{{ action }} votre CV <img src="/icons/ic_file_upload_48px.svg"
                                                         alt="Icône upload de fichier"></label>

              <input @change="fileUpload($event)" type="file" name="cv" id="cv"
                     accept="image/gif, image/jpeg, image/png, application/pdf"/>
              <img @click="show = true" v-show="cvPreview !== null" id="cvShow" src="~/static/icons/eye.svg"
                   alt="Voir votre cv">
            </div>
            <lightbox v-bind="property" @hide="show = false" v-show="show"></lightbox>
          </fieldset>
          <Alert style="margin-top: 20px;text-align: center;" v-show="alert.alertShow" :msg="alert.alertMsg"
                 :type="alert.alertType"/>
          <ModalSuccess route="/profil" id="success_profil" :is-centered="true" message="Modifications effectuées"/>
          <button>Valider</button>
        </form>
      </b-col>
      <b-col class="separator" lg="1"/>
      <b-col lg="6" md="12" cols="12">
        <h2 class="position-relative">Mes candidatures <span v-if="candidatures.length>3" class="icon-scroll"></span>
        </h2>
        <div class="candidatures-container" v-if="candidatures.length > 0">
          <div class="historique">
            <div v-for="candidature in candidatures" class="candidature">
              <h4>{{ candidature.offre.nom }}</h4>
              <div class="loc_company">
            <span class="loc">
              <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26"
                   viewBox="0 0 48 48"><title>
            ic_location_on_48px</title>
            <g class="nc-icon-wrapper" fill="#111111">
              <path style="fill: var(--primary-jobs)"
                    d="M24 4c-7.73 0-14 6.27-14 14 0 10.5 14 26 14 26s14-15.5 14-26c0-7.73-6.27-14-14-14zm0 19c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5z"/>
            </g>
            </svg>
              {{ candidature.offre.ville }}
            </span>
                <span>{{ candidature.offre.entreprise.nom }}</span>
              </div>
              <p>{{ candidature.offre.short_description }}</p>
              <nuxt-link :to="'/' + candidature.offre.id">Voir l'offre</nuxt-link>
            </div>
          </div>
        </div>
        <div class="msg" v-else>
          Vous n'avez postulé à aucune offre pour le moment.
          <nuxt-link to="/">Découvrir les offres</nuxt-link>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import camera from "static/icons/camera.svg";
import Lightbox from "@/components/Lightbox";
import Alert from "@/components/Alert";
import param from "@/param/param";
import ModalSuccess from "@/components/modalSuccess";


export default {
  name: "profil",
  middleware: 'auth',
  components: {
    ModalSuccess,
    Alert,
    Lightbox,
  },
  data() {
    return {
      candidatures: {},
      preview: camera,
      imgStyle: 'not-updated',
      action: "Chargez",
      show: false,
      showSync: null,
      open: false,
      cvPreview: null,
      alert: {
        alertShow: false,
        alertMsg: null,
        alertType: null,
      },
      passwordConfirm: null,
      userInfo: {
        id: null,
        nom: null,
        prenom: null,
        email: null,
        password: null,
        cv: null,
        image: null,
      },

    }
  },
  mounted() {
    if (this.$auth.user.candidatures) {
      this.candidatures = this.$auth.user.candidatures;
      console.log(this.candidatures)
    }
    this.$axios.$get('/back/api/utilisateurs/' + this.$auth.user.id)
      .then((promise) => {
        this.userInfo = promise;
        if (this.userInfo.image) {
          this.preview = param.cheminPhoto + this.userInfo.image;
          this.imgStyle = 'updated'
        }
        if (this.userInfo.cv) {
          this.cvPreview = param.cheminPhoto + promise.cv
          this.action = "Modifiez"
        }
      }).catch((err) => {
      console.dir(err)
    })

  },

  methods: {
    submit() {
      if (this.userInfo.password === this.passwordConfirm || (!this.password && this.passwordConfirm === null)) {
        const params = new FormData();
        params.append('email', this.userInfo.email)
        params.append('nom', this.userInfo.nom)
        params.append('prenom', this.userInfo.prenom)
        params.append('cv', this.userInfo.cv)
        params.append('image', this.userInfo.image)
        if (this.userInfo.password) {
          params.append('password', this.userInfo.password)
        }
        params.append('id', this.userInfo.id)
        //On ajoute cela aux informations afin de simuler une requête "put"
        params.append('_method', 'put')
        this.$axios.$post('back/api/utilisateurs/' + this.userInfo.id, params).then((resp) => {
          console.log(resp)
          if (resp.status_code === 422) {
            if (resp.error_code === 10) {
              this.alert.alertMsg = param.message.errPasswordLength
              this.alert.alertType = "error";
              this.alert.alertShow = true;
            } else if (resp.error_code === 11) {
              this.alert.alertMsg = param.message.errMailused
              this.alert.alertType = "error";
              this.alert.alertShow = true;
            } else {
              this.alert.alertMsg = param.message.errDefault
              this.alert.alertType = "error";
              this.alert.alertShow = true;
            }
          } else {
            this.alert.alertShow = false;
            this.$bvModal.show('success_profil')
            this.userInfo.password = null
            this.passwordConfirm = null
            this.$auth.fetchUser();
          }
        }).catch((err) => {
          console.dir(err)
          this.alert.alertMsg = param.message.errDefault
          this.alert.alertType = "error";
          this.alert.alertShow = true;
        })
      } else {
        this.alert.alertMsg = param.message.errPasswords
        this.alert.alertType = "error";
        this.alert.alertShow = true;
      }

    },
    fileUpload(e) {
      let files = e.target.files || e.dataTransfer.files;
      if (!files.length) return;
      //On change cvPreview pour afficher le nouveau cv
      this.cvPreview = window.URL.createObjectURL(e.target.files[0])
      //On charge le CV dans la data pour pouvoir l'upload par la suite
      this.userInfo.cv = e.target.files[0]
    },

    updatePreviewImg(event) {
      //On change la data preview par l'url du fichier upload
      this.preview = window.URL.createObjectURL(event.target.files[0])
      //On change la classe de l'image pour enlever les styles liés à la caméra
      this.imgStyle = 'updated'
      this.userInfo.image = event.target.files[0];
    },
  },
  computed: {
    property() {
      return {cv: this.cvPreview}
    }
  }
}
</script>

<style lang="scss" scoped>
.msg {
  width: 100%;
  text-align: center;
  margin: auto;
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  font-size: 1.6rem;

  a {
    color: var(--primary-jobs);
    text-decoration: none;
  }
}

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

  .candidatures-container {
    max-height: 600px;
    overflow: auto;
    @media(max-width: 992px) {
      margin: 20px 0;
    }

    .historique {
      height: 100%;

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
    }

    .loc_company {
      display: flex;
      justify-content: space-between;
      align-items: flex-end;
      margin-top: 10px;

      span {
        font-size: 1.6rem;
        font-weight: 400;
        display: block;
      }

      .loc {
        display: flex;
        align-items: flex-end;
        font-weight: 500;
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

//Animation scroll souris
.icon-scroll:before {
  position: absolute;
  left: 50%
}

.icon-scroll {
  position: absolute;
  width: 23px;
  height: 35px;
  bottom: 0;
  right: 0;
  border: 2px solid black;
  border-radius: 25px;
}

//@media (max-width: 767px) {
//  .icon-scroll {
//    position: relative
//  }
//}

.icon-scroll:before {
  content: '';
  width: 4px;
  height: 4px;
  background: black;
  margin-left: -2px;
  top: 4px;
  border-radius: 4px;
  animation-duration: 1.5s;
  animation-iteration-count: infinite;
  animation-name: scroll
}

@keyframes scroll {
  0% {
    opacity: 1
  }
  100% {
    opacity: 0;
    transform: translateY(26px)
  }
}

</style>
