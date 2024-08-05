import { allProducts } from '../../service/axios'
import { defineStore } from 'pinia'
import type { Product } from 'src/types/productTypes'
import { ref } from 'vue'
import { useRoute } from 'vue-router'

export const useProductsStore = defineStore('productsStore', () => {
  const products = ref<Product[]>([])
  const loading = ref<boolean>(true)
  const total_pages = ref<number>(1)
  const route = useRoute()

  const getProducts = async () => {
    loading.value = true
    const response = await allProducts(route.query)
    loading.value = false
    total_pages.value = response.data.total_pages
    products.value = response.data.products
  }

  const removeProduct = (id: number) => {
    const removed = products.value.filter((product) => product.id !== id)
    products.value = removed
  }

  return { loading, getProducts, products, total_pages, removeProduct }
})
