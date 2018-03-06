<template>
  <section class="nav-links">
      <router-link class="link" to="/chat">BOt - Grandgousier</router-link> - 
      <router-link class="link" to="/vins">Vins</router-link> - 
      <router-link class="link" to="/settings">Paramètres</router-link> - 
      <router-link class="link" to="/about">A Propops du Groupe</router-link> - 
  </section>

</template>

<script>
export default {
  name: 'NavLinks',
  data() {
    return {
    };
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .nav-links{
  
  }

  .link {
      padding: 5px 10px;
      text-decoration: none;
      margin-top: 10px;
      display: inline-block;
      background-color: #eee;
      border-radius: 4px;
  }
  
  .link:visited {
      color: #607D8B;
  }
  
  .link .router-link-active{
      color: #039be5;
  }
  

</style>
