import { createRouter, createWebHistory } from 'vue-router'
import LoginViewVue from '../views/LoginView.vue'
import { useAuthAdminStore } from '@/stores/auth/authAdminStore'
import ProductsViewVue from '@/views/ProductsView.vue'
import LayoutView from '@/views/LayoutView.vue'
import AnalyticsView from '../views/AnalyticsView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'layout',
      meta: {
        title: 'Admin | Cyberteza'
      },
      component: LayoutView,
      beforeEnter: () => {
        const store = useAuthAdminStore()
        if (!store.authenticated) {
          return { name: 'login' }
        }
      },
      children: [
        {
          path: '',
          name: 'analytics',
          component: AnalyticsView
        },
        {
          path: 'produtos',
          name: 'products',
          component: ProductsViewVue
        }
      ]
    },
    {
      path: '/login',
      name: 'login',
      component: LoginViewVue,
      meta: {
        title: 'login'
      },
      beforeEnter: () => {
        const store = useAuthAdminStore()
        if (store.authenticated) {
          return { name: 'layout' }
        }
      }
    }
  ]
})

export default router
