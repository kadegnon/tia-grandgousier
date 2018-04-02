

// -------------------------------------------------------------------
// Dependencies

import Vue from 'vue';


// -------------------------------------------------------------------
// Properties
const Api = Vue.http;
const ApiResoucreToVino = Vue.resource('vino{/id}');

// -------------------------------------------------------------------
// Exports

export const APIVino = {

  getListAppellations : _ => Api.get("appellations/").then(res => res.data),

  getListCouleurs : _ => Api.get("couleurs/").then(res => res.data),

  getListPlats : _ => Api.get("plats/").then(res => res.data),

  getListServices : _ => Api.get("services/").then(res => res.data),

  getListVins : _ => Api.get("vino/").then(res => res.data),

  getDetailsVin : id => ApiResoucreToVino.get({id}).then(res => res.body),

};
