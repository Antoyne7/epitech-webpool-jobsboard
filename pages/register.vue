<template>
  <b-container>
    <div class="row">
      <b-col class="login-box" lg="8" md="10" cols="12">
        <h2>S'inscrire à Jobs</h2>
        <b-col class="fieldset" lg="9" md="10" cols="12">
          <StyledInput :prenom.sync="prenom" var-to-update="prenom" class="input-login" placeholder="Prenom"
                       type="text" identifier="Prenom"/>
          <StyledInput :nom.sync="nom" var-to-update="nom" class="input-login" placeholder="Nom"
                       type="text" identifier="nom"/>
          <StyledInput :email.sync="email" var-to-update="email" class="input-login" placeholder="Email" type="email"
                       identifier="email"/>
          <StyledInput icone="eye.svg" :password.sync="password" var-to-update="password" class="input-login" placeholder="Mot de passe"
                       type="password" identifier="password"/>
          <StyledInput icone="eye.svg" :passwordConfirm.sync="passwordConfirm" var-to-update="passwordConfirm" class="input-login"
                       placeholder="Confirmer le mot de passe"
                       type="password" identifier="passwordConfirm"/>
          <Alert style="margin-top: -20px" :msg="alertMsg" :type="alertType" v-show="showAlert"/>
          <AuthButton text="Connexion" @click="submit()"/>
          <nuxt-link to="/login">
            <AuthRedirection class="auth-redirection"
                             text="Se connecter"/>
          </nuxt-link>
        </b-col>
      </b-col>
    </div>
  </b-container>
</template>

<script>
import Alert from "~/components/Alert";
import AuthButton from "~/components/AuthButton";
import StyledInput from "~/components/StyledInput";
import AuthRedirection from "~/components/AuthRedirection";
import param from "~/param/param";

export default {

  name: "login.vue",
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
    }
  },
  components: {Alert, AuthRedirection, AuthButton, StyledInput},
  methods: {

    submit() {
      console.log(this.email, 'ET', this.password)
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

        setTimeout(() => {
          this.showAlert = false
        }, 6000)
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
