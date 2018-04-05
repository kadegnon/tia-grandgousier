import Vue from 'vue';
// import VueResource from "vue-resource";
import VeeValidate from 'vee-validate';


import components from '@/components/_global';

// import * as filters from './filters'
import router from './router';
// import store from './store/'

const list = require('@/mocks/list.json');
const vino = require('@/mocks/vino.json');
const bot = require('@/mocks/bot.json');


/**************************************
 * VeeValidate for the form validation.
 */
Vue.use(VeeValidate);


/**************************************
 * Vue Resource to handle HTTP Request.
 */
// Vue.use(VueResource);
// Vue.url.options.root = process.env.API_URL;

if(process.env.NODE_ENV == 'testing'){
  require('@/boot/dev');
}


/**************************************
 * Plugins : All externed plugins.
 */
// require('./plugins')



/**************************************
 * Global Event Bus
 */
require('./event-bus');


/**************************************
 * Register Global Components
 */
Object.keys(components)
.forEach(tag => Vue.component(tag, components[tag]));



/**************************************
 * Register Global Filters
 */
// Object.keys(filters)
//   .forEach(name => Vue.filter(name, filters[name]));




// -------------------------------------------------------------------
// Exports

export default {
  router,
  // store,
};
