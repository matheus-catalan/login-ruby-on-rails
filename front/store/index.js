export const getters = {
  isAuthenticated(state) {
    return {
      name: this.$auth.$storage.getLocalStorage('userName'),
      email: this.$auth.$storage.getLocalStorage('userEmail'),
    }
  },

  loggedInUser(state) {
    return state.auth.user
  },
}
