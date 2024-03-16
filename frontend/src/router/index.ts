import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'
import LoginViewVue from '../views/admin/LoginView.vue'
import AdminViewVue from '@/views/admin/AdminView.vue'
import { useAuthAdminStore } from '@/stores/admin/authAdminStore'
import ProductsViewVue from '@/views/admin/ProductsView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'inicio',
      component: HomeView
    },
    {
      path: '/admin',
      name: 'admin',
      meta: {
        title: 'Admin | Cyberteza'
      },
      component: AdminViewVue,
      beforeEnter: (to) => {
        const store = useAuthAdminStore()
        if (!store.authenticated && to.name === 'private') {
          return { name: 'login' }
        }

        if (store.authenticated && to.path === '/admin/login') {
          return { name: 'private' }
        }
      },
      children: [
        {
          path: '',
          name: 'private',
          component: () => import('@/views/admin/HomeAdmin.vue'),
          children: [
            {
              path: 'produtos',
              name: 'private',
              component: ProductsViewVue
            }
          ]
        },
        {
          path: '/admin/login',
          name: 'login',
          component: LoginViewVue,
          meta: {
            title: 'login'
          }
        }
      ]
    }
  ]
})

export default router
