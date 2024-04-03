<script lang="ts" setup>
import { RouterView } from 'vue-router'
import AsideComponent from '../components/aside/AsideComponent.vue'
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
