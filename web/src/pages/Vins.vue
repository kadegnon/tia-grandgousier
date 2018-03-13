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

const API_URL_TO_VINO = 'vino/';

export default {
  name: "vins",
  components : {
    VinList,
  },
  data() {
    return {
      list : [ ],
      selected : ''
    }
  },

  created() {
    this.getListVins();
    this.selected = this.$route.params.id || '';
    this.$bus.$on('vin-modif',this.modif);

  },

  beforeRouteUpdate(to, from, next){
    this.selected = to.params.id;
    next();
  },

  beforeDestroy(){
     this.$off(['vin-select','vin-add','vin-modif','vin-remove']);
  },
  methods : {
    remove(id){
      const ok = window.confirm('Voulez-vous vraiment supprimer ce vin !?');
      if(ok) {
        console.log("[Vins] Remove vin #", id);
        this.$http.delete(API_URL_TO_VINO)
              .then(res => {
                this.list.splice(this.list.findIndex(v => v.id == id), 1);
                this.$bus.$emit('msg-warning','Vin supprimé !');
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

    modif(id,data){
      console.log("[Vins] M.A.J. vin #", id, data);
      this.$http.put(API_URL_TO_VINO)
        .then(res => {
          this.list.splice(this.list.findIndex(v => v.id == id), 1, res.data);
          this.$bus.$emit('msg-success','Vin modifié!');
          this.$routes.push('/vins');
        })
        .catch(e => this.$bus.$emit('msg-warning','Erreur lors de la modification !'));
    },

    getListVins () {
      this.$http.get(API_URL_TO_VINO)
            .then(res => this.list = res.data)
            .catch(e => this.$bus.$emit('msg-error','Impossible de recuperer le catalogue'))
            // .catch(err => this.$emit('msg-error',err.body.statusText));
    }
  }
};
</script>


<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.vins {
  text-align:center;
  width: 100%;
}

.column {
  min-width:250px;
  margin: 2%;

}

.view-list{
  float: left;
}


@media (max-width: 700px) {
  .column {
    width: 75%;
  }
}

</style>
