import { allProducts } from '../../service/axios'
import { defineStore } from 'pinia'
import type { Product } from 'src/types/productTypes'
import { ref } from 'vue'

interface Products {
  id: number
  name: string
  price: string
  color_id: number
  image_url: string
  created_at: string
  updated_at: string
}

export const useProductsStore = defineStore('productsStore', () => {
  const products = ref<Products[]>([])
  const loading = ref<boolean>(true)
  const total_pages = ref<number>(1)

  const getProducts = async () => {
    const response = await allProducts(1, 10)
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
