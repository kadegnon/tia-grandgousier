

// -------------------------------------------------------------------
// Dependencies

// Import

import Vue from 'vue';

// Built-in


// Mine
const list = require('@/mocks/list.json');
const vino = require('@/mocks/vino.json');
const bot = require('@/mocks/bot.json');

// -------------------------------------------------------------------
// Properties

const routes = [...list.routes, ...vino.routes];

// Intercept all Http requests to API
Vue.http.interceptors.unshift((req, next) => {
  let matchingRoute = null;
  if (req.url === 'bot/') {
    const nbBotRoutes = bot.routes.length;
    const randNb = Math.floor((Math.random() * nbBotRoutes));
    matchingRoute = bot.routes[randNb];
  } else {
    matchingRoute = routes.find(rt => {
      return (req.method === rt.method && req.url === rt.url);
    });
  }

  if (!matchingRoute) {
    // we're just going to return a 404 here, since we don't want our test suite making a real HTTP request
    next(req.respondWith({ status: 404, statusText: 'Oh no! Not found!' }));
  } else {
    next(req.respondWith(matchingRoute.response, { status: 200 }));
  }
});



// -------------------------------------------------------------------
// Exports
