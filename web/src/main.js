/* eslint-disable*/
import Vue from 'vue';
import VueResource from 'vue-resource';

import App from './App';


Vue.config.productionTip = (process.env.NODE_ENV !== 'production');


Vue.use(VueResource);
Vue.url.options.root = process.env.API_URL.replace(/\/$/g, '') + '/api/';

const { default:Boot} = require('./boot/index');

new Vue({
  el: '#app',
  ...Boot,
  render: h => h(App),
});
