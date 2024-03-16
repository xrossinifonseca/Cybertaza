<script setup lang="ts">
import { RouterLink } from 'vue-router'
</script>

<template>
  <div class="h-full bg-yellow py-5 p-2 space-y-10">
    <div class="grid place-items-center gap-2 w-full justify-center">
      <img src="@/assets/svg/disco.svg" class="max-w-[120px]" />
      <h1 class="text-xl font-bold text-black">CyberTaza</h1>
    </div>

    <div class="w-full flex justify-center">
      <ul class="space-y-5 text-lg font-medium p-2">
        <RouterLink to="/admin">
          <li class="btn btn-ghost text-black w-full">Analitícos</li>
        </RouterLink>
        <RouterLink to="/admin/produtos">
          <li class="btn btn-ghost text-black w-full">Produtos</li>
        </RouterLink>
        <RouterLink to="/">
          <li class="btn btn-ghost text-black w-full">Pedidos</li>
        </RouterLink>
        <RouterLink to="/">
          <li class="btn btn-ghost text-black w-full">Clientes</li>
        </RouterLink>
      </ul>
    </div>
  </div>
</template>
