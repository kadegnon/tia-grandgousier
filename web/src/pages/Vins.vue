<template>
  <section class="vins row">

    <vin-list class="view-list column"
              :vins="list"  :selected="selected"
              @add-vin="add"  @remove-vin="remove"
              @select-vin="select"
    >
    </vin-list>

    <router-view name="details" class="view-details column" >
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
      list : [ ],
      selected : 'cf590a5e'
    }
  },

  created() {
    this.getListVins();
    this.selected = this.$route.params.id || '';
  },
  beforeDestroy(){
    // this.$off(['select-vin','remove-vin']);
  },
  methods : {
    remove(id){
      const ok = window.confirm('Voulez-vous vraiment supprimer ce vin !?');
      if(ok) {
        console.log("[Vins] Remove vin #", id);
        this.$http.delete('vino/')
              .then(res => {
                this.list.splice(this.list.findIndex(v => v.id == id),1);
                this.$bus.$emit('msg-warning','Vin supprimé !')
              })
              .catch(e => this.$bus.$emit('msg-warning','Erreur lors de la suppression !'));
      }
    },
    add(nom){
      console.log("[Vins] New vin : ",nom);
    },

    select(id) {
      console.log("[Vins] Current vin #", id);
      this.selected = id;
    },

    getListVins () {
      this.$http.get('vino/')
            .then(res => this.list = res.data)
            .catch(e => this.$bus.$emit('msg-error','Impossible de recuperer le catalogue'))
            // .catch(err => this.$emit('msg-error',err.body.statusText));
    }
  }
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
/* .view {

} */

.view-list{
  float: left;
}

.view-details{
  float: right;
}

</style>
