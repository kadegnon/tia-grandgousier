<template>
  <nav class="nav-links">
      <router-link class="link" to="/chat">BOT - Grandgousier</router-link>
      <router-link class="link" to="/vins">Vins</router-link>
      <router-link class="link" to="/settings">Paramètres</router-link>
      <router-link class="link" to="/about">A Propops du Groupe</router-link>
  </nav>

</template>

<script>
export default {
  name: "NavLinks",
  data() {
    return {};
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
/* .nav-links {} */

.link {
  margin: 10;
  padding: 5px 10px;
  border-radius: 4px;
  text-decoration: none;
  display: inline-block;
  font-size: large;
  background-color: #eee;
}

.link:visited {
  color: #607d8b;
}

.link:hover {
  color: #039be5;
  background-color: rgb(152, 165, 170);
}

.link + .router-link-active {
  color: red;
}
</style>
