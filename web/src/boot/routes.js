
import Chat from '../pages/Chat.vue';
import Vins from '../pages/Vins.vue';
import About from '../pages/About.vue';


export default [
  { name: 'home', path: '/', redirect: '/chat'},
  { name: 'chat', path: '/chat', component: Chat },
  { name: 'vins', path: '/vins',component: Vins },
  { name: 'about', path: '/about',component: About },
  
]