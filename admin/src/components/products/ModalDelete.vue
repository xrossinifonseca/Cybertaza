<script lang="ts" setup>
import type { Product } from '../../types/productTypes'
import { deleteProductById } from '../../service/axios'
import { ref } from 'vue'
import { notification } from '../../utils/notification'
import { AxiosError } from 'axios'
import { useProductsStore } from '../../stores/products/productsStore'

const props = defineProps<{
  product: Product
}>()
const emit = defineEmits(['close-modal'])

const loading = ref<boolean>(false)
const productsStore = useProductsStore()

const deleteProduct = async () => {
  try {
    loading.value = true
    await deleteProductById(props.product.id)
    notification.success('Produto apagado com sucesso!')
    productsStore.removeProduct(props.product.id)
    emit('close-modal')
  } catch (error) {
    if (error instanceof AxiosError) {
      const { response } = error
      notification.error(response?.data?.error)
      return
    }
    console.log(error)
    notification.error('Houve um falha interna. tente novamente mais tarde.')
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div
    id="my_modal_1"
    class="fixed z-50 w-full h-full flex items-center justify-center top-0 left-0"
  >
    <div class="absolute top-0 left-0 -z-10 bg-black w-full h-full opacity-40"></div>

    <div class="modal-box">
      <h3 class="font-bold text-xl text-center">Deseja realmente apagar esse produto?</h3>

      <div class="flex items-center justify-start gap-5 border-b p-5 w-full mt-5">
        <div class="mask mask-squircle bg-white w-20 h-20 flex items-center">
          <img :src="props.product.image_url" alt="imagem" class="w-full" />
        </div>
        <h2 class="text-white text-xl font-medium capitalize">{{ props.product.name }}</h2>
      </div>

      <div class="modal-action">
        <div class="flex gap-2">
          <button :disabled="loading" @click="deleteProduct" class="btn btn-outline btn-error">
            Apagar <span class="loading loading-spinner" v-if="loading"></span>
          </button>
          <button @click="$emit('close-modal')" class="btn">Cancelar</button>
        </div>
      </div>
    </div>
  </div>
</template>
