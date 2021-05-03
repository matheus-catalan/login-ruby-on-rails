<template>
  <div>
    <v-app-bar
      v-if="!drawer"
      class="d-lg-none d-sm-flex"
      color="#011126"
      dark
      flat
    >
      <v-app-bar-nav-icon
        larger
        class="ml-5"
        @click.stop="drawer = !drawer"
      ></v-app-bar-nav-icon>
    </v-app-bar>

    <v-navigation-drawer
      v-model="drawer"
      app
      color="#011126"
      dark
      expand-on-hover
      class="pt-5"
    >
      <v-list-item class="px-2" link href="/profile">
        <v-list-item-avatar>
          <v-img :src="userPicture"></v-img>
        </v-list-item-avatar>

        <v-list-item-content>
          <v-list-item-title>{{ userName }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-divider inset></v-divider>
      <v-list nav dense>
        <v-list-item link href="/">
          <v-list-item-icon>
            <v-icon color="white" medium>mdi-home</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Home</v-list-item-title>
        </v-list-item>
        <v-divider></v-divider>
        <v-list-item link href="/users">
          <v-list-item-icon>
            <v-icon color="white" medium>mdi-clipboard-list</v-icon>
          </v-list-item-icon>
          <v-list-item-title>Listar usuarios</v-list-item-title>
        </v-list-item>
      </v-list>
      <template #append>
        <v-list nav dense>
          <v-list-item link @click="doLogOut">
            <v-list-item-icon>
              <v-icon color="white" medium>mdi-exit-to-app</v-icon>
            </v-list-item-icon>
            <v-list-item-title>Sair</v-list-item-title>
          </v-list-item>
        </v-list>
      </template>
    </v-navigation-drawer>
  </div>
</template>

<script>
export default {
  data() {
    return {
      userName: this.$auth.$storage.getLocalStorage('userName'),
      userEmail: this.$auth.$storage.getLocalStorage('userEmail'),
      userPicture: this.$auth.$storage.getLocalStorage('userPicture'),
      drawer: true,
    }
  },
  methods: {
    async doLogOut() {
      await this.$auth.logout()
      this.$auth.$storage.removeLocalStorage('userName')
      this.$auth.$storage.removeLocalStorage('userEmail')
      this.$auth.$storage.removeLocalStorage('userPicture')

      this.$router.push('/login')
    },
    isDrawer() {
      this.$emit('isDrawer')
    },
    profile() {
      this.$router.push('/profile')
    },
  },
}
</script>
