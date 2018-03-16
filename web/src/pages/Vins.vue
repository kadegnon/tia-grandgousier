<template>
  <section class="vins row">

    <vin-list class="view-list column"
              :vins="list"  :selected="selected"
              @vin-new="redirectToNewVin"  @vin-remove="remove"
              @vin-select="redirectToVinDetails"
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
    this.selected = this.$route.params.id;

    this.$bus.$on('vin-add',this.add);
    this.$bus.$on('vin-modif',this.modif);
    this.$bus.$on('vin-remove',this.remove);

  },

  beforeRouteUpdate(to, from, next){
    this.selected = to.params.id;
    next();
  },

  beforeDestroy(){
     this.$off(['vin-select','vin-add','vin-modif','vin-remove']);
  },
  methods : {
    redirectToNewVin(nom){
      console.log("[Vins] Adding new vin : ", nom);
      this.$router.push({name : 'vinNew', query : {nom}});
    },
    redirectToVinDetails(id) {
      console.log("[Vins] Selected vin #", id);
      this.selected = id;
      this.$router.push({ name: 'vinDetails', params: {id }});
    },

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
    add(vin){
      console.log("[Vins] New vin : ",vin);

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
