import Vue from 'vue'

import boot from './boot'
import App from './App.vue'



// Instanciate the app and mount it to the DOM (#app)
new Vue({ // eslint-disable-line no-new
  el: '#root',
  ...boot,
  render: (h) => h(App)
})
