<script lang="ts" setup>
import { ref } from 'vue'
import type { Product } from '../../types/productTypes'
import ModalDelete from './ModalDelete.vue'
import { useUserStore } from '../../stores/user/userStore'
import { storeToRefs } from 'pinia'

const props = defineProps<{
  products: Array<Product>
  total_pages: number
}>()

const userStore = useUserStore()
const { user } = storeToRefs(userStore)

const product = ref<Product>({} as Product)
const modalDelete = ref(false)

const getProduct = (item: Product) => {
  product.value = item
  modalDelete.value = true
}

const closeModal = () => {
  modalDelete.value = false
}
</script>

<template>
  <div>
    <ModalDelete v-if="modalDelete" :product="product" @close-modal="closeModal" />

    <div v-if="props.products.length > 0">
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
            <tr v-for="product in props.products" :key="product.id">
              <th>
                <label>
                  <input type="checkbox" class="checkbox" />
                </label>
              </th>
              <td>
                <div class="avatar">
                  <div class="mask mask-squircle w-12 h-12">
                    <img :src="product?.image_url" alt="imagem" />
                  </div>
                </div>
              </td>
              <td>
                <div>{{ product?.name }}</div>
              </td>
              <td>R$ {{ product?.price }}</td>
              <td>{{ product?.color?.name }}</td>
              <th v-if="user?.permissions.includes('delete')">
                <button @click.capture="getProduct(product)" class="btn btn-outline btn-error">
                  Apagar
                </button>
              </th>
            </tr>
          </tbody>
        </table>
        <div class="text-end">
          <span>Pagina 1 de {{ props.total_pages }}</span>
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

    <div v-else class="text-center">
      <h1 class="text-sm">Nenhum produto cadastrado até o momento</h1>
    </div>
  </div>
</template>
