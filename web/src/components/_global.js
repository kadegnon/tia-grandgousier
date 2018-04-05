/**
 * These components are registered globally, and can be read
 * anywhere within our app without importing them.
 *
 */
// -------------------------------------------------------------------
// NPM
import vSelect from 'vue-select';


// Mine
const ChatMsg = require('./ChatMsg.vue');
const UserChoice = require('./UserChoice.vue');
const SwitchButton = require('./SwitchButton.vue');
const Speech2Text = require('./Speech2Text.vue');
const Text2Speech = require('./Text2Speech.vue');

const NavLinks = require('./NavLinks.vue');
const ToastMsg = require('./ToastMsg.vue');

const VinList = require('./VinList.vue');
const VinDetails = require('./VinDetails.vue');


// -------------------------------------------------------------------
// Exports

export default {
  ChatMsg,
  UserChoice,
  SwitchButton,
  NavLinks,
  VinList,
  VinDetails,
  Speech2Text,
  Text2Speech,

  'v-select' : vSelect
};
