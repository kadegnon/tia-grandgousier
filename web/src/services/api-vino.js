

// -------------------------------------------------------------------
// Dependencies

import Vue from 'vue';


// -------------------------------------------------------------------
// Properties
const Api = Vue.http;

// -------------------------------------------------------------------
// Exports

export const APIVino = {

  getListAppellations : _ => Api.get("appellations/").then(res => res.data),

  getListCouleurs : _ => Api.get("couleurs/").then(res => res.data),

  getListPlats : _ => Api.get("plats/").then(res => res.data),

  getListServices : _ => Api.get("services/").then(res => res.data),

  getListVins : _ => Api.get("vino/").then(res => res.data),

};
