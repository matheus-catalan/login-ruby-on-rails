<template>
  <v-layout>
    <v-flex>
      <NavBar />
      <div class="container-welcome">
        <v-container fill-height>
          <v-row align="center" justify="center" col="12">
            <v-col cols="10">
              <v-card elevation="3" class="rounded-xl">
                <v-card-text>
                  <v-container min-height="600px">
                    <v-row align="center" col="12" min-height="600px">
                      <v-col col="6" align="center" justify="center">
                        <v-img
                          lazy-src="welcome.svg"
                          src="welcome.svg"
                          width="300px"
                        />
                      </v-col>
                      <v-col col="6" align="center" justify="center">
                        <h2>Seja bem vindo,</h2>
                        <h1 class="mt-3">{{ userName }}</h1>
                      </v-col>
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
export default {
  middleware: ['auth'],
  data() {
    return {
      drawer: false,
      userName: this.$auth.$storage.getLocalStorage('userName'),
      userEmail: this.$auth.$storage.getLocalStorage('userEmail'),
    }
  },
  methods: {
    home() {
      this.$router.push('/')
    },
    listUser() {
      this.$router.push('/users')
    },
  },
}
</script>
<style scoped>
.container-welcome {
  height: 100%;
  width: 100%;
  min-height: 600px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.x {
  width: 100%;
  justify-content: center;
}
</style>
