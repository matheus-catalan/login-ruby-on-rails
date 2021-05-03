<template>
  <v-layout>
    <v-flex style="width: 100%; height: 100%; align-items: center">
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
        color="success"
        timeout="4000"
        top
        right
      >
        <span class="white--text">Usuario atualizado com sucesso</span>

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
      <div class="mt-12">
        <v-container fill-height>
          <v-row align="center" justify="center" col="12">
            <v-col cols="10">
              <v-card elevation="3" class="rounded-xl">
                <v-card-text>
                  <v-container min-height="600px">
                    <v-row align="center" col="12">
                      <v-col col="6" align="center" justify="center">
                        <v-img
                          :lazy-src="photoURL"
                          :src="photoURL"
                          width="300px"
                          height="300px"
                          class="rounded-circle"
                          rounded
                          style="cursor: pointer"
                          @click="openInputFile"
                        />
                        <input
                          ref="inputFile"
                          hidden
                          type="file"
                          accept="image/png, image/jpeg"
                          @change="onFilePiked"
                        />
                      </v-col>
                      <v-col col="6" align="center" justify="center">
                        <v-text-field
                          v-model="user.name"
                          label="Confirme seu nome"
                          name="name"
                          required
                          filled
                          rounded
                          dense
                        ></v-text-field>
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
                          x-large
                          block
                          color="#011126"
                          rounded
                          dark
                          :loading="isLoading"
                          @click="submit"
                        >
                          Salvar
                        </v-btn>
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
    <v-navigation-drawer
      v-model="drawer"
      absolute
      temporary
      color="#011126"
      dark
    >
      <v-list dense dark class="pt-15">
        <v-list-item link @click="home">
          <v-list-item-icon>
            <v-icon>mdi-home</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title style="font-size: 16px">Home</v-list-item-title>
          </v-list-item-content>
        </v-list-item>

        <v-list-item link @click="listUser">
          <v-list-item-icon>
            <v-icon>mdi-clipboard-list</v-icon>
          </v-list-item-icon>

          <v-list-item-content>
            <v-list-item-title style="font-size: 16px"
              >Listar usuarios</v-list-item-title
            >
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </v-layout>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  middleware: ['auth'],
  async mounted() {
    const res = await this.$axios.$get('api/users')

    this.user = {
      email: res.user.email,
      name: res.user.name,
    }
    this.photoURL = res.photo ? res.photo : 'no-img.jpeg'
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'loggedInUser']),
  },
  data() {
    return {
      drawer: false,
      user: {
        email: '',
        name: '',
      },
      photoUpload: null,
      photoURL: '',
      isLoading: false,
      verify: '',
      loginEmailRules: [
        (v) => !!v || 'Email precisa ser informado',
        (v) => /.+@.+\..+/.test(v) || 'E-mail não valido',
      ],
      displayError: false,
      displaySuccess: false,
    }
  },
  methods: {
    home() {
      this.$router.push('/')
    },
    listUser() {
      this.$router.push('/users')
    },
    onFilePiked() {
      this.photoUpload = this.$refs.inputFile.files[0]
      this.photoURL = URL.createObjectURL(this.photoUpload)
      URL.revokeObjectURL(this.photoUpload)
    },
    async submit() {
      this.isLoading = true
      const params = {
        name: this.user.name,
        email: this.user.email,
        photo: this.photoUpload,
      }

      // eslint-disable-next-line prefer-const
      let formData = new FormData()

      Object.entries(params).forEach(([key, value]) =>
        formData.append(key, value)
      )
      const header = {
        'Content-Type': 'multipart/form-data',
      }
      try {
        const res = await this.$axios.$put('/api/users', formData, header)
        this.$auth.$storage.setLocalStorage('userName', res.name)
        this.$auth.$storage.setLocalStorage('userEmail', res.email)
        if (this.photoUpload)
          this.$auth.$storage.setLocalStorage('userPicture', res.photo)
        this.displaySuccess = true
      } catch (error) {
        this.displayError = true
      } finally {
        this.isLoading = false
      }
    },
    openInputFile() {
      this.$refs.inputFile.click()
    },
  },
}
</script>
