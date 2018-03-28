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

if(process.env.NODE_ENV !== 'production'){
  const routes = [...list.routes, ...vino.routes];

  // Intercept all Http request to API
  Vue.http.interceptors.unshift((req, next) => {
    let matchingRoute = null;
    if(req.url === 'bot/'){
      const nbBotRoutes = bot.routes.length;
      const randNb = Math.floor((Math.random() * nbBotRoutes));
      matchingRoute = bot.routes[randNb];
    }else{
      matchingRoute = routes.find(rt => {
        return (req.method === rt.method && req.url === rt.url);
      });
    }

    if (!matchingRoute) {
      // we're just going to return a 404 here, since we don't want our test suite making a real HTTP request
      next(req.respondWith({status: 404, statusText: 'Oh no! Not found!'}));
    } else {
      next(req.respondWith(matchingRoute.response,{status: 200}));
    }
  });
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





export default {
  router,
  // store,
};
