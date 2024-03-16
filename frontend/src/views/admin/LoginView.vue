<script setup lang="ts">
import StarsBanner from '@/components/StarsBanner.vue'
import InputComponent from '@/components/input/InputComponent.vue'
import { validateEmail } from '@/validations/schemas'
import { useAuthAdminStore } from '@/stores/admin/authAdminStore'
import { ref } from 'vue'
import { storeToRefs } from 'pinia'

type Values = {
  email: string
  password: string
}

interface Erros extends Values {}

const authAdminStore = useAuthAdminStore()
const { errorResponse } = storeToRefs(authAdminStore)

const loading = ref<boolean>(false)
const values = ref<Values>({
  email: '',
  password: ''
})
const errors = ref<Erros>({
  email: '',
  password: ''
})

const onSubmit = async () => {
  errors.value.email = ''
  errors.value.password = ''

  if (!values.value.password || !values.value.email) {
    if (!validateEmail(values.value.email)) {
      errors.value.email = 'E-mail inválido'
    }
    if (!values.value.password) {
      errors.value.password = 'Necessário informar sua senha.'
    }

    return
  }

  loading.value = true
  await authAdminStore.loginAdmin(values.value)
  loading.value = false
}
</script>

<template>
  <div
    class="bg-black min-h-screen flex flex-col items-center justify-center gap-5 relative overflow-x-hidden"
  >
    <StarsBanner />
    <header>
      <div class="flex flex-col items-center justify-center gap-2">
        <img src="@/assets/svg/disco.svg" class="w-40" />
        <h1 class="text-white font-semibold text-2xl">Cybertaza</h1>
      </div>
    </header>

    <form
      @submit.prevent="onSubmit"
      class="w-full sm:max-w-[400px] flex flex-col items-center justify-center gap-5 p-5 z-20"
    >
      <div v-show="errorResponse" class="bg-red-500 text-white fontt-medium w-full text-center p-5">
        <span>{{ errorResponse }}</span>
      </div>
      <InputComponent
        name="email"
        placeholder="Insira seu e-mail"
        type="email"
        :error="errors.email"
        :borderError="errors.password || errorResponse"
        v-model="values.email"
      />

      <InputComponent
        name="password"
        placeholder="Insira  sua senha"
        type="password"
        :borderError="errors.password || errorResponse"
        :error="errors.password"
        v-model="values.password"
      />

      <button type="submit" class="w-full bg-blue p-2 text-white font-medium">
        <span v-if="loading">carregando..</span>
        <span v-else>Entrar</span>
      </button>
    </form>
  </div>
</template>
