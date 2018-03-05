<template>
  <div id="app">
    <img src="./assets/logo.png">
    <HelloWorld/>
    <Chat/>
    <Vins/>
  </div>
</template>

<script>
  import HelloWorld from './pages/HelloWorld';
  import Chat from './pages/Chat';
  import Vins from './pages/Vins';
  import About from './pages/About';


  export default {
    name: 'App',
    components: {
      HelloWorld,
      Chat,
      Vins,
      About,
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
