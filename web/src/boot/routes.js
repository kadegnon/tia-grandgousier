
import Chat from '../pages/Chat.vue';
import Vins from '../pages/Vins.vue';
import About from '../pages/About.vue';
import HelloWord from '../pages/HelloWord.vue';


export default [
  { name: 'home', path: '/', component: HelloWord},
  { name: 'chat', path: '/chat', component: Chat },
  { name: 'vins', path: '/vins',component: Vins },
  { name: 'about', path: '/about',component: About },

]
