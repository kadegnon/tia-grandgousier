<template>
  <article class="vino-details">
      <form action="#" :method="id ? 'PUT' : 'POST'">
    <div class="row">
      <div class="col-25">
        <label for="vnom">Nom</label>
      </div>
      <div class="col-65">
        <input v-model="vin.nom" type="text" name="vnom" placeholder="Nom de vin">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="vorigine">Origine</label>
      </div>
      <div class="col-65">
        <input v-model="vin.origine" type="text" name="vorigine" placeholder="Origine de vin">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="vannee">Année d'embouteillage</label>
      </div>
      <div class="col-65">
        <input v-model="vin.annee" type="number" name="vannee" placeholder="Annee d'embouteillage du vin">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="vhtva">H.T.V.A</label>
      </div>
      <div class="col-65">
        <input v-model="vin.htva" type="number" step="0.1" name="vhtva" placeholder="Prix H.T.V.A">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="vtvac">T.V.A.C</label>
      </div>
      <div class="col-65">
        <input v-model="vin.tvac" type="number" step="0.1" name="vtvac" placeholder="Prix T.V.A.C">
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="appels">Appellation</label>
      </div>
      <div class="col-65">
        <select name="appels">
          <option value="australia" selected>Champagnes</option>
          <option value="canada">Cognac</option>
          <option value="usa">Bordeaux</option>
        </select>
      </div>
    </div>
    <div class="row">
      <div class="col-25">
        <label for="vdescription">Description</label>
      </div>
      <div class="col-65">
        <textarea v-model="vin.description" name="vdescription" placeholder="Description du vin" style="height:200px"></textarea>
      </div>
    </div>
    <div class="row">
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
      id: "",
      vin: {
        nom: "",
        annee: 2017,
        origine: "",
        description: "",
        htva: 0.01,
        tvac: 0.01
      }
    };
  },
  computed: {
    filteredList() {}
  }
};
</script>



<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.vino-details {
  width: 65%;
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

/* Clear floats after the columns */
.row:after {
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

input[type="text"],
input[type="number"],
select,
textarea {
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
  background-color: #4caf50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  margin-left: 15%;
  cursor: pointer;
  float: left;
}

input[type="submit"]:hover {
  background-color: #45a049;
}
</style>
