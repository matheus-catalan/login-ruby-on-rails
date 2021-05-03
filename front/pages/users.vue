<template>
  <v-layout>
    <v-flex>
      <NavBar @isDrawer="drawer = !drawer" />
      <v-snackbar
        v-model="displayError"
        color="#f05252"
        timeout="4000"
        top
        right
      >
        <span class="white--text">Ops, algo de errado aconteceu!</span>

        <template #action="{ attrs }">
          <v-btn
            color="white"
            text
            v-bind="attrs"
            @click="displayError = false"
          >
            Fechar
          </v-btn>
        </template>
      </v-snackbar>
      <v-snackbar
        v-model="displaySuccess"
        color="#011126"
        timeout="4000"
        top
        right
      >
        <span class="white--text">Usuario excluido com sucesso</span>

        <template #action="{ attrs }">
          <v-btn
            color="white"
            text
            v-bind="attrs"
            @click="displaySuccess = false"
          >
            Fechar
          </v-btn>
        </template>
      </v-snackbar>
      <div class="container-welcome mt-12">
        <v-container fill-height>
          <v-row align="center" justify="center" col="12">
            <v-col cols="10">
              <v-card elevation="3" class="rounded-xl">
                <v-card-title> Lista de usuarios </v-card-title>
                <v-card-text class="mt-5">
                  <v-container min-height="600px">
                    <v-row align="center" min-height="600px">
                      <v-expansion-panels class="rounded-xl">
                        <v-expansion-panel
                          v-for="(user, index) in this.users"
                          :key="index"
                        >
                          <v-expansion-panel-header>
                            {{ user.name }}
                            <template #actions>
                              <v-avatar color="primary" size="45"
                                ><img :src="user.photo" alt="John"
                              /></v-avatar>
                            </template>
                          </v-expansion-panel-header>
                          <v-expansion-panel-content>
                            <p class="ml-5">email: {{ user.email }}</p>
                            <p class="ml-5">
                              cadastrado: {{ user.created_at }}
                            </p>
                            <v-btn
                              v-if="!isCurrentUser(user.name, user.email)"
                              rounded
                              outlined
                              class="ml-5"
                              color="error"
                              :loading="isLoading"
                              @click="deleteUser(user.id)"
                            >
                              Excluir
                            </v-btn>
                          </v-expansion-panel-content>
                        </v-expansion-panel>
                      </v-expansion-panels>
                    </v-row>
                  </v-container>
                </v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-container>
      </div>
    </v-flex>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  middleware: ['auth'],
  async mounted() {
    const res = await this.$axios.$get('api/index/users')
    this.users = res.users
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'loggedInUser']),
  },
  data() {
    return {
      drawer: false,
      users: [],
      userName: this.$auth.$storage.getLocalStorage('userName'),
      userEmail: this.$auth.$storage.getLocalStorage('userEmail'),
      displayError: false,
      displaySuccess: false,
      isLoading: false,
    }
  },
  methods: {
    home() {
      this.$router.push('/')
    },
    listUser() {
      this.$router.push('/users')
    },
    isCurrentUser(user, email) {
      return this.userName === user && this.userEmail === email
    },
    async deleteUser(userId) {
      this.isLoading = true

      try {
        await this.$axios.$delete(`api/users/${userId}`)
        this.users = this.users.filter((user) => {
          return user.id !== userId
        })
        this.displaySuccess = true
      } catch (err) {
        this.displayError = false
      } finally {
        this.isLoading = false
      }
    },
  },
}
</script>
