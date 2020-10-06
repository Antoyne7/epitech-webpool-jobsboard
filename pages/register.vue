<template>
  <b-container>
    <div class="row">
      <b-col class="login-box" lg="8" md="10" cols="12">
        <h2>S'inscrire à Jobs</h2>
        <b-col class="fieldset" lg="9" md="10" cols="12">
          <form @submit.prevent="submit()">
            <StyledInput :prenom.sync="prenom" var-to-update="prenom" class="input-login" placeholder="Prenom"
                         type="text" identifier="Prenom"/>
            <StyledInput :nom.sync="nom" var-to-update="nom" class="input-login" placeholder="Nom"
                         type="text" identifier="nom"/>
            <StyledInput :email.sync="email" var-to-update="email" class="input-login" placeholder="Email" type="email"
                         identifier="email"/>
            <StyledInput icone="eye.svg" :password.sync="password" var-to-update="password" class="input-login"
                         placeholder="Mot de passe"
                         type="password" identifier="password"/>
            <StyledInput icone="eye.svg" :passwordConfirm.sync="passwordConfirm" var-to-update="passwordConfirm"
                         class="input-login"
                         placeholder="Confirmer le mot de passe"
                         type="password" identifier="passwordConfirm"/>
            <Alert style="margin-top: -20px" :msg="alertMsg" :type="alertType" v-show="showAlert"/>
            <div @click="submit()">
              <AuthButton text="Inscription"/>
            </div>
          </form>
          <Alert style="text-align: center" :msg="alertMsgGlobal" :type="alertTypeGlobal" v-show="showAlertGlobal"/>
            <nuxt-link to="/login">
              <AuthRedirection class="auth-redirection"
                               text="Se connecter"/>
            </nuxt-link>
        </b-col>
      </b-col>
    </div>
    <ModalSuccess :is-centered="true" route="/" message="Votre compte a bien été crée" id="modal-succ"/>
  </b-container>
</template>

<script>
import Alert from "~/components/Alert";
import AuthButton from "~/components/AuthButton";
import StyledInput from "~/components/StyledInput";
import AuthRedirection from "~/components/AuthRedirection";
import param from "~/param/param";
import ajaxServices from "~/services/ajaxServices";
import ModalSuccess from "@/components/modalSuccess";

export default {

  name: "login.vue",
  layout: 'auth',
  data() {
    return {
      prenom: null,
      nom: null,
      email: null,
      password: null,
      passwordConfirm: null,
      alertMsg: null,
      alertType: null,
      showAlert: false,

      alertMsgGlobal: null,
      alertTypeGlobal: null,
      showAlertGlobal: false,
    }
  },
  components: {ModalSuccess, Alert, AuthRedirection, AuthButton, StyledInput},
  methods: {
    validateEmail(email) {
      const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(String(email).toLowerCase());
    },
    submit() {
      if (this.prenom && this.prenom !== "" && this.nom && this.nom !== "" &&
        this.email && this.email !== "" && this.password) {
        this.showAlertGlobal = false
        if (this.validateEmail(this.email)) {
          if (this.password.length > 5) {
            this.showAlertGlobal = false
            if (this.passwordConfirm === this.password) {
              this.showAlertGlobal = false
              const params = new FormData();
              params.append('nom', this.nom)
              params.append('prenom', this.prenom)
              params.append('email', this.email)
              params.append('password', this.password)

              ajaxServices.pushInformations('register', params).then(({token, expiresIn, statusCode}) => {
                console.log({token, expiresIn, statusCode})
                this.$store.dispatch('setToken', {token, expiresIn});

                if (statusCode === 200) {
                  this.$bvModal.show('modal-succ')
                } else {
                  this.showAlertGlobal = true
                  this.alertTypeGlobal = "error"
                  this.alertMsgGlobal = param.message.errDefault
                }
              }).catch((error) => {
                this.showAlertGlobal = true
                this.alertTypeGlobal = "error"
                this.alertMsgGlobal = param.message.errDefault
                console.log(error)
              })
            }
          } else {
            console.log('ERR MDP')
            this.showAlertGlobal = true
            this.alertMsgGlobal = param.message.errMdp
            this.alertTypeGlobal = "error"
          }
        } else {
          this.showAlertGlobal = true
          this.alertMsgGlobal = param.message.errEmail
          this.alertTypeGlobal = "error"
        }
      } else {
        this.showAlertGlobal = true
        this.alertMsgGlobal = param.message.errInfo
        this.alertTypeGlobal = "error"
      }
    },
  },
  //Écoute de la modification de la variable passwordConfirm pour vérifier si elle correspon à Password
  watch: {
    passwordConfirm(val) {
      //do something when the data changes.
      if (val) {
        //Si les mots de passe sont les mêmes alors on affiche un success, sinon une alert
        if (val === this.password) {
          this.alertMsg = param.message.sucPasswords
          this.alertType = "sucess"
        } else {
          this.alertMsg = param.message.errPasswords
          this.alertType = "error"
        }
        this.showAlert = true;

        // setTimeout(() => {
        //   this.showAlert = false
        // }, 6000)

      }
    }
  }

}
</script>

<style lang="scss" scoped>
.container {

  .row {
    align-items: center;
    height: 100vh;
  }

}

.login-box {
  background: white;
  margin: 50px auto;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  padding-bottom: 30px;
  @media (max-width: 768px) {
    margin: 0;
  }

  h2 {
    font-weight: 700;
    font-size: 2.8rem;
    text-transform: uppercase;
    text-align: center;
    margin: 50px 0 40px;
  }

  .fieldset {
    margin: auto;

    .input-login {
      margin: 30px 0;
    }

    .auth-redirection {
      margin: 10px 0;
    }

  }
}
</style>
