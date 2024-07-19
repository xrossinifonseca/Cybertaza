<script lang="ts" setup>
defineProps<{
  size?: number
  color?: string
}>()
</script>

<template>
  <svg
    viewBox="0 0 19 14"
    fill="none"
    xmlns="http://www.w3.org/2000/svg"
    v-bind="$attrs"
    :width="size"
  >
    <rect y="1.46155" width="19" height="1.46154" rx="0.730769" fill="currentColor"></rect>
    <rect y="5.84619" width="19" height="1.46154" rx="0.730769" fill="currentColor"></rect>
    <rect y="10.2307" width="19" height="1.46154" rx="0.730769" fill="currentColor"></rect>
    <circle cx="5.1154" cy="2.19231" r="1.69231" fill="#F5F5F5" stroke="currentColor"></circle>
    <circle cx="13.8847" cy="6.57695" r="1.69231" fill="#F5F5F5" stroke="currentColor"></circle>
    <circle cx="5.1154" cy="10.9616" r="1.69231" fill="#F5F5F5" stroke="currentColor"></circle>
  </svg>
</template>
