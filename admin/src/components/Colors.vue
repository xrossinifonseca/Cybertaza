<script setup lang="ts">
import { ref } from 'vue'
import { api } from '../service/axios'

defineProps<{
  selectedId: number
}>()

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

fetchColors()
</script>

<template>
  <div class="flex flex-wrap gap-4 mt-2">
    <button
      type="button"
      v-for="color in colors"
      :key="color.id"
      @click.capture="$emit('get-color', color.id)"
      :class="{ 'bg-slate-950': selectedId === color.id }"
      class="text-sm flex items-center gap-2 rounded-full p-2 border text-white hover:bg-slate-950 cursor-pointer"
    >
      <div class="w-4 h-4 rounded-full" :style="{ backgroundColor: color.hex_code }"></div>
      {{ color.name }}
    </button>
  </div>
</template>
