<script lang="ts" setup>
defineProps<{
  index: number
}>()
</script>

<template>
  <div
    :class="{ 'bg-yellow': index === 0, 'bg-black-secondary': index !== 0 }"
    class="w-full sm:w-[250px] h-32 rounded-md p-2 flex gap-2"
  >
    <div
      :class="{ 'bg-yellow': index !== 0, 'bg-white': index === 0 }"
      class="w-2 h-full rounded-full"
    ></div>

    <div class="flex flex-col gap-4">
      <h1 class="text-white font-medium text-xl">Customers</h1>
      <h2 class="text-3xl text-white font-medium">10.000</h2>
    </div>
  </div>
</template>
