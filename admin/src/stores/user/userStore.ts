import { defineStore } from 'pinia'
import { ref } from 'vue'

interface User {
  id: number
  name: string
  role: string
  email: string
}

export const useUserStore = defineStore('userAdminStore', () => {
  const user = ref<User | null>(null)

  const setUser = (value: User) => {
    user.value = value
  }

  const getUserInformations = async () => {
    if (user.value !== null) return

    console.log('call informations endpoint')
  }

  return { user, setUser, getUserInformations }
})
