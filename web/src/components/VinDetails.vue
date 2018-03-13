<template>
  <article class="vino-details">
    <h2>{{$route.params.id ? 'Mise à jour ' : 'Ajout'}} de vin</h2>
    <form :method="id ? 'PUT' : 'POST'" @submit.prevent="saveVin">
      <div class="form-group">
        <div class="form-label">
          <label for="vappel">Appellation</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vappel')">L'appellation est requis</span>
          <select  :class="{'form-input': true, 'error': errors.has('vappel') }" id="vappel" name="vappel">
            <template v-for="(appel,index) in appellations" >
              <option :key="index" :value="appel" :selected="appel == vin.appellation">{{appel}}</option>
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
          <input type="number" max="2025" id="vannee" name="vannee" placeholder="Année d'embouteillage du vin"
                v-model="vin.annee" v-validate="'required'"
                :class="{'form-input': true, 'error': errors.has('vannee') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vhtva">H.T.V.A</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vhtva')">Le prix HTVA est requis</span>
          <input type="number" id="vhtva" name="vhtva"  step="0.1" placeholder="Prix H.T.V.A"
                v-model="vin.htva" v-validate="'required'"
                :class="{'form-input': true, 'error': errors.has('vhtva') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vtvac">T.V.A.C</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vtvac')">Le prix TVAC est requis</span>
          <input type="number" id="vtvac" name="vtvac"  step="0.1" placeholder="Prix H.T.V.A"
                v-model="vin.tvac" v-validate="'required'"
                :class="{'form-input': true, 'error': errors.has('vtvac') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vdescrip">Description</label>
        </div>
        <div class="form-control">
          <!--<span class="text-danger" v-show="errors.has('vdescrip')">La description est requis</span>-->
          <textarea id="vdescrip" name="vdescrip" placeholder="Description du vin" style="height:200px"
              v-model="vin.description"   v-validate="'required'"
              :class="{'form-input': true, /*'error': errors.has('vdescrip') */}" ></textarea>
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
        tvac: 0.2
      }
    };
    },
    created () {
      this.getListAppellations();

    },
    beforeUpdate()  {
      this.id = this.$route.params.id;
      this.getVin();
    },
    methods : {
      getListAppellations(){
        this.$http.get('appellation')
            .then(res => this.appellations = res.data);
      },
      getVin() {
        if(this.id){
          this.$http.get('vino/'+this.id)
              .then(res => this.vin = res.data);
        }
      },
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


.form-input{
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
