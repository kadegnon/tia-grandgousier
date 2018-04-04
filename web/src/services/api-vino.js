

// -------------------------------------------------------------------
// Dependencies

import Vue from 'vue';


// -------------------------------------------------------------------
// Properties
const API_URL_TO_VINO = 'vino/';
const API_URL_TO_GGS = 'ggs/';
const Api = Vue.http;
const ApiResoucreToVino = Vue.resource('vino{/id}');
const Storage = localStorage;

const isInStorage = key => Storage.hasOwnProperty(key);

const getFromStorage = key => JSON.parse(Storage.getItem(key));

const addToStorage = (key, item) => Storage.setItem(key, JSON.stringify(item));

/**
 * Retrieve the list either from the CacheStorage or directly through the API.
 * @param {String} url API url where to get the list.
 * @returns {Promise} containing the resolved list.
 */
const getList = url => {
  const key = 'API_LIST_FOR_'+url.replace(/\//g, '').toUpperCase();
  if(isInStorage(key)){
    return Promise.resolve(getFromStorage(key));
  }else{
    return Api.get(url)
        .then(({data}) => {
          addToStorage(key, data);
          return data;
        })
  }
};

// -------------------------------------------------------------------
// Exports

  export function getListAppellations() {
     return getList("appellations/");
  }

  export function getListCouleurs() {
    return getList("couleurs/") ;
  }


  export function getListPlats() {
    return getList("plats/") ;
  }


  export function getListServices() {
    return getList("services/") ;
  }


  export function getListVins() {
    return Api.get("vino/").then(res => res.data);
  }


  export function getDetailsVin(id) {
    return ApiResoucreToVino.get({id}).then(res => res.body);
  }


  export function addVin(data) {
    return Api.post('vino/',data).then(res => res.data);
  }

  export function updateVin(data) {
    return Api.put('vino/',data).then(res => res.data);
  }

  export function deleteVin(id) {
    return ApiResoucreToVino.delete({id});
  }

  export function getGGSIntro() {
    return getList('ggs/intro');
  }


  export function sendGGS (question) {
    return Api.get('ggs/', {
      params : {question}
    }).then(res => res.data)
  }


