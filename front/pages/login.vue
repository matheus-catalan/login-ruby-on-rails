<template>
  <div class="container-login">
    <v-container fill-height fluid>
      <v-row align="center" justify="center" col="12">
        <v-snackbar
          v-model="displayLoginSucces"
          color="#011126"
          timeout="4000"
          top
          right
        >
          <span class="white--text">Senha salva com sucesso !</span>

          <template #action="{ attrs }">
            <v-btn
              color="white"
              text
              v-bind="attrs"
              @click="displayLoginSucces = false"
            >
              Fechar
            </v-btn>
          </template>
        </v-snackbar>
        <v-col cols="10">
          <v-card elevation="3" min-height="400px" class="rounded-xl">
            <v-card-text>
              <v-container>
                <v-row align="center" col="12">
                  <v-col col="6" align="center" justify="center">
                    <v-img :lazy-src="img" :src="img" width="450px" />
                  </v-col>
                  <v-col col="6" align="center" justify="center">
                    <InputSignin
                      v-if="signin && !forgotPassword"
                      @isSignup="signup"
                      @forgotPassword="_forgotPassword"
                    />
                    <InputSignup
                      v-if="!signin && !forgotPassword"
                      @isSignup="signup"
                    />
                    <InputForgotPassword
                      v-if="!signin && forgotPassword"
                      @isSignup="signup"
                      @isCanceled="canceledForgotPassword"
                    />
                  </v-col>
                </v-row>
              </v-container>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
export default {
  middleware: 'auth',
  data() {
    return {
      signin: true,
      img: 'login.svg',
      forgotPassword: false,
      displayLoginSucces: false,
    }
  },
  methods: {
    signup() {
      this.signin = !this.signin
      if (this.forgotPassword) {
        this.forgotPassword = false
        this.displayLoginSucces = true
      }

      if (this.img === 'login.svg') {
        this.img = 'login2.svg'
      } else {
        this.img = 'login.svg'
      }
    },
    _forgotPassword() {
      this.signin = false
      this.forgotPassword = true
      this.img = 'login3.svg'
    },
    canceledForgotPassword() {
      this.signin = !this.signin
      if (this.forgotPassword) {
        this.forgotPassword = false
      }

      if (this.img === 'login.svg') {
        this.img = 'login2.svg'
      } else {
        this.img = 'login.svg'
      }
    },
  },
}
</script>

<style scoped>
.container-login {
  height: 100%;
  width: 100%;
  display: grid;
  place-items: center;
}
.x {
  width: 100%;
  justify-content: center;
}
</style>
