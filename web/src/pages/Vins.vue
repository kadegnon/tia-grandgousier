<template>
  <section class="vins">
    <h1>Liste des vins</h1>
    <vin-list :vins="list">

    </vin-list>
  </section>
</template>

<script>
import VinList from '../components/VinList';

export default {
  name: "vins",
  components : {
    VinList,
  },
  data() {
    return {
      list : [
        { "id" : "mocky123", nom:"Bordeaux", annee:"2017"}
      ]
    }
  },

  methods : {
    remove(id){
      console.log("[Vins] Remove vin#"+id);
    }
  }
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>


</style>
