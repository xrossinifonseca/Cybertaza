<script setup lang="ts">
import InputComponent from '@/components/input/InputComponent.vue'
import { createProduct } from '@/service/axios'
import { ref } from 'vue'

defineProps<{
  toggleModal: () => void
}>()

const values = ref({
  name: '',
  price: '',
  description: '',
  image: null
})

const imgUrl = ref('')

const handleSubmit = async () => {
  await createProduct(values.value)
  // console.log(response)
}

const handleImageChange = (event: any) => {
  const file = event.target.files[0]
  values.value.image = file
  imgUrl.value = URL.createObjectURL(file)
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
        <button :onClick="toggleModal" class="btn bg-transparent hover:bg-transparent border-none">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="w-10">
            <path
              class="fill-red-600"
              d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM175 175c9.4-9.4 24.6-9.4 33.9 0l47 47 47-47c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9l-47 47 47 47c9.4 9.4 9.4 24.6 0 33.9s-24.6 9.4-33.9 0l-47-47-47 47c-9.4 9.4-24.6 9.4-33.9 0s-9.4-24.6 0-33.9l47-47-47-47c-9.4-9.4-9.4-24.6 0-33.9z"
            />
          </svg>
        </button>
      </div>

      <form class="space-y-5" @submit.prevent="handleSubmit">
        <div class="relative border-2 border-gray-300 border-dashed rounded-lg p-6" id="dropzone">
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

        <InputComponent v-model="values.name" name="name" placeholder="Nome " type="text" />
        <InputComponent name="price" placeholder="Preço" type="number" v-model="values.price" />
        <InputComponent
          name="description "
          placeholder="Descrição"
          type="text"
          v-model="values.description"
        />
        <div class="flex justify-center">
          <button type="submit" class="btn btn-lg btn-success">Cadastrar</button>
        </div>
      </form>
    </div>
  </div>
</template>
