export default {
  // Global page headers (https://go.nuxtjs.dev/config-head)
  head: {
    title: "Jobs",
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { hid: "description", name: "description", content: "" }
    ],
    link: [
      { rel: "icon", type: "image/x-icon", href: "/favicon.ico" },
      {
        rel: "stylesheet",
        href:
          "https://fonts.googleapis.com/css2?family=Rubik:wght@300;400;500;600;700;900&display=swap"
      },
      {
        rel: "stylesheet",
        href: "https://pro.fontawesome.com/releases/v5.10.0/css/fontawesome.css"
      },
      {
        rel: "stylesheet",
        href:
          "https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
      }
    ],
    script: [
      {
        src: "https://cdn.jsdelivr.net/npm/marked/marked.min.js"
      }
    ]
  },
  router: [],

  // Global CSS (https://go.nuxtjs.dev/config-css)
  css: [],

  // Plugins to run before rendering page (https://go.nuxtjs.dev/config-plugins)
  plugins: [],

  // Auto import components (https://go.nuxtjs.dev/config-components)
  components: true,

  // Modules for dev and build (recommended) (https://go.nuxtjs.dev/config-modules)
  buildModules: [],

  // Modules (https://go.nuxtjs.dev/config-modules)
  modules: [

    // https://go.nuxtjs.dev/bootstrap
    [
      "bootstrap-vue/nuxt",
      {
        icons: true
      }
    ],
    // https://go.nuxtjs.dev/axios
    "@nuxtjs/axios",
    // https://go.nuxtjs.dev/pwa

    "@nuxtjs/pwa",
    "@nuxtjs/auth",
  ],

  auth: {
    cookie: {
      options: {
        secure: false
      }
    },
    redirect: {
      home: "/",
      login: "/login",
      logout: "/login",
      callback: false
    },
    strategies: {
      local: {
        endpoints: {
          login: {
            url: "/back/api/login",
            method: "post",
            propertyName: false
          },
          user: {
            url: "/back/api/me",
            method: "get",
            propertyName: false
            // withCredentials: true,
            // headers: {
            //   'Referer': 'http://localhost:3000', // <- here
            //   'Accept': 'application/json',
            //   'X-Requested-With': 'XMLHttpRequest',
            //   'Content-Type': 'application/json'
            // }
          },
          logout: {
            url: "/back/api/logout",
            method: "post",
            propertyName: false
          }
        }
        // tokenRequired: false,
        // tokenType: false
      }
    },
    localStorage: false
  },

  // Axios module configuration (https://go.nuxtjs.dev/config-axios)

  // Serveur : https://backend.antoinebraillard.tech/jobboard/public/index.php/api/
  // local : http://localhost/EPITECH/PROJETS/JOBBOARD/T-WEB-501-STG-5-1-jobboard-lucas.michalet/back/public/api/)
  axios: {
    //
    // baseURL: 'https://backend.antoinebraillard.tech/jobboard/public/index.php/',
    baseURL: 'http://jobs.epitech.fr/back/public/',
    credentials: true,
    proxy: true
  },

  proxy: {
    "/back": {
      // target: "http://localhost/EPITECH/PROJETS/JOBBOARD/T-WEB-501-STG-5-1-jobboard-lucas.michalet/back/public/",
      target: "http://jobs.epitech.fr/back/public/",
      pathRewrite: { "^/back": "/" }
    }
  },

  // Build Configuration (https://go.nuxtjs.dev/config-build)
  build: {}
};
