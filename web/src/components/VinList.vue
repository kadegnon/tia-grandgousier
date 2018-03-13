<template>
  <article class="vinos">
    <div class="header">
    <h2>Catalogue des vins</h2>
    <input v-model.trim="searchInput" @keyup.enter="addVin"
        type="text" class="vin-search-input"
        placeholder="Chercher un vin" title="Entrer un nom de vin">
    <span class="btn-add" title="Ajouter un nouveau vin"
          v-show="filteredList.length == 0"
          @click="addVin"
    >&#x271A;</span>
    </div>
    <ul class="vinos-list" v-if="filteredList.length > 0">
      <template v-for="vin in filteredList">
        <li :key="vin.id"  @click.prevent.stop="selectVin(vin.id)"
            v-bind:class="{'vinos-list-item':true, 'selected':(vin.id === selected)}"
        >
          <span class="btn-remove" title="Supprimer ce vin"
                @click.self.stop="removeVin(vin.id)"
          >&#x2716;</span>
            <!-- <span class="badge">{{vin.annee}}</span> -->
          <span class="nom">{{vin.nom.trim()}}</span>

        </li>
      </template>
    </ul>
    <template v-else>
      <div class="link-add"
          v-show="this.searchInput" @click="addVin">Ajouter un nouveau vin <b>&#x201c;{{searchInput}}&#x201d; &quest;</b></div>
    </template>
  </article>
</template>

<script>
export default {
  name: "vinList",
  props : {
    vins : {
      type : Array,
      required : true
    },
    selected : ''
  },
  data() {
    return {
      searchInput: '',
      // selected : 'cf590a5e'
    };
  },
  computed: {
    filteredList() {
      if (!this.searchInput) return this.vins;

      return this.vins.filter(v => {
        let found = v.nom
          .toLowerCase()
          .includes(this.searchInput.toLowerCase());
        found = !found ? ("" + v.annee).includes(this.searchInput) : found;
        return found;
      });
    }
  },

  methods : {
    addVin(){
      this.$emit('vin-add', this.searchInput);
      this.$router.push({name : 'vinNew', query : {nom : this.searchInput }});
      this.searchInput = '';
    },
    selectVin(id){
      this.$emit('vin-select', id);
      this.$router.push({ name: 'vinDetails', params: {id }});
    },

    removeVin(id){ this.$emit('vin-remove', id);},
  },
};
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
* {
  box-sizing: border-box;
  text-align: center;
}

.header {
  padding: 10px 0;
  color: black;
  text-align: center;
}

.header:after {
  content: "";
  display: table;
  clear: both;
  max-width: 80%;
}


.header > .vin-search-input {
  background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAYAAACpF6WWAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAACYktHRAD/h4/MvwAAAAl2cEFnAAABKgAAASkAUBZlMQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxMy0wNC0xMFQwNjo1OTowNy0wNzowMI5BiVEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTMtMDQtMTBUMDY6NTk6MDctMDc6MDD/HDHtAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAABF0RVh0VGl0bGUAc2VhcmNoLWljb27Cg+x9AAACKklEQVQ4T6WUSavqQBCFK+2sII7gShFXLpUsBBHFf+1KcAQFwaWiolsnnBDn++4p0iHRqPDuByFJd/Wp6qrqVn5+IQP3+52m0ymtVis6Ho885na7KRgMUiKR4O9vmEQHgwGNx2NyOp0khCBFUXgcJo/Hg67XK8ViMcpkMjz+Dl200+nQZrMhh8PBE4gYQgDidrudvzEOm2KxyP9WsCginM1mHKEUS6VSFA6HOWI4G41GPAfx2+1GgUCAVFXVZMwovwY/lUqFPB4PiyFn+XxemzbT6/VovV6z8Ol0olwux+LPCBQFEQKIvhME2WyWbWGHFCD/VghUGVvE1rDlb6TTabbFmuVyqY2aEWgbFALeI5GINvyeUCjEtlgju+IZoRWfkS30CURoxFJUNjMEt9stf38CNjJKIFvNiMBJgTebzcZt843hcMhCELWqPBDxeJwulwtvC/3X7/e1qVfgFD0rC5tMJrUZM8Lr9VI0GmVBRDCfz6nZbHI/Sna7HXW7XZpMJtxSiBIP1lmhH9NqtaqfGKQDTmQREBnSgwfmMqfYYblc1o+2xHShtNttLgSiee4EmMEp3hDBPJzikimVSuRyuTTLJ1GwWCz4pCB3UhiL/X4/Hw50C5zjLSM+n898weCogxdRIzAGxigAdtNqtV6EC4UC+Xy+z6Kf2O/31Gg0TMK4ZBDxf4uCw+FA9XpdF0aaUOg/iQLcHbVaTb/p0Cl/FgXIJ/oYnaCqKv0DC6dltH6Ks84AAAAASUVORK5CYII=");
  background-position: 12px;
  background-repeat: no-repeat;
  /* float: left; */
  width: 85%;
  font-size: 16px;
  margin-bottom: 12px;
  padding: 12px 20px 12px 40px;
  border: 2px solid #c3c9d4;
  -webkit-transition: width 0.4s ease-in-out;
  transition: width 0.4s ease-in-out;

}

/* Style the "Add" button */
.header > .btn-add {
  cursor: pointer;
  padding: 12.8px;
  background: #d9d9d9;
  color: #555;
  float: right;
  text-align: center;
  font-weight: bold;
  text-decoration: none;
}

.header > .btn-add:hover {
  background-color: #bbb;
}


.vinos-list {
  margin: 0;
  padding: 0;
  list-style-type: none;
}

.vinos-list-item {
  cursor: pointer;
  position : relative;
  border: 1px solid #ddd;
  margin-top: -1px; /* Prevent double borders */
  padding: 12px 8px 12px 40px;
  background-color: blanchedalmond;

    /* make the list items unselectable */
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}

.vinos-list-item:hover, .vinos-list-item.selected {
  background-color: #eee;
  color: #fff;
  color: #607d8b;
}

.vinos-list-item > .btn-remove {
  display: none;
}

.vinos-list-item:hover > .btn-remove{
  display: inline;
  padding: 14px;
  position: absolute;
  font-weight: bolder;
  cursor: pointer;
  top: 0;
  left: 0;
}

.btn-remove:hover {
  background-color: crimson;
  color: #fff;
}

.link-add {
  text-decoration: none;
  cursor: pointer;
}

.link-add:hover {
  border-left: 3px solid aquamarine;
}

</style>
