import { wrapFunctional } from './utils'

export { default as InputForgotPassword } from '../../components/InputForgotPassword.vue'
export { default as InputForgotPasswordSave } from '../../components/InputForgotPasswordSave.vue'
export { default as InputSignin } from '../../components/InputSignin.vue'
export { default as InputSignup } from '../../components/InputSignup.vue'
export { default as NavBar } from '../../components/NavBar.vue'

export const LazyInputForgotPassword = import('../../components/InputForgotPassword.vue' /* webpackChunkName: "components/input-forgot-password" */).then(c => wrapFunctional(c.default || c))
export const LazyInputForgotPasswordSave = import('../../components/InputForgotPasswordSave.vue' /* webpackChunkName: "components/input-forgot-password-save" */).then(c => wrapFunctional(c.default || c))
export const LazyInputSignin = import('../../components/InputSignin.vue' /* webpackChunkName: "components/input-signin" */).then(c => wrapFunctional(c.default || c))
export const LazyInputSignup = import('../../components/InputSignup.vue' /* webpackChunkName: "components/input-signup" */).then(c => wrapFunctional(c.default || c))
export const LazyNavBar = import('../../components/NavBar.vue' /* webpackChunkName: "components/nav-bar" */).then(c => wrapFunctional(c.default || c))
