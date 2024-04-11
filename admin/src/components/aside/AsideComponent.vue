<script setup lang="ts">
import { RouterLink } from 'vue-router'
// import AnalyticsIcon from '../icons/AnalyticsIcon.vue'
// import MugIcon from '../icons/MugIcon.vue'
// import CustomersIcon from '../icons/CustomersIcon.vue'
// import OrdersIcon from '../icons/OrdersIcon.vue'
import { storeToRefs } from 'pinia'
import { useUserStore } from '../../stores/user/userStore'

const userStore = useUserStore()
const { user } = storeToRefs(userStore)

const list = [
  {
    name: 'Analítico',
    href: '/'
  },
  {
    name: 'produtos',
    href: 'produtos'
  },

  {
    name: 'Pedidos',
    href: '/'
  },
  {
    name: 'Clientes',
    href: '/'
  }
]
</script>

<template>
  <div class="h-full bg-yellow py-5 p-2 space-y-10">
    <div class="grid place-items-center gap-2 w-full justify-center">
      <img src="@/assets/svg/disco.svg" class="max-w-[120px]" />
      <h1 class="text-xl font-bold text-white">CyberTaza</h1>
    </div>

    <div class="w-full">
      <ul class="space-y-5 text-4xl font-medium w-full p-2">
        <RouterLink v-for="(item, index) in list" :to="item.href" :key="index">
          <li class="btn btn-ghost text-white text-lg" v-if="user?.permissions.includes('view')">
            <!-- <i> <AnalyticsIcon color="white" :size="25" /></i> -->
            <span>{{ item.name }}</span>
          </li>
        </RouterLink>
      </ul>
    </div>
  </div>
</template>
