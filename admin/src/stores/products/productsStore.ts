import { allProducts } from '@/service/axios'
import { defineStore } from 'pinia'
import { ref } from 'vue'

interface Products {
  id: number
  name: string
  price: string
  image_url: string
  description: string
  created_at: string
  updated_at: string
}

// interface Product extends Omit<Products, 'id' | 'created_at' | 'updated_at'> {}

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

  return { loading, getProducts, products, total_pages }
})
