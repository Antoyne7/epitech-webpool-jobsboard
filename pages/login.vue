<template>
  <b-container>
    <div class="row">
      <b-col class="login-box" lg="8" md="10" cols="12">
        <h2>Se connecter à Jobs</h2>
        <b-col class="fieldset" lg="9" md="10" cols="12">
          <form @submit.prevent="submit()">
            <StyledInput :email.sync="email" var-to-update="email" class="input-login" placeholder="Email" type="email"
                         identifier="email"/>
            <StyledInput icone="eye.svg" :password.sync="password" var-to-update="password" class="input-login"
                         placeholder="Mot de passe"
                         type="password" identifier="password"/>
            <Alert style="text-align: center" :msg="alertMsgGlobal" :type="alertTypeGlobal" v-show="showAlertGlobal"/>
            <div @click="submit()">
              <AuthButton text="Connexion"/>
            </div>
          </form>
          <nuxt-link to="/register">
            <AuthRedirection class="auth-redirection"
                             text="Créer un compte"/>
          </nuxt-link>
          <AuthRedirection class="auth-redirection" text="Mot de passe oublié"/>
        </b-col>
      </b-col>
    </div>
  </b-container>
</template>

<script>
import Alert from "@/components/Alert";
import AuthButton from "~/components/AuthButton";
import StyledInput from "~/components/StyledInput";
import AuthRedirection from "~/components/AuthRedirection";
import AjaxServices from '~/services/ajaxServices'
import param from "@/param/param";

export default {

  name: "login.vue",
  layout: 'auth',
  data() {
    return {
      email: null,
      password: null,
      alertMsgGlobal: null,
      alertTypeGlobal: null,
      showAlertGlobal: false
    }
  },
  components: {AuthRedirection, AuthButton, StyledInput},

  methods: {
    submit() {
      if (this.email === null || this.password === null || this.email == "" || this.password == "") {
        this.alertMsgGlobal = param.message.errNoInfo;
        this.alertTypeGlobal = "error";
        this.showAlertGlobal = true;
      } else {
        const params = new FormData();
        params.append('email', this.email);
        params.append('password', this.password);

        AjaxServices.pushInformations('login', params).then(({token, expiresIn, statusCode}) => {
          console.log({token, expiresIn, statusCode})
          this.$store.dispatch('setToken', {token, expiresIn});
          this.$router.push('/')
        }).catch((error) => {
          console.log(error)
          this.alertMsgGlobal = param.message.errDefault;
          this.alertTypeGlobal = "error";
          this.showAlertGlobal = true;
        })

      }
    },
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
  margin: auto;
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
