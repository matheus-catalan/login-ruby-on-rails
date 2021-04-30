<template>
  <v-layout>
    <v-flex>
      <NavBar />
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  middleware: ['auth'],
}
</script>
