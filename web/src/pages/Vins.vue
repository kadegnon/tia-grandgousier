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
import {APIVino as ApiVino} from "@/services/api-vino";
import VinList from '@/components/VinList';

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
    this.selected = this.$route.params.id; // Select vin dans VinList

    this.$bus.$on('list-of-caracteristic', this.getListOfSelect);
    this.$bus.$on('vin-details', this.getDetailsVin);
    this.$bus.$on('vin-add',this.add);
    this.$bus.$on('vin-modif',this.modif);
    this.$bus.$on('vin-remove',this.remove);

  },

  beforeRouteUpdate(to, from, next){
    this.selected = to.params.id;
    next();
  },

  beforeDestroy(){
    this.$bus.$off([
      'list-of-caracteristic', 'list-select',
      'vin-select', 'vin-details',
      'vin-add','vin-modif','vin-remove'
    ]);
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

    getListOfSelect(){
      const sendList = (type) => list  => this.$bus.$emit('list-select',[type,list.sort()]);

      const warnFor = (type) => _ => {
        this.$bus.$emit('msg-error','Impossible de recuperer la liste pour les '+ type);
      }

      let typeList = 'appellations';
      ApiVino.getListAppellations()
        .then(sendList(typeList))
        .catch(warnFor(typeList));

      typeList = 'services';
      ApiVino.getListServices()
        .then(sendList(typeList))
        .catch(warnFor(typeList));

      typeList = 'plats';
      ApiVino.getListPlats()
        .then(sendList(typeList))
        .catch(warnFor(typeList));

    },

    getDetailsVin(id){
      ApiVino.getDetailsVin(id)
        .then(details => this.$bus.$emit('vin-details#'+id, details))
        .catch( _ => this.$bus.$emit('msg-error','Impossible de recuperer le vin '+ id));
    },

    add(newVin){
      console.log("[Vins] New vin : ", newVin);
      ApiVino.addVin(newVin)
        .then(vin => {
          this.list.push(vin);
          console.log(this.list);
          this.$bus.$emit('msg-success',vin.nom + ' ajouté!');
          this.$router.replace({path: '/vins'});
        })
        .catch(_ => this.$bus.$emit('msg-error','Erreur lors de l\'ajout de \''+newVin.nom+'\''));
    },

    modif(id, updVin){
      console.log("[Vins] M.A.J. vin #", id);
      ApiVino.updateVin(updVin)
        .then(vin => {
          this.selected = null;
          this.list.splice(this.list.findIndex(v => v.id == id), 1, vin);
          this.$bus.$emit('msg-success','Vin modifié !');
          this.$router.replace({path: '/vins'});
        })
        .catch(_ => this.$bus.$emit('msg-error','Erreur lors de la modification !'));
    },

    remove(id){
      const ok = window.confirm('Voulez-vous vraiment supprimer ce vin !?');
      if(ok) {
        console.log("[Vins] Remove vin #", id);
        ApiVino.deleteVin(id)
          .then(_ => {
            this.list.splice(this.list.findIndex(v => v.id == id), 1);
            this.$bus.$emit('msg-warning','Vin supprimé !');
          })
          .catch(_ => this.$bus.$emit('msg-error','Erreur lors de la suppression du vin !'));
      }
    },

    getListVins () {
      ApiVino.getListVins()
        .then(vins => this.list = vins)
        .catch(_ => this.$bus.$emit('msg-error','Impossible de recuperer le catalogue des vins'));
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
