<template>
  <section class="vins">
    <vin-list class="view list">
    </vin-list>
    <!-- test -->
    <router-view name="details" class="view details" >
      Test
    </router-view>

    <!--
      <vin-list :vins="list">
    </vin-list>
    <vin-details>
    </vin-details> -->
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
.view {

}

.view.list{
  float: left;
}

.view.details{
  float: right;
}

</style>
