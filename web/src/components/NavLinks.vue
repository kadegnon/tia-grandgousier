<template>
  <nav class="nav-links">
      <router-link class="link"
                   v-for="(rt,i) in routes"
                   v-bind:key="i"
                   :to="rt.to"
      >{{rt.name}}</router-link>

  </nav>

</template>

<script>
  const {routes} = require('@/assets/nav-links.json');

export default {
  name: "NavLinks",
  data() {
    return {
        routes
    };
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.nav-links {
  background-color: #f1f1f1;
  overflow: hidden;
  /* text-align: center; */
}

.link {
  float: left;
  display: block;
  color: gray;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
  font-size: 17px;
  border-bottom: 3px solid transparent;
}

.link:visited {
  color: #607d8b;
}

.link:not(.router-link-active):hover {
  border-top: 2px solid #039be5;
}

.link.router-link-active {
  border-bottom: 3px solid #039be5;
}
</style>
