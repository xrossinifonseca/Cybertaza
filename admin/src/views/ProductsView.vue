<script setup lang="ts">
import ModalCreate from '../components/products/ModalCreate.vue'
import LoadingBalls from '../components/loading/LoadingBalls.vue'
import TableProducts from '../components/products/TableProducts.vue'
import { reactive } from 'vue'
import { useProductsStore } from '../stores/products/productsStore'
import { storeToRefs } from 'pinia'
import { useUserStore } from '../stores/user/userStore'

const modal = reactive({
  create: false
})

const productsStore = useProductsStore()
const { products, total_pages } = storeToRefs(productsStore)

const userStore = useUserStore()
const { user } = storeToRefs(userStore)

const toggleModal = () => {
  modal.create = !modal.create
}
productsStore.getProducts()
</script>

<template>
  <div class="overflow-y-auto h-screen">
    <LoadingBalls v-if="productsStore.loading" />
    <ModalCreate v-if="modal.create" @close-modal="toggleModal" />

    <div class="w-full min-h-screen p-5 space-y-20">
      <div class="mt-10 w-full flex justify-around">
        <h1 class="text-4xl text-white">Produtos</h1>

        <button
          @click="toggleModal"
          class="btn btn-outline btn-success"
          v-if="user?.permissions.includes('create')"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="w-4 fill-white">
            <path
              d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"
            />
          </svg>
        </button>
      </div>
      <TableProducts :products="products" :total_pages="total_pages" />
    </div>
  </div>
</template>
