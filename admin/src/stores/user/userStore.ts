import { defineStore } from 'pinia'
import { getUser } from '../../service/axios'
import { ref } from 'vue'

interface User {
  id: number
  name: string
  permissions: string[]
}

export const useUserStore = defineStore('userAdminStore', () => {
  const user = ref<User | null>(null)

  const setUser = (value: User) => {
    user.value = value
  }

  const getUserInformations = async () => {
    if (user.value !== null) return
    try {
      const { data } = await getUser()
      user.value = data
    } catch (error) {
      console.log(error)
    }
  }

  return { user, setUser, getUserInformations }
})
