<template>
  <section class="vins">
    <h1>Liste des vins</h1>
    <vin-list :vins="list" style="float:left">
    </vin-list>
    <vin-details style="float:right">
    </vin-details>
  </section>
</template>

<script>
import VinList from '../components/VinList';
import VinDetails from '../components/VinDetails';

export default {
  name: "vins",
  components : {
    VinList,
    VinDetails,
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
