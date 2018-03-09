<template>
  <div id="app">
    <nav-links />

    <toast-msg />


    <router-view />

  </div>
</template>

<script>
  import NavLinks from './components/NavLinks';
  import ToastMsg from './components/ToastMsg';


  export default {
    name: 'App',
    components: {
      NavLinks,
      ToastMsg
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
    max-width: 650px;
    margin: 0 auto;
    padding: 30px 0;
  }
</style>
