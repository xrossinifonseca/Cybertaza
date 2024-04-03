<script lang="ts" setup>
defineProps<{
  size: number
  color: string
}>()
</script>

<template>
  <svg
    viewBox="0 0 24 24"
    id="Layer_1"
    data-name="Layer 1"
    xmlns="http://www.w3.org/2000/svg"
    :fill="color"
    v-bind="$attrs"
    :width="size"
  >
    <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
    <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
    <g id="SVGRepo_iconCarrier">
      <circle class="cls-1" cx="6.27" cy="17.73" r="1.91"></circle>
      <circle class="cls-1" cx="17.73" cy="17.73" r="1.91"></circle>
      <polyline
        class="cls-1"
        points="4.36 17.73 1.5 17.73 1.5 4.36 18.68 4.36 18.68 8.18 20.59 12 22.5 13.07 22.5 17.73 19.64 17.73"
      ></polyline>
      <line class="cls-1" x1="15.82" y1="17.73" x2="8.18" y2="17.73"></line>
      <polyline class="cls-1" points="20.59 12 14.86 12 14.86 8.18 18.68 8.18"></polyline>
    </g>
  </svg>
</template>
