/**
 * These components are registered globally, and can be read
 * anywhere within our app without importing them.
 *
 */
const ChatMsg = require('./ChatMsg.vue');
const UserChoice = require('./UserChoice.vue');
const AutoComplete = require('./AutoComplete.vue');
const Speech2Text = require('./Speech2Text.vue');

const NavLinks = require('./NavLinks.vue');
const ToastMsg = require('./ToastMsg.vue');

const VinList = require('./VinList.vue');
const VinDetails = require('./VinDetails.vue');


export default {
  ChatMsg,
  UserChoice,
  AutoComplete,
  NavLinks,
  VinList,
  VinDetails,
  Speech2Text
};
