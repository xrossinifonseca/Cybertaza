<script setup lang="ts">
defineProps<{
  modelValue: string
  name: string
  placeholder: string
  type: string
  error?: string
  borderError?: string
}>()

defineEmits(['update:modelValue'])
</script>

<template>
  <div class="w-full">
    <input
      :type="type"
      :value="modelValue"
      :name="name"
      @input="$emit('update:modelValue', ($event.target as HTMLInputElement).value)"
      :placeholder="placeholder"
      :class="{
        'border-red-500': borderError,
        'border-transparent': !borderError,
        'focus:border-red-500': error || borderError
      }"
      class="p-2 w-full outline-none rounded border-2 ease-in-out duration-500 focus:border-blue"
    />
    <span v-if="error" class="text-medium text-red-500 text-lg">{{ error }}</span>
  </div>
</template>
