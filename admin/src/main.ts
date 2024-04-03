import './assets/main.css'

import { createApp } from 'vue'
import { createPinia } from 'pinia'
import ToastPlugin from 'vue-toast-notification'
import 'vue-toast-notification/dist/theme-bootstrap.css'

import App from './App.vue'
import router from './router'

router.beforeEach((to, from, next) => {
  document.title = (to.meta.title as string) || 'Cybertaza | Loja'
  next()
})

const app = createApp(App)

app.use(createPinia())
app.use(router)
app.use(ToastPlugin)

app.mount('#app')
