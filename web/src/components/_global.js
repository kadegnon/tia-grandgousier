/**
 * These components are registered globally, and can be read
 * anywhere within our app without importing them.
 *
 */
const chatMsg = require('./ChatMsg.vue');
const userChoice = require('./UserChoice.vue');
const autoComplete = require('./AutoComplete.vue');
const NavLinks = require('./NavLinks.vue');

const VinList = require('./VinList.vue');
const VinDetails = require('./VinDetails.vue');

export default {
  chatMsg,
  userChoice,
  autoComplete,
  NavLinks,
  VinList,
  VinDetails
};
