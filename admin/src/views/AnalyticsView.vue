<script setup lang="ts">
import { ref } from 'vue'
import CardContainer from '../components/analytics/CardContainer.vue'
import { DoughnutChart, LineChart } from 'vue-chart-3'
import { Chart, registerables } from 'chart.js'

const testData = ref({
  labels: ['Paris', 'Nîmes', 'Toulon', 'Perpignan', 'Autre'],
  datasets: [
    {
      data: [30, 40, 60, 70, 5],
      backgroundColor: ['#77CEFF', '#0079AF', '#123E6B', '#97B0C4', '#A5C8ED']
    }
  ]
})

Chart.register(...registerables)
</script>

<template>
  <div class="h-screen overflow-y-auto p-5 flex justify-center">
    <div class="container w-full space-y-10">
      <div class="mt-10 w-full">
        <h1 class="text-4xl text-white">Analíticos</h1>
      </div>

      <div class="w-full flex flex-wrap gap-2 justify-center lg:justify-start">
        <CardContainer v-for="(number, index) in [1, 2, 3, 4]" :key="number" :index="index" />
      </div>

      <div class="w-full flex flex-col lg:flex-row gap-5">
        <div class="lg:w-2/5 bg-black-secondary rounded p-2">
          <DoughnutChart :chartData="testData" />
        </div>

        <div class="lg:w-3/5 bg-black-secondary rounded p-2">
          <LineChart :chartData="testData" />
        </div>
      </div>
      <div class="overflow-x-auto bg-black-secondary p-5 space-y-5 rounded-md">
        <h1 class="text-2xl text-white">Pedidos recentes</h1>

        <table class="table">
          <!-- head -->
          <thead>
            <tr class="bg-black text-white">
              <th></th>
              <th>Nome do produto</th>
              <th>cliente</th>
              <th>Preço</th>
              <th>status</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="item in [1, 2, 3, 4, 5]" :key="item">
              <th>1</th>
              <td>Mug Cyber</td>
              <td>John Dooe</td>
              <td>R$ 329,00</td>
              <td>
                <span class="bg-black font-medium text-sm text-success px-2 rounded-full"
                  >entregue</span
                >
              </td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>
