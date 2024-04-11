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

export const allProducts = async (page: number, perPage: number) => {
  return api.get(`products?page=${page}&per_page=${perPage}`)
}

export const deleteProductById = async (id: number) => {
  return api.delete(`products/${id}`)
}

export const getUser = async () => {
  return api.get('admin/user')
}
