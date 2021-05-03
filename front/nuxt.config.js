export default {
  head: {
    title: 'Usuarios',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: '' },
    ],
    link: [{ rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }],
  },
  css: [],
  plugins: [],
  components: true,
  buildModules: [
    '@nuxtjs/eslint-module',
    '@nuxtjs/vuetify',
    '@nuxt/image',
    '@nuxtjs/auth',
  ],
  modules: ['@nuxtjs/axios', '@nuxtjs/pwa'],
  vuetify: {},
  auth: {
    strategies: {
      local: {
        endpoints: {
          login: {
            url: '/api/login',
            method: 'post',
            propertyName: 'token',
            credentials: true,
          },
          user: false,
          logout: false,
        },
        user: {
          property: true,
          autoFetch: true,
        },
        autoFetchUser: true,
        redirect: {
          login: '/login',
          logout: '/login',
          home: '/',
        },
      },
    },
  },
  axios: {
    baseUrl: 'http://localhost:8080',
  },
  pwa: {
    manifest: {
      lang: 'en',
    },
  },
  build: {},
}
