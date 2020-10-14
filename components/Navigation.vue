<template>
  <header>
    <nav>
      <b-container fluid>
        <div class="navbar-custom">
          <nuxt-link to="/"><h1>Job's</h1></nuxt-link>
          <div class="menu">
            <!-- TODO: Enlever true -->
            <span v-if="$store.state.auth.user.role === 2 || true"> 
              <nuxt-link
                v-if="isAdminRoute"
                class="mr-4 text-dark font-weight-bolder"
                to="/"
              >
                Front
              </nuxt-link>
              <nuxt-link
                v-else
                class="mr-4 text-dark font-weight-bolder"
                to="/admin"
              >
                Administration
              </nuxt-link>
              <button class="mr-3" @click="isShowedAdmin = !isShowedAdmin">
                <b-icon-gear-fill scale="3.3" />
                <span class="drop-d" v-show="isShowedAdmin">
                  <ul>
                    <li><b-icon-plus-square scale="2" /><nuxt-link :to="{ name: 'admin-offre-add' }">Nouvelle offre</nuxt-link></li>
                    <li><b-icon-file-earmark scale="2" /><nuxt-link :to="{ name: 'admin-offretype' }">Types de contrats</nuxt-link></li>
                    <li><b-icon-building scale="2" /><nuxt-link :to="{ name: 'admin-entreprise' }">Entreprises</nuxt-link></li>
                  </ul>                 
                </span>
              </button>
            </span>
            <nuxt-link to="/profil">
              <img src="/icons/ic_person_48px.svg" alt="Icône de personne" />
            </nuxt-link>
            <button @click="isShowedDcnx = !isShowedDcnx">
              <img src="/icons/disconnect.svg" alt="Icône deconnexion" />
              <span class="drop-d" v-show="isShowedDcnx">
                <a @click="disconnect()">Deconnexion</a>
              </span>
            </button>
          </div>
        </div>
      </b-container>
    </nav>
  </header>
</template>

<script>
export default {
  name: "Navigation.vue",

  data() {
    return {
      isShowedDcnx: false,
      isShowedAdmin: false,
      isAdminRoute: null
    };
  },
  watch: {
    $route() {
      this.updateIsAdminRoute();
    }
  },
  methods: {
    disconnect() {
      this.$auth
        .logout()
        .then(() => {
          console.log("success");
          this.$router.push("/login");
        })
        .catch(err => {
          console.dir(err);
        });
    },
    updateIsAdminRoute() {
      this.isAdminRoute = this.$route.name.includes("admin");
    }
  },
  mounted() {
    this.updateIsAdminRoute();
  }
};
</script>

<style lang="scss" scoped>
nav {
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  height: 80px;

  > .container-fluid {
    display: flex;
    height: 100%;
    padding: 0 20px;
  }

  .navbar-custom {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;

    a:hover {
      text-decoration: none;
    }

    h1 {
      font-family: Rubik, sans-serif;
      font-size: 4.8rem;
      text-transform: uppercase;
      font-weight: 900;
      color: var(--primary-jobs);
    }

    a {
      cursor: pointer;
      font-size: 1.6rem;
      color: inherit;
    }

    button {
      background: transparent;
      border: none;
      outline: none;
    }

    .drop-d {
      position: absolute;
      top: 80px;
      background: white;
      box-shadow: rgba(0, 0, 0, 0.1) 0 2px 4px;
      right: 20px;
      padding: 20px;
      z-index: 10;

      a {
        font-family: Rubik, sans-serif;
        font-size: 20px;
        font-weight: 500;
        position: relative;

        &:after {
          content: " ";
          position: absolute;
          top: 30px;
          left: 50%;
          width: 0;
          height: 2px;
          background: var(--primary-jobs);
          transition: all ease-in-out 0.3s;
        }

        &:hover {
          color: var(--primary-jobs);

          &:after {
            width: 10%;
            transform: translate(-50%) scaleX(9);
          }
        }
      }
      ul {
        padding: 0;
        list-style: none;
        margin: 0;
        li {
          display: flex;
          align-items: center;
          margin: 4px 0;
          text-align: left;

          svg {
            width: 24px;
            margin-right: 6px;
          }
        }
      }
    }
  }
}
</style>
