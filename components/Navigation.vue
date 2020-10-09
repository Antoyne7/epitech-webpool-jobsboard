<template>
  <header>
    <nav>
      <b-container fluid>
        <div class="navbar-custom">
          <nuxt-link to="/"><h1>Job's</h1></nuxt-link>
          <div class="menu">
            <nuxt-link to="/profil">
              <img src="/icons/ic_person_48px.svg" alt="Icône de personne">
            </nuxt-link>
            <button @click="dropdown()">
              <img src="/icons/disconnect.svg" alt="Icône deconnexion">
              <span class="drop-d" v-show="isShowed">
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
      isShowed: false,
    }
  },
  methods: {
    dropdown() {
      this.isShowed = !this.isShowed
    },
    disconnect() {
      this.$auth.logout()
        .then(() => {
          this.$router.push('/login')
        })
    }
  }

}
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
          transition: all ease-in-out .3s;
        }

        &:hover {
          color: var(--primary-jobs);

          &:after {
            width: 10%;
            transform: translate(-50%) scaleX(9);
          }
        }
      }
    }
  }
}
</style>
