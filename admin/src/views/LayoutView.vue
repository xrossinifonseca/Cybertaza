<script lang="ts" setup>
import { RouterView } from 'vue-router'
import AsideComponent from '../components/aside/AsideComponent.vue'
import { useUserStore } from '../stores/user/userStore'
import { ref } from 'vue'
import { storeToRefs } from 'pinia'

const { getUserInformations } = useUserStore()
const { user } = storeToRefs(useUserStore())
const loading = ref(true)

const fetchInformations = async () => {
  await getUserInformations()
  loading.value = false
}

fetchInformations()
</script>

<template>
  <div class="bg-black min-h-screen flex">
    <aside class="h-screen w-60 relative hidden lg:block">
      <AsideComponent />
    </aside>
    <main class="w-full">
      <RouterView />
    </main>
  </div>
</template>
