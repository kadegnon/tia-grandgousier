/* eslint-disable*/
import Vue from 'vue';

import boot from './boot';
import App from './App';



Vue.config.productionTip = (process.env.NODE_ENV !== 'production');

new Vue({
  el: '#app',
  ...boot,
  render: h => h(App),
});
