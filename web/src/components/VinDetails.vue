<template>
  <article class="vino-details">
    <h2>{{$route.params.id ? 'Mise à jour du' : 'Ajout de'}} vin</h2>
    <form :method="id ? 'PUT' : 'POST'" @submit.prevent="saveVin">
      <div class="form-group">
        <div class="form-label">
          <label for="vappel">Appellation</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vappel')">L'appellation est requis</span>
          <select id="vappel" name="vappel"
                :class="{'form-input': true, 'error': errors.has('vappel') }"
                v-model="vin.appellation" v-validate="'required'"
          >
            <template v-for="(appel,index) in appellations" >
              <option :key="index" :value="appel" :selected="id && appel == vin.appellation">{{appel}}</option>
            </template>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vnom">Nom</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vnom')">Le nom est requis.</span>
          <input type="text" id="vnom" name="vnom" placeholder="Nom de vin"
                v-model="vin.nom" v-validate="'required'"
                :class="{'form-input': true, 'error': errors.has('vname') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vorigine">Origine</label>
        </div>
        <div class="form-control">
          <input type="text" id="vorigine" name="vorigine" placeholder="Origine de vin"
                v-model="vin.origine" :class="{'form-input': true, 'error': errors.has('vorigine') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vannee">Année</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vannee')">L'année est requis</span>
          <input type="number" id="vannee" name="vannee" placeholder="Année d'embouteillage du vin"
                :class="{'form-input': true, 'error': errors.has('vannee') }"
                v-model="vin.annee" v-validate="'required|numeric|min:4|max:4'"
                v-bind:max="new Date().getFullYear()"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vhtva">H.T.V.A</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vhtva')">Le prix HTVA est requis</span>
          <input type="number" id="vhtva" name="vhtva"  step="0.01" placeholder="Prix H.T.V.A"
                :class="{'form-input': true, 'error': errors.has('vhtva') }"
                v-model="vin.htva" v-validate="'required|decimal:2'"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vtvac">T.V.A.C</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vtvac')">Le prix TVAC est requis</span>
          <input type="number" id="vtvac" name="vtvac"  step="0.01" placeholder="Prix T.V.A.C"
                v-model="vin.tvac" v-validate="'required|decimal:2'"
                :class="{'form-input': true, 'error': errors.has('vtvac') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vdescrip">Description</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vdescrip')">La description est requis</span>
          <textarea id="vdescrip" name="vdescrip" placeholder="Description du vin" style="height:200px"
              v-model="vin.description"   v-validate="'required'"
              :class="{'form-input': true, /*'error': errors.has('vdescrip') */}" ></textarea>
        </div>
      </div>
      <div class="form-group">
        <input class="btn success" type="submit" :value="id ? 'Modifier' :'Sauvegarder'">
      </div>
    </form>
  </article>
</template>

<script>
const _defaultVin = ({
  nom: "", annee: 2017, origine: "",
  description: "", appellation: undefined,
  htva: 0.1,  tvac: 0.2
});
export default {
  name: "vinDetails",
  data() {
    return {
      id: undefined,
      appellations: [],
      vin: _defaultVin,
    };
  },
  created() {
    this.getListAppellations();
  },

  beforeRouteUpdate(to,from,next) {
    if (to.path === "/vins/new") {
      this.vin = _defaultVin;
      this.vin.nom = this.$route.query.nom;
      this.$el.querySelector('#vnom').focus();
      next();
    } else {
      this.id = this.$route.params.id;
      next(this.getVin());
    }

  },
  methods: {
    getListAppellations() {
      this.$http.get("appellation").then(res => (this.appellations = res.data));
    },
    getVin() {
      if (this.id) {
        this.$http.get("vino/" + this.id).then(res => (this.vin = res.data));
      }
    },
    saveVin() {
      if (this.errors.count() === 0) {
        if (this.id) {
          return this.$bus.$emit("vin-modif", this.id, this.vin);
        } else {
          return this.$bus.$emit("vin-add", this.vin);
        }
      }
      this.$bus.$emit("msg-warning", "Certains informations sont manquant !");
    }
  }
};
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.vino-details {
  border-radius: 5px;
  height: 100%;
  /* background-color: #f2f2f2; */
}

/* Clear floats after the columns */
.form-group:after {
  content: "";
  display: table;
  clear: both;
}

.form-label {
  float: left;
  min-width: 28%;
  margin-top: 6px;
  padding-right: 2%;
}

.form-control {
  float: right;
  width: 67%;
  margin: 6px 0;
  padding-left: 3%;
}

.form-input {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
  font-size: medium;
}

label {
  padding: 12px 0;
  display: inline-block;
}

input[type="submit"] {
  font-size: medium;
  background-color: #4caf50;
  color: white;
  /*padding: 20px;*/
  border: none;
  border-radius: 5px;
  margin-left: 33%;
  cursor: pointer;
  float: left;
}

input[type="submit"]:hover {
  background-color: #45a049;
}

.text-danger {
  float: left;
  color: #ff3333;
  padding: 12px 0;
}

.form-control.error {
  border-color: #ff3333;
  box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.075),
    0 0 8px rgba(255, 71, 71, 0.6);
}
</style>
