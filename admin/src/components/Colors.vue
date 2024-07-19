<script setup lang="ts">
import { ref, onBeforeMount } from 'vue'
import { api } from '../service/axios'

type Color = {
  id: number
  name: string
  hex_code: string
}

const colors = ref<Color[]>([])

const fetchColors = async (): Promise<void> => {
  const { data } = await api.get('colors')
  colors.value = data.colors
}

onBeforeMount(() => {
  fetchColors()
})
</script>

<template>
  <div class="flex flex-wrap gap-4 mt-2">
    <button
      type="button"
      v-for="color in colors"
      :key="color.id"
      @click.capture="$emit('get-values', color)"
      class="text-sm flex items-center gap-2 rounded-full p-2 border text-white hover:bg-slate-500 cursor-pointer"
    >
      <div class="w-4 h-4 rounded-full" :style="{ backgroundColor: color.hex_code }"></div>
      {{ color.name }}
    </button>
  </div>
</template>
