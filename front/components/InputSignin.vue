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
          <v-text-field
            v-model="user.password"
            :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
            :rules="[rules.required]"
            :type="show1 ? 'text' : 'password'"
            name="password"
            label="Senha"
            filled
            rounded
            dense
            @click:append="show1 = !show1"
          ></v-text-field>
          <v-btn
            :disabled="isLoading"
            class="ma-0"
            color="grey"
            plain
            @click="forgotPassword"
          >
            esqueci minha senha
          </v-btn>
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
            Login
          </v-btn>
        </v-col>
        <v-col col="12">
          <v-btn
            :disabled="isLoading"
            class="ma-0"
            color="primary"
            plain
            style="margin-top: 100px"
            @click="signup"
          >
            Não tenho uma conta
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
      },
      loginEmailRules: [
        (v) => !!v || 'Email precisa ser informado',
        (v) => /.+@.+\..+/.test(v) || 'E-mail não valido',
      ],
      emailRules: [
        (v) => !!v || 'Email precisa ser informado',
        (v) => /.+@.+\..+/.test(v) || 'E-mail não valido',
      ],
      show1: false,
      rules: {
        required: (value) => !!value || 'Senha precisa ser informado.',
      },
      isLoading: false,
      displayLoginError: false,
    }
  },
  computed: {
    passwordMatch() {
      return () => this.user.password === this.verify || 'Dados incorretos!'
    },
  },
  methods: {
    async validate() {
      if (this.$refs.loginForm.validate()) {
        this.isLoading = true
        try {
          await this.$auth
            .loginWith('local', {
              data: this.user,
            })
            .then((res) => {
              this.$auth.$storage.setLocalStorage(
                'userName',
                res.data.user.name
              )
              this.$auth.$storage.setLocalStorage(
                'userEmail',
                res.data.user.email
              )
              this.$auth.$storage.setLocalStorage(
                'userPicture',
                res.data.user.photo
              )
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
      this.$emit('isSignup')
    },
    forgotPassword() {
      this.$emit('forgotPassword')
    },
  },
}
</script>
