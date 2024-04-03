<script setup lang="ts">
import ModalCreate from '@/components/admin/products/ModalCreate.vue'
import LoadingBalls from '@/components/loading/LoadingBalls.vue'
import { ref } from 'vue'
import { useProductsStore } from '@/stores/products/productsStore'
import { storeToRefs } from 'pinia'

const modal = ref<boolean>(false)
const productsStore = useProductsStore()

const { products, total_pages } = storeToRefs(productsStore)

const toggleModal = () => {
  modal.value = !modal.value
}

productsStore.getProducts()

const teste = () => console.log('fala')
</script>

<template>
  <div class="overflow-y-auto h-screen">
    <ModalCreate v-if="modal" @close-modal="toggleModal" />
    <LoadingBalls v-if="productsStore.loading" />

    <div class="w-full min-h-screen p-5 space-y-20">
      <div class="mt-10 w-full flex justify-around">
        <h1 class="text-4xl text-white">Produtos</h1>
        <button :onclick="toggleModal" class="btn btn-outline btn-success">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="w-4 fill-white">
            <path
              d="M256 80c0-17.7-14.3-32-32-32s-32 14.3-32 32V224H48c-17.7 0-32 14.3-32 32s14.3 32 32 32H192V432c0 17.7 14.3 32 32 32s32-14.3 32-32V288H400c17.7 0 32-14.3 32-32s-14.3-32-32-32H256V80z"
            />
          </svg>
        </button>
      </div>

      <div class="overflow-x-auto">
        <table class="table text-white">
          <thead class="text-lg text-white">
            <tr>
              <th>
                <label>
                  <input type="checkbox" class="checkbox" />
                </label>
              </th>
              <th></th>
              <th>Nome</th>
              <th>Valor</th>
              <th>Cor</th>
            </tr>
          </thead>
          <tbody class="text-lg font-light">
            <tr v-for="product in products" :key="product.id">
              <th>
                <label>
                  <input type="checkbox" class="checkbox" />
                </label>
              </th>
              <td>
                <div class="avatar">
                  <div class="mask mask-squircle w-12 h-12">
                    <img :src="product.image_url" alt="imagem" />
                  </div>
                </div>
              </td>
              <td>
                <div>{{ product.name }}</div>
              </td>
              <td>R$ {{ product.price }}</td>
              <td>{{ product.color.name }}</td>
              <th>
                <button class="btn btn-outline btn-accent">Editar</button>
              </th>
            </tr>
          </tbody>
        </table>
        <div class="text-end">
          <span>Pagina 1 de {{ total_pages }}</span>
        </div>
      </div>

      <!-- btn pagination -->
      <div class="flex justify-center">
        <div class="join grid grid-cols-2">
          <button class="join-item btn bg-yellow text-black hover:text-white">Anterior</button>
          <button class="join-item btn bg-yellow text-black hover:text-white">Próxima</button>
        </div>
      </div>
    </div>
  </div>
</template>
