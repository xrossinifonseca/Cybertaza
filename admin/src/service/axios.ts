import axios, { type AxiosResponse } from 'axios'

interface LoginCustomer {
  email: string
  password: string
}

export interface Product {
  name: string
  price: string
  color_id: number
  image?: File | null
}

interface QueryProducts {
  colors?: string[]
  price_order?: string
  per_page?: number
  page?: number
}

export const api = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  withCredentials: true
})

export const createProduct = async (values: Product) => {
  const formData = new FormData()
  formData.append('name', values.name)
  formData.append('price', values.price)
  formData.append('color_id', values.color_id.toString())

  if (values.image) {
    formData.append('image', values.image, values.image.name)
  }
  const response = await api.post('/products', formData, {
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  })
  return response.data
}

export const login = async (body: LoginCustomer): Promise<AxiosResponse> => {
  return api.post('/admin/login', body)
}

export const allProducts = async (query: QueryProducts) => {
  return api.get(`products`, {
    params: {
      color: query.colors,
      price_order: query.price_order
    }
  })
}

export const deleteProductById = async (id: number) => {
  return api.delete(`products/${id}`)
}

export const getUser = async () => {
  return api.get('admin/profile')
}
