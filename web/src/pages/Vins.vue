<template>
  <section class="vins">

    <vin-list class="view list" :vins="list">
    </vin-list>

    <router-view name="details" class="view details" >
    </router-view>

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
      list : [ ]
    }
  },

  created() {
    this.getListVins();
  },
  methods : {
    remove(id){
      console.log("[Vins] Remove vin#"+id);
    },

    getListVins () {
      this.$http.get('vino/')
            .then(res => this.list = res.data);
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
