<script setup>
import { useRoute, useRouter } from 'vue-router'
const route = useRoute()
const router = useRouter()

const removeFilter = (filter, value) => {
  let query = {
    colors: route.query.colors,
    price_order: route.query.price_order
  }

  if (filter === 'price_order') {
    query.price_order = ''
  }

  if (filter === 'colors') {
    const filteredColors = route.query.colors.filter((color) => color !== value)
    query.colors = filteredColors
  }

  if (!query.price_order) {
    delete query.price_order
  }

  router.push({
    path: '/produtos',
    query: {
      ...query
    }
  })
}

const price_order = ['biggest_price', 'lowest_price']
</script>

<template>
  <div
    v-if="route.query.colors || route.query.price_order"
    class="flex flex-wrap gap-2 items-center"
  >
    <div v-if="Array.isArray(route.query.colors)" class="flex flex-wrap gap-2 items-center">
      <div
        v-for="(color, index) of route.query.colors"
        :key="index"
        class="py-1 border rounded-full px-5 text-sm flex gap-2"
      >
        <span>{{ color }}</span>
        <button @click.capture="removeFilter('colors', color)" class="text-red-500 cursor-pointer">
          X
        </button>
      </div>
    </div>

    <div
      class="py-1 border rounded-full px-5 text-sm flex gap-2"
      v-if="price_order.includes(route.query?.price_order)"
    >
      <span>{{ route.query.price_order }}</span>
      <button
        button
        @click.capture="removeFilter('price_order')"
        class="text-red-500 cursor-pointer"
      >
        X
      </button>
    </div>
  </div>
</template>
