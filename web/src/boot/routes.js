
import BotChat from '@/pages/BotChat.vue';
import Vins from '@/pages/Vins.vue';
import VinList from '@/components/VinList';
import VinDetails from '@/components/VinDetails';

import About from '@/pages/About.vue';


export default [
  { name: 'home', path: '/',  redirect : '/bot'},
  { name: 'about', path: '/about', component: About },
  { name: 'bot', path: '/bot',component: BotChat },
  // { name: 'chat', path: '/chat', component: Chat },
  {
    path: '/vins', component: Vins,
    children: [
      {
        path: 'new',          //  /vins/new
        name: 'vinNew',
        components: {
          details: VinDetails
        }
      },
      {
        path: ':id',          //  /vins/mocky123
        name: 'vinDetails',
        components: {
          details: VinDetails
        }
      }


    ]
  },
  // { name: 'vinDetails', path: '/vins/:id', component: Vins },

]
