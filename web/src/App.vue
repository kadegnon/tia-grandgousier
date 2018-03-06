<template>
  <div id="app">
    <!-- <img src="./assets/logo.png"> -->
    <NavLinks>
    </NavLinks>

    <router-view> </router-view>

  </div>
</template>

<script>
  import NavLinks from './components/NavLinks';


  export default {
    name: 'App',
    components: {
      NavLinks
    },
  };
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    margin-top: 60px;
  }
</style>
