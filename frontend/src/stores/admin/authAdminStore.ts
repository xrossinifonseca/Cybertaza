import router from '@/router'
import { login } from '@/service/axios'
import { AxiosError } from 'axios'
import { defineStore } from 'pinia'
import { ref } from 'vue'

export const useAuthAdminStore = defineStore('adminAuthStore', () => {
  const errorResponse = ref<string>('')
  const authenticated = ref<boolean>(document.cookie.includes('check_token'))

  const loginAdmin = async (values: { email: string; password: string }) => {
    errorResponse.value = ''

    try {
      const response = await login(values)
      authenticated.value = true

      router.push('/admin')
    } catch (error: unknown) {
      if (error instanceof AxiosError) {
        if (error.code === 'ERR_NETWORK') {
          return (errorResponse.value = 'Falha ao tentar se conectar com o servidor.')
        }

        errorResponse.value = error.response?.data?.error
      }
    }
  }

  return {
    loginAdmin,
    errorResponse,
    authenticated
  }
})
