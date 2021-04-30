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
        <span class="white--text">Ops! Algo de errado aconteceu</span>

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
        <template>
          <v-stepper v-model="step" vertical>
            <v-stepper-step :complete="step > 1" step="1">
              Envio de confirmação
            </v-stepper-step>

            <v-stepper-content step="1">
              <v-text-field
                v-model="user.email"
                label="Confirme seu e-mail"
                name="email"
                :rules="loginEmailRules"
                required
                filled
                rounded
                dense
              ></v-text-field>
              <v-btn
                color="#011126"
                rounded
                dark
                :loading="isLoadingEmail"
                @click="sendEmail"
              >
                Enviar
              </v-btn>
              <v-btn text rounded @click="isCanceled"> Cancelar </v-btn>
            </v-stepper-content>

            <v-stepper-step :complete="step > 2" step="2">
              Criar nova senha
            </v-stepper-step>

            <v-stepper-content :complete="step > 2" step="2">
              <v-text-field
                v-model="tokenForgotPassword"
                label="Insira o código de recuperação de senha"
                name="tokenForgotPassword"
                :rules="[rules.requiredToken]"
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
              <v-text-field
                v-model="user.confirmedPassword"
                :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
                :rules="[rules.isEqualPasswords, rules.required]"
                :type="show1 ? 'text' : 'password'"
                name="confirmedPassword"
                label="Repita a senha"
                filled
                rounded
                dense
                @click:append="show1 = !show1"
              ></v-text-field>
              <v-btn
                color="#011126"
                dark
                rounded
                :loading="isLoadingToken"
                @click="sendPassword"
              >
                Enviar
              </v-btn>
            </v-stepper-content>
          </v-stepper>
        </template>
      </v-row>
    </v-container>
  </v-form>
</template>
<script scoped>
export default {
  data() {
    return {
      valid: true,
      step: 1,
      tokenForgotPassword: '',
      isLoadingToken: false,
      verify: '',
      user: {
        email: '',
        password: '',
        confirmedPassword: '',
        name: '',
      },
      isLogin: false,
      loginEmailRules: [
        (v) => !!v || 'Email precisa ser informado',
        (v) => /.+@.+\..+/.test(v) || 'E-mail não valido',
      ],
      show1: false,
      rules: {
        requiredToken: (value) => !!value || 'Token precisa ser informado.',
        required: (value) => !!value || 'Senha precisa ser informado.',
        isEqualPasswords: (value) =>
          value === this.user.password || 'As senhas não são iguais.',
        length: (value) =>
          value.length > 5 || 'Senha deve ter no minimo 6 caracteres',
      },
      isLoadingEmail: false,
      displayLoginError: false,
    }
  },
  methods: {
    reset() {
      this.$refs.form.reset()
    },
    resetValidation() {
      this.$refs.form.resetValidation()
    },
    signup() {
      this.$emit('isSignup')
    },
    isCanceled() {
      this.$emit('isCanceled')
    },
    async sendEmail() {
      try {
        this.isLoadingEmail = true
        await this.$axios.$post('/api/forgot/password', this.user)
        this.nextStep()
      } catch (err) {
        this.displayLoginError = true
        this.isLoadingEmail = false
      } finally {
        this.isLoadingEmail = false
      }
    },
    async sendPassword() {
      try {
        this.isLoadingToken = true
        await this.$axios.$post('/api/forgot/password/save', {
          tokenForgotPassword: this.tokenForgotPassword,
          password: this.user.password,
        })
        this.nextStep()
      } catch (err) {
        this.displayLoginError = true
        this.isLoadingToken = false
      } finally {
        this.isLoadingToken = false
      }
    },
    nextStep() {
      this.step = this.step + 1
      if (this.step === 3) this.signup()
    },
  },
}
</script>
