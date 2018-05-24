<template>
  <article class="vino-details">
    <h2>{{$route.params.id ? 'Mise à jour du' : 'Ajout de'}} vin</h2>
    <form :method="id ? 'PUT' : 'POST'" @submit.prevent="saveVin">
      <div class="form-group">
        <div class="form-label">
          <label for="vnom">Nom</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vnom')">Le nom est requis.</span>
          <input type="text" id="vnom" name="vnom" placeholder="Nom de vin"
                v-model.lazy.trim="vin.nom" v-validate="'required'"
                :class="{'form-input': true, 'error': errors.has('vnom') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vappel">Appellation</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vappel')">L'appellation est requis</span>
          <select id="vappel" name="vappel"
                :class="{'form-input select': true, 'error': errors.has('vappel') }"
                v-model.lazy="vin.appellation" v-validate="'required'"
          >
            <template v-for="(appel,index) in getListSelect('appellations')" >
              <option :key="index" :value="appel.value" :selected="id && appel.value == vin.appellation">{{appel.name}}</option>
            </template>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vorigine">Origine</label>
        </div>
        <div class="form-control">
          <input type="text" id="vorigine" name="vorigine" placeholder="Origine de vin"
                v-model.lazy.trim="vin.origine" :class="{'form-input': true, 'error': errors.has('vorigine') }"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vannee">Année</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vannee')">L'année est requis</span>
          <input type="number" id="vannee" name="vannee" step="1" placeholder="Année d'embouteillage du vin"
                :class="{'form-input': true, 'error': errors.has('vannee') }"
                v-model.lazy.number="vin.annee"  v-validate="'required|numeric|min:4|max:4'"
                v-bind:max="new Date().getFullYear()+1"
          >
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vhtva">H.T.V.A.</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vhtva')">Le prix HTVA est requis</span>
          <input type="number" id="vhtva" name="vhtva" step="0.01" min="0" placeholder="Prix H.T.V.A."
                :class="{'form-input': true, 'error': errors.has('vhtva') }"
                v-model.lazy.number="vin.htva" v-validate="'required|decimal'"
          >
        </div>
      </div>

      <hr style="width:110%;margin:15px 0;">
      <div class="form-group">
        <div class="form-label">
          <label for="vservices">Service</label>
        </div>
        <div class="form-control">
          <v-select multiple taggable id="vservices" name="vservices"  placeholder="Pour quelle service"
                v-model="vin.services" label="name" :options="getListSelect('services')"
          >
          <span slot="no-options">Ooups ! Service inconnu.</span>
          </v-select>
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vplats">Plats</label>
        </div>
        <div class="form-control">
          <v-select id="vplats" name="vplats" placeholder="Avec quelle plat"
                multiple taggable
                v-model="vin.plats" label="name" :options="getListSelect('plats')"
          >
          <span slot="no-options">Ooups ! Plat inconnu.</span>
          </v-select>
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vnez">Nez</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vnez')">Un nez pour ce vin</span>
          <v-select multiple push-tags taggable id="vnez" name="vnez"  v-model.lazy="vin.nez" >
            <span slot="no-options">Aucun nez pour ce vin.</span>
          </v-select>
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vbouche">Bouche</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vbouche')">La bouche pour ce vin</span>
          <textarea id="vbouche" name="vbouche" placeholder="La bouche du vin." style="height:125px"
              v-model.lazy.trim="vin.bouche"   v-validate="'required'"
              :class="{'form-input': true, error: errors.has('vbouche')}" ></textarea>
        </div>
      </div>
      <div class="form-group">
        <div class="form-label">
          <label for="vdescrip">Description</label>
        </div>
        <div class="form-control">
          <span class="text-danger" v-show="errors.has('vdescrip')">La description est requis</span>
          <textarea id="vdescrip" name="vdescrip" placeholder="Description du vin" style="height:150px"
              v-model.lazy.trim="vin.description"   v-validate="'required'"
              :class="{'form-input': true, /*'error': errors.has('vdescrip') */}" ></textarea>
        </div>
      </div>
      <div class="form-group">
        <input class="btn" type="submit"
              :value="$route.params.id ? 'Modifier' :'Sauvegarder'" :disabled="errors.any()">
      </div>
    </form>
  </article>
</template>

<script>

const _list = {
  appellations: [],
  services: [],
  plats: []
};

const _defaultVin = ({
  nom: '', annee: 2017, origine: '',
  description: '', appellation: undefined,
  nez : [], bouche : '',  htva: 0.1,
  services : [], plats : [],
});
export default {
  name: "vinDetails",
  data() {
    return {
      id: undefined,
      vin: _defaultVin
    };
  },
  created() {
    this.$bus.$emit("list-of-caracteristic");
    this.$bus.$on("list-select", this.prepareListSelect);
    if (this.$route.path === "/vins/new" && this.$route.query) {
      Object.assign(this.vin, _defaultVin, this.$route.query);
    } else {
      this.getVin(this.$route.params.id);
    }
  },

  beforeRouteUpdate(to, from, next) {
    if (to.path === "/vins/new") {
      Object.assign(this.vin, _defaultVin, to.query);
      this.$el.querySelector("#vnom").focus();
      next();
    } else {
      next(this.getVin(to.params.id));
    }
  },
  beforeDestroy() {
    this.$bus.$off("list-select");
    this.$bus.$off("vin-details#" + this.id);
    this.vin = null;
    this.id = null;
  },
  computed: {
    getListSelect() {
      return type => (_list.hasOwnProperty(type) ? _list[type] : []);
    }
  },
  methods: {
    prepareListSelect([type, list]) {
      _list[type] = list;
    },
    prepareVin(details) {
      Object.assign(this.vin, details, {
        bouche: details.bouche.join("\n"),
        description: details.description.join("\n")
      });
    },
    getVin(vinId) {
      if (vinId) {
        this.id = vinId;
        this.$bus.$emit("vin-details", this.id);
        this.$bus.$on("vin-details#" + this.id, this.prepareVin);
      }
    },
    saveVin() {
      const warnMsg = e => {
        this.$bus.$emit(
          "msg-warning",
          "Certains informations sont manquantes !"
        );
      };

      this.$validator
        .validateAll()
        .then(isValid => {
          if (!isValid) return warnMsg();
          this.id = this.$route.params.id;
          const vinInput = this.prepareInput();
          if (this.id) {
            return this.$bus.$emit("vin-modif", this.id, vinInput);
          } else {
            return this.$bus.$emit("vin-add", vinInput);
          }
        })
    },

    prepareInput() {
      const textToPhrase = txt => txt.split(/[\n\r.]/)
                                      .filter(s => (s.trim() !== ''));

      return Object.assign({}, this.vin, {
        // tvac : Number.parseFloat(this.vin.htva * 1.21),
        plats : this.vin.plats.map(p => p.value),
        services : this.vin.services.map(s => s.value),
        bouche: textToPhrase(this.vin.bouche),
        description: textToPhrase(this.vin.description)
      });
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
  /* padding-right: 2%; */
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

.form-group select {
  width: 115%;
}

.form-group input[type="submit"] {
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

.form-group input:disabled {
  cursor: not-allowed;
  background-color: buttonface;
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
