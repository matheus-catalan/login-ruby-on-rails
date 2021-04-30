<template>
  <v-form ref="loginForm" v-model="valid" lazy-validation>
    <v-container class="my-10">
      <v-snackbar
        v-model="displayLoginError"
        color="#f05252"
        timeout="4000"
        top
        right
      >
        <span class="white--text">Usuário ou senha incorretos</span>

        <template #action="{ attrs }">
          <v-btn
            color="white"
            text
            v-bind="attrs"
            @click="displayLoginError = false"
          >
            Fechar
          </v-btn>
        </template>
      </v-snackbar>
      <v-row cols="12" style="flex-direction: column">
        <v-col col="12" class="mt-6">
          <v-text-field
            v-model="user.email"
            label="Email"
            name="email"
            :rules="loginEmailRules"
            required
            filled
            rounded
            dense
          ></v-text-field>
        </v-col>
        <v-col col="12" class="mt-5">
          <v-btn
            x-large
            block
            color="#011126"
            rounded
            dark
            :loading="isLoading"
            @click="validate"
          >
            Enviar
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>
<script scoped>
export default {
  data() {
    return {
      dialog: true,
      tab: 0,
      valid: true,
      verify: '',
      user: {
        email: '',
        password: '',
        confirmedPassword: '',
        name: '',
      },
      loginEmailRules: [
        (v) => !!v || 'Email precisa ser informado',
        (v) => /.+@.+\..+/.test(v) || 'E-mail não valido',
      ],
      show1: false,
      isLoading: false,
      displayLoginError: false,
    }
  },
  methods: {
    async validate() {
      if (this.$refs.loginForm.validate()) {
        this.isLoading = true
        try {
          await this.$axios.$post('/api/users', this.user)

          await this.$auth
            .loginWith('local', {
              data: this.user,
            })
            .then((res) => {
              this.$auth.setUser(res.data.user)
              this.$router.push('/')
            })
        } catch (err) {
          this.displayLoginError = true
        } finally {
          this.isLoading = false
        }
      }
    },
    reset() {
      this.$refs.form.reset()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    signup() {
      this.$emit('isSignup', { signin: false })
    },
  },
}
</script>
