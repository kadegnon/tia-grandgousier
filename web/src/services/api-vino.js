

// -------------------------------------------------------------------
// Dependencies

import Vue from 'vue';


// -------------------------------------------------------------------
// Properties
const API_URL_TO_VINO = 'vino/';
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


export const APIVino = {

  getListAppellations : _ =>  getList("appellations/"),

  getListCouleurs : _ => getList("couleurs/") ,

  getListPlats : _ => getList("plats/") ,

  getListServices : _ => getList("services/") ,

  getListVins : _ => Api.get("vino/").then(res => res.data),

  getDetailsVin : id => ApiResoucreToVino.get({id}).then(res => res.body),

  addVin : data => Api.post('vino/',data).then(res => res.data),

  updateVin : data => Api.put('vino/',data).then(res => res.data),

  deleteVin : id => ApiResoucreToVino.delete({id}),

};
