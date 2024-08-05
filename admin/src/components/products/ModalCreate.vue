<script setup lang="ts">
import InputComponent from '../../components/input/InputComponent.vue'
import Colors from '../../components/Colors.vue'
import { createProduct } from '../../service/axios'
import { reactive, ref } from 'vue'
import { useProductsStore } from '../../stores/products/productsStore'
import { notification } from '../../utils/notification'
import { AxiosError } from 'axios'

type Values = {
  name: string
  price: string
  color_id: number
  image: File | null
}

type Errors = Omit<Values, 'image' | 'color_id'> & {
  image: string
  color_id: string
  [key: string]: string
}
const emit = defineEmits(['close-modal'])

const productsStore = useProductsStore()
const values = reactive<Values>({
  name: '',
  price: '',
  color_id: 0,
  image: null
})

const errors = reactive<Errors>({
  name: '',
  price: '',
  color_id: '',
  image: ''
})

const imgUrl = ref<string>('')
const loading = ref<boolean>(false)

const handleSubmit = async () => {
  for (const key of Object.keys(errors)) {
    errors[key] = ''
  }

  if (!values.price || !values.name || !imgUrl.value || !values.color_id) {
    if (!values.name) {
      errors.name = 'Necessário informar nome do produto'
    }
    if (!values.price) {
      errors.price = 'Necessário informar preço do produto.'
    }

    if (!imgUrl.value) {
      errors.image = 'Necessário enviar uma foto do produto'
    }

    if (!values.color_id) {
      errors.color_id = 'Necessário selecionar a cor do produto'
    }

    return
  }

  try {
    loading.value = true

    await createProduct(values)
    notification.success('Produto cadastrado com sucesso!')
    productsStore.getProducts()
    emit('close-modal')
  } catch (error) {
    if (error instanceof AxiosError) {
      const { response } = error
      notification.error(response?.data?.error)
      return
    }
    notification.error('Houve um falha interna. tente novamente mais tarde.')
  } finally {
    loading.value = false
  }
}

const handleImageChange = (event: Event) => {
  const target = event.target as HTMLInputElement

  if (target.files) {
    const file = target.files[0]
    values.image = file
    imgUrl.value = URL.createObjectURL(file)
  }
}

const getColor = (color) => {
  values.color_id = color.id
}
</script>

<template>
  <div
    id="my_modal_1"
    class="fixed z-50 w-full h-full flex items-center justify-center top-0 left-0"
  >
    <div class="absolute top-0 left-0 -z-10 bg-black w-full h-full opacity-40"></div>
    <div class="modal-box space-y-5">
      <div class="flex justify-between items-center">
        <h3 class="text-2xl text-white">Criar novo produto</h3>
        <button
          @click.capture="$emit('close-modal')"
          class="btn bg-transparent hover:bg-transparent border-none"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="w-10">
            <path
              class="fill-red-600"
              d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM175 175c9.4-9.4 24.6-9.4 33.9 0l47 47 47-47c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9l-47 47 47 47c9.4 9.4 9.4 24.6 0 33.9s-24.6 9.4-33.9 0l-47-47-47 47c-9.4 9.4-24.6 9.4-33.9 0s-9.4-24.6 0-33.9l47-47-47-47c-9.4-9.4-9.4-24.6 0-33.9z"
            />
          </svg>
        </button>
      </div>

      <form class="space-y-5" @submit.prevent="handleSubmit">
        <div
          :data-error="errors.image ? true : false"
          class="relative border-2 border-gray-300 border-dashed rounded-lg p-6 data-[error=true]:border-red-500"
          id="dropzone"
        >
          <div v-if="!imgUrl">
            <input
              type="file"
              v-on:change="handleImageChange"
              class="absolute inset-0 w-full h-full opacity-0 z-50"
            />
            <div class="text-center">
              <img
                class="mx-auto h-12 w-12"
                src="https://www.svgrepo.com/show/357902/image-upload.svg"
                alt=""
              />

              <h3 class="mt-2 text-sm font-medium text-gray-900">
                <label for="file-upload" class="relative cursor-pointer space-x-2">
                  <span>Arraste e solte</span>
                  <span class="text-indigo-600">ou navegue</span>
                  <span>Para enviar</span>
                  <input id="file-upload" name="file-upload" type="file" class="sr-only" />
                </label>
              </h3>
              <p class="mt-1 text-xs text-gray-500">PNG, JPG, 10MB</p>
            </div>

            <img src="" class="mt-4 mx-auto max-h-40 hidden" id="preview" />
          </div>
          <div v-else class="flex justify-center">
            <img :src="imgUrl" alt="imagem" />
          </div>
        </div>

        <span v-if="errors.image" class="text-medium text-red-500 text-lg">{{ errors.image }}</span>
        <InputComponent
          v-model="values.name"
          name="name"
          :error="errors.name"
          :border-error="errors.name"
          placeholder="Nome "
          type="text"
        />
        <InputComponent
          name="price"
          placeholder="Preço"
          :error="errors.price"
          :border-error="errors.price"
          type="text"
          v-model="values.price"
        />

        <div class="space-y-2">
          <h2 class="text-xl">Escolha a cor do produto:</h2>
          <span v-if="errors.color_id" class="text-medium text-red-500 text-lg">{{
            errors.color_id
          }}</span>
          <Colors @get-values="getColor" />
        </div>

        <div class="flex justify-center">
          <button :disabled="loading" type="submit" class="btn btn-lg btn-success min-w-32">
            <span>Cadastrar</span>
            <span class="loading loading-spinner" v-if="loading"></span>
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
