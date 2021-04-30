import Vue from 'vue'
import { wrapFunctional } from './utils'

const components = {
  InputForgotPassword: () => import('../../components/InputForgotPassword.vue' /* webpackChunkName: "components/input-forgot-password" */).then(c => wrapFunctional(c.default || c)),
  InputForgotPasswordSave: () => import('../../components/InputForgotPasswordSave.vue' /* webpackChunkName: "components/input-forgot-password-save" */).then(c => wrapFunctional(c.default || c)),
  InputSignin: () => import('../../components/InputSignin.vue' /* webpackChunkName: "components/input-signin" */).then(c => wrapFunctional(c.default || c)),
  InputSignup: () => import('../../components/InputSignup.vue' /* webpackChunkName: "components/input-signup" */).then(c => wrapFunctional(c.default || c)),
  NavBar: () => import('../../components/NavBar.vue' /* webpackChunkName: "components/nav-bar" */).then(c => wrapFunctional(c.default || c))
}

for (const name in components) {
  Vue.component(name, components[name])
  Vue.component('Lazy' + name, components[name])
}
