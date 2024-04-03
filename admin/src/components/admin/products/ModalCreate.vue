<script setup lang="ts">
import InputComponent from '@/components/input/InputComponent.vue'
import Colors from '@/components/Colors.vue'
import { createProduct } from '@/service/axios'
import { ref } from 'vue'
import { useProductsStore } from '@/stores/products/productsStore'

type Values = {
  name: string
  price: string
  color_id: number
  image: File | null
}

type Errors = Omit<Values, 'image' | 'color_id'> & { image: string; color_id: string }

const productsStore = useProductsStore()
const emit = defineEmits(['close-modal'])

const values = ref<Values>({
  name: '',
  price: '',
  color_id: 0,
  image: null
})
const errors = ref<Errors>({
  name: '',
  price: '',
  color_id: '',
  image: ''
})
const imgUrl = ref<string>('')

const handleSubmit = async () => {
  for (const key of Object.keys(errors.value)) {
    errors.value[key] = ''
  }

  if (!values.value.price || !values.value.name || !imgUrl.value) {
    if (!values.value.name) {
      errors.value.name = 'Necessário informar nome do produto'
    }
    if (!values.value.price) {
      errors.value.price = 'Necessário informar preço do produto.'
    }

    if (!imgUrl.value) {
      errors.value.image = 'Necessário enviar uma foto do produto'
    }

    if (!values.value.color_id) {
      errors.value.color_id = 'Necessário selecionar a cor do produto'
    }

    return
  }

  await createProduct(values.value)
  productsStore.getProducts()
  emit('close-modal')
}

const handleImageChange = (event: Event) => {
  const target = event.target as HTMLInputElement
  const file = target.files[0]
  values.value.image = file
  imgUrl.value = URL.createObjectURL(file)
}

const getColorId = (id: number) => {
  values.value.color_id = id
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
          @click="$emit('close-modal')"
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
          :class="{
            'border-red-500': errors.image
          }"
          class="relative border-2 border-gray-300 border-dashed rounded-lg p-6"
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
          <Colors :selectedId="values.color_id" :getId="getColorId" />
        </div>
        <div class="flex justify-center">
          <button type="submit" class="btn btn-lg btn-success">Cadastrar</button>
        </div>
      </form>
    </div>
  </div>
</template>
