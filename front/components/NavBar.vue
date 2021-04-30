<template>
  <div>
    <v-app-bar color="deep-purple accent-4" dense dark>
      <v-toolbar-title>Usuarios</v-toolbar-title>

      <v-spacer></v-spacer>

      <v-menu
        content-class="elevation-4"
        :close-on-content-click="false"
        min-width="140px"
        open-on-click
        offset-y
      >
        <template #activator="{ on, attrs }">
          <v-btn class="mr-3" icon v-bind="attrs" v-on="on">
            <v-icon>mdi-account-box</v-icon>
          </v-btn>
        </template>

        <v-list dense>
          <v-subheader class="justify-center">Conta</v-subheader>

          <v-divider class="mx-2" />

          <v-list-item>
            <v-list-item-avatar>
              <v-icon>mdi-account-circle</v-icon>
            </v-list-item-avatar>

            <v-list-item-content>
              <v-list-item-title>{{ loggedInUser.name }}</v-list-item-title>
              <v-list-item-subtitle>{{
                loggedInUser.email
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>

          <v-list-item @click="doLogOut">
            <v-list-item-title style="cursor: pointer">
              Sair
            </v-list-item-title>
          </v-list-item>
        </v-list>
      </v-menu>
    </v-app-bar>
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters(['isAuthenticated', 'loggedInUser']),
  },
  methods: {
    async doLogOut() {
      await this.$auth.logout(/* .... */)
      this.$router.push('/login')
    },
  },
}
</script>
