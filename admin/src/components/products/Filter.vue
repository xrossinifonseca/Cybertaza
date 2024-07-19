<script setup>
import { reactive, ref, watch } from 'vue'
import Colors from '../Colors.vue'
import FilterIcon from '../icons/FilterIcon.vue'
import { useRouter } from 'vue-router'

const router = useRouter()
const openFilter = ref(false)
const query = reactive({
  colors: [],
  price_order: ''
})

const selectQueryByColor = (colors) => {
  query.colors = colors
}

const filter = () => {
  if (!query.price_order) {
    delete query.price_order
  }

  router.push({
    path: '/produtos',
    query: {
      ...query
    }
  })

  openFilter.value = false
}
watch(openFilter, () => {
  query.colors = []
  query.price_order = ''
})
</script>

<template>
  <div class="relative">
    <div class="flex flex-wrap-reverse max-md:gap-4 justify-between items-center">
      <button class="px-5 btn btn-outline rounded-full" @click="openFilter = !openFilter">
        <span>Filtrar</span>
        <FilterIcon :size="20" />
      </button>
      <label class="input input-bordered flex items-center gap-2">
        <input type="text" class="w-full" placeholder="Pesquisar" />
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 16 16"
          fill="currentColor"
          class="w-4 h-4 opacity-70"
        >
          <path
            fill-rule="evenodd"
            d="M9.965 11.026a5 5 0 1 1 1.06-1.06l2.755 2.754a.75.75 0 1 1-1.06 1.06l-2.755-2.754ZM10.5 7a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0Z"
            clip-rule="evenodd"
          />
        </svg>
      </label>
    </div>
    <div
      :data-open-filter="openFilter"
      class="w-full absolute h-0 overflow-y-hidden z-40 bg-black mt-4 data-[open-filter=true]:h-auto"
    >
      <div class="flex flex-wrap">
        <div class="md:w-1/2 flex items-center gap-2">
          <button
            type="button"
            @click="query.price_order = 'biggest_price'"
            :data-btn="query?.price_order === 'biggest_price'"
            class="text-sm flex items-center data-[btn=true]:bg-slate-950 gap-2 rounded-full p-2 border text-white hover:bg-slate-950 cursor-pointer"
          >
            Maior preço
          </button>
          <button
            type="button"
            @click="query.price_order = 'lowest_price'"
            :data-btn="query?.price_order === 'lowest_price'"
            class="text-sm flex data-[btn=true]:bg-slate-950 items-center gap-2 rounded-full p-2 border text-white hover:bg-slate-950 cursor-pointer"
          >
            Menor preço
          </button>
        </div>

        <div class="md:w-1/2">
          <h2>Cores</h2>
          <Colors @get-values="selectQueryByColor" />
        </div>
      </div>

      <div class="flex justify-end py-4">
        <button @click="filter" class="btn btn-success text-white rounded-full">Filtrar</button>
      </div>
    </div>
  </div>
</template>
