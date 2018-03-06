import Vue from 'vue';

import components from '../components/_global';

// import * as filters from './filters'
import router from './router';
// import store from '../store/'


//
// Plugins : All externed plugins
//
// require('./plugins')


//
// Global Event Bus
//

require('./event-bus');


/**
 * Register Global Components
 *
 */
Object.keys(components)
  .forEach(tag => Vue.component(tag, components[tag]));


/**
 * Register Global Filters
 *
 */
// Object.keys(filters)
//   .forEach(name => Vue.filter(name, filters[name]));





export default {
  router,
  // store,
};
