<template>
  <article class="vino-details">
    <h2>{{$route.params.id ? 'Mise à jour ' : 'Ajout'}} de vin</h2>
    <form :method="id ? 'PUT' : 'POST'" @submit.prevent="saveVin">
      <div class="form-group">
        <div class="col-25">
          <label for="vnom">Nom</label>
        </div>
        <div class="col-65">
          <span class="text-danger" v-show="errors.has('vnom')">Le nom est requis.</span>
          <input type="text" id="vnom" name="vnom" placeholder="Nom de vin"
                v-model="vin.nom" v-validate="'required'"
                :class="{'form-control': true, 'error': errors.has('vname') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="col-25">
          <label for="vorigine">Origine</label>
        </div>
        <div class="col-65">
          <input type="text" id="vorigine" name="vorigine" placeholder="Origine de vin"
                v-model="vin.origine" :class="{'form-control': true, 'error': errors.has('vorigine') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="col-25">
          <label for="vannee">Année</label>
        </div>
        <div class="col-65">
          <span class="text-danger" v-show="errors.has('vnom')">L'année est requis</span>
          <input type="number" id="vannee" name="vannee" placeholder="Année d'embouteillage du vin"
                v-model="vin.annee" v-validate="'required'"
                :class="{'form-control': true, 'error': errors.has('vannee') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="col-25">
          <label for="vhtva">H.T.V.A</label>
        </div>
        <div class="col-65">
          <span class="text-danger" v-show="errors.has('vnom')">Le prix HTVA est requis</span>
          <input type="number" id="vhtva" name="vhtva"  step="0.1" placeholder="Prix H.T.V.A"
                v-model="vin.htva" v-validate="'required'"
                :class="{'form-control': true, 'error': errors.has('vhtva') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="col-25">
          <label for="vtvac">T.V.A.C</label>
        </div>
        <div class="col-65">
          <span class="text-danger" v-show="errors.has('vnom')">Le prix TVAC est requis</span>
          <input type="number" id="vtvac" name="vtvac"  step="0.1" placeholder="Prix H.T.V.A"
                v-model="vin.tvac" v-validate="'required'"
                :class="{'form-control': true, 'error': errors.has('vtvac') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="col-25">
          <label for="appels">Appellation</label>
        </div>
        <div class="col-65">
          <span class="text-danger" v-show="errors.has('vappel')">L'appellation est requis</span>
          <select  :class="{'form-control': true, 'error': errors.has('vappel') }" id="vappel" name="vappel">
            <template v-for="(appel,index) in appellations" >
              <option :key="index" :value="appel" :selected="appel == vin.appellation">{{appel}}</option>
            </template>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="col-25">
          <label for="vdescrip">Description</label>
        </div>
        <div class="col-65">
          <span class="text-danger" v-show="errors.has('vdescrip')">L'appellation est requis</span>
          <textarea id="vdescrip" name="vdescrip" placeholder="Description du vin" style="height:200px"
              v-model="vin.description"   v-validate="'required'"
              :class="{'form-control': true, 'error': errors.has('vdescrip') }" ></textarea>
        </div>
      </div>
      <div class="form-group">
        <input type="submit" :value="id ? 'Modifier' :'Sauvegarder'">
      </div>
    </form>
  </article>
</template>

<script>
export default {
  name: "vinDetails",
  data() {
    return {
      id: this.$route.params.id,
      appellations : [],
      vin: {
        nom: "",
        annee: 2017,
        origine: "",
        description: '',
        appellation : '',
        htva: 0.1,
        tvac: 0.1
      }
    };
    },
    beforeUpdate()  {
      this.id = this.$route.params.id;
    },
    methods : {
      saveVin () {
        console.log(this.errors);
        this.$emit('save-vin', this.id, this.vin)
      }
    }

};
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.vino-details {
  width: 65%;
  border-radius: 5px;
  /* background-color: #f2f2f2; */
  padding: 20px;
}

/* Clear floats after the columns */
.form-group:after {
  content: "";
  display: table;
  clear: both;
}

.col-15 {
  float: left;
  width: 15%;
  margin-top: 6px;
}

.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-65 {
  float: left;
  width: 65%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

.col-85 {
  float: left;
  width: 85%;
  margin-top: 6px;
}

.form-control {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
  font-size: medium;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type="submit"] {
  font-size: medium;
  background-color: #4caf50;
  color: white;
  padding: 20px;
  border: none;
  border-radius: 5px;
  margin-left: 25%;
  margin-top : 10px;
  cursor: pointer;
  float: left;
}

input[type="submit"]:hover {
  background-color: #45a049;
}

.text-danger {
  float: left;
  color: #FF3333;
  padding: 12px 0
}

.form-control.error {
  border-color: #FF3333;
  box-shadow: inset 0 1px 1px rgba(0,0,0,.075), 0 0 8px rgba(255, 71, 71, 0.6);
}
</style>
