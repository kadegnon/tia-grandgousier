<template>
  <article class="vinos">
    <input v-model.trim="searchInput"
        type="text" class="vin-search-input"
        placeholder="Chercher un vin" title="Entrer un nom de vin">
    <ul class="vinos-list" v-if="filteredList.length > 0">
      <template v-for="vin in filteredList">
        <li :key="vin.id">
          <router-link :to="{ name: 'vinDetails', params: {id: vin.id }}">
            <span class="badge">{{vin.annee}}</span>
            <span class="nom">{{vin.nom.trim()}} </span>
          </router-link>
        </li>
      </template>
    </ul>
      <template v-else>
        <router-link to="/vins/new">Ajouter un nouveau vin <b>&#x201c;{{searchInput}}&#x201d; &quest;</b></router-link>
      </template>
  </article>
</template>

<script>
export default {
  name: "vinList",
  props: ["vins"],
  data() {
    return {
      searchInput: ""
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
  }
};
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.vinos {
  width: 25%;
}

.vin-search-input {
  background-image: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABUAAAAVCAYAAACpF6WWAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAAEnQAABJ0Ad5mH3gAAAACYktHRAD/h4/MvwAAAAl2cEFnAAABKgAAASkAUBZlMQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAxMy0wNC0xMFQwNjo1OTowNy0wNzowMI5BiVEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMTMtMDQtMTBUMDY6NTk6MDctMDc6MDD/HDHtAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAABF0RVh0VGl0bGUAc2VhcmNoLWljb27Cg+x9AAACKklEQVQ4T6WUSavqQBCFK+2sII7gShFXLpUsBBHFf+1KcAQFwaWiolsnnBDn++4p0iHRqPDuByFJd/Wp6qrqVn5+IQP3+52m0ymtVis6Ho885na7KRgMUiKR4O9vmEQHgwGNx2NyOp0khCBFUXgcJo/Hg67XK8ViMcpkMjz+Dl200+nQZrMhh8PBE4gYQgDidrudvzEOm2KxyP9WsCginM1mHKEUS6VSFA6HOWI4G41GPAfx2+1GgUCAVFXVZMwovwY/lUqFPB4PiyFn+XxemzbT6/VovV6z8Ol0olwux+LPCBQFEQKIvhME2WyWbWGHFCD/VghUGVvE1rDlb6TTabbFmuVyqY2aEWgbFALeI5GINvyeUCjEtlgju+IZoRWfkS30CURoxFJUNjMEt9stf38CNjJKIFvNiMBJgTebzcZt843hcMhCELWqPBDxeJwulwtvC/3X7/e1qVfgFD0rC5tMJrUZM8Lr9VI0GmVBRDCfz6nZbHI/Sna7HXW7XZpMJtxSiBIP1lmhH9NqtaqfGKQDTmQREBnSgwfmMqfYYblc1o+2xHShtNttLgSiee4EmMEp3hDBPJzikimVSuRyuTTLJ1GwWCz4pCB3UhiL/X4/Hw50C5zjLSM+n898weCogxdRIzAGxigAdtNqtV6EC4UC+Xy+z6Kf2O/31Gg0TMK4ZBDxf4uCw+FA9XpdF0aaUOg/iQLcHbVaTb/p0Cl/FgXIJ/oYnaCqKv0DC6dltH6Ks84AAAAASUVORK5CYII=");
  background-position: 10px 12px;
  background-repeat: no-repeat;
  width: 20%;
  font-size: 16px;
  margin-bottom: 12px;
  padding: 12px 20px 12px 40px;
  border: 2px solid #c3c9d4;
  -webkit-transition: width 0.4s ease-in-out;
  transition: width 0.4s ease-in-out;

}

/* When the input field gets focus, change its width to 100% */
.vin-search-input:focus {
  width: 100%;
}

.vinos-list {
  list-style-type: none;
  /* padding: 0;
  margin: 0; */
}

.vinos-list li a {
  border: 1px solid #ddd;
  margin-top: -1px; /* Prevent double borders */
  background-color: #f6f6f6;
  padding: 12px;
  text-decoration: none;
  font-size: 15px;
  color: black;
  display: block;
}

.vinos-list li a:hover:not(.header) {
  background-color: #eee;
  color: #607d8b;
}

/*

.vins {
  margin: 0 0 2em 0;
  list-style-type: none;
  padding: 0;
  width: 15em;
}
.vins li {
  position: relative;
  cursor: pointer;
  background-color: #EEE;
  margin: .5em;
  padding: .3em 0;
  height: 1.6em;
  border-radius: 4px;
}

.vins li:hover {
  color: #607D8B;
  background-color: #DDD;
  left: .1em;
}

.vins a {
  color: #888;
  text-decoration: none;
  position: relative;
  display: block;
  width: 250px;
}

.vins a:hover {
  color:#607D8B;
}

.vins .badge {
  display: inline-block;
  font-size: small;
  color: white;
  padding: 0.8em 0.7em 0 0.7em;
  background-color: #607D8B;
  line-height: 1em;
  position: relative;
  left: -1px;
  top: -4px;
  height: 1.8em;
  min-width: 16px;
  text-align: right;
  margin-right: .8em;
  border-radius: 4px 0 0 4px;
}

.btne {
  background-color: #eee;
  border: none;
  padding: 5px 10px;
  border-radius: 4px;
  cursor: pointer;
  cursor: hand;
  font-family: Arial;
}

.btne:hover {
  background-color: #cfd8dc;
}

.btne.remove {
  position: relative;
  left: 194px;
  top: -32px;
  background-color: gray !important;
  color: white;
}

*/
</style>
