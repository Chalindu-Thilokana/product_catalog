<script setup>
import { ref, onMounted } from 'vue';
import AppLayout from '@/Layouts/AppLayout.vue';
import { Chart, registerables } from 'chart.js';

Chart.register(...registerables);

const props = defineProps({
  orders: Array,
  orderCount: Number,
});

const chartRef = ref(null);

onMounted(() => {
  const ctx = chartRef.value.getContext('2d');

  // Labels: order IDs formatted
  const labels = props.orders.map(o => `#${String(o.id).padStart(3, '0')}`);

  // Data: order totals
  const dataPoints = props.orders.map(o => Number(o.total));

  new Chart(ctx, {
    type: 'line',
    data: {
      labels,
      datasets: [{
        label: 'Order Totals',
        data: dataPoints,
        borderColor: 'rgba(75, 192, 192, 1)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        fill: true,
        tension: 0.3,
      }],
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { position: 'top' },
        tooltip: { enabled: true },
      },
      scales: {
        y: {
          beginAtZero: true,
          title: { display: true, text: 'Total Amount ($)' },
        },
        x: {
          title: { display: true, text: 'Order ID' },
        },
      },
    },
  });
});
</script>

<template>
  <AppLayout>
    <div class="max-w-[864px] mx-auto mt-6">
      <h2 class="text-lg font-bold mb-2">Large Orders Line Chart</h2>
      <div class="w-[864px] h-[576px] border p-2 rounded shadow">
        <canvas ref="chartRef" width="864" height="576" class="w-full h-full"></canvas>
      </div>
    </div>

    <!-- Orders list UI -->
    <div class="max-w-4xl mx-auto mt-10 bg-white shadow-md p-6 rounded-lg">
      <h2 class="text-2xl font-semibold mb-6">Customers Orders</h2>

      <div v-if="orders.length === 0" class="text-center text-gray-500 py-10">
        You have no orders yet.
      </div>

      <div v-else>
        <div
          v-for="order in orders"
          :key="order.id"
          class="mb-8 border border-gray-200 rounded-lg p-4 bg-gray-50"
        >
          <div class="mb-4">
            <h3 class="text-lg font-bold text-indigo-600">
              Order Number: <span class="text-gray-800">#ORD-{{ String(order.id).padStart(6, '0') }}</span>
            </h3>
            <p class="text-sm text-gray-600">
              Total Amount: <span class="font-semibold text-black">${{ Number(order.total).toFixed(2) }}</span>
            </p>
          </div>

          <table class="w-full text-sm text-left">
            <thead>
              <tr class="border-b border-gray-300 text-gray-700 bg-gray-100">
                <th class="py-2 px-2">Product Name</th>
                <th class="py-2 px-2">Quantity Ordered</th>
                <th class="py-2 px-2">Unit Price</th>
                <th class="py-2 px-2">Line Total</th>
              </tr>
            </thead>
            <tbody>
              <tr
                v-for="item in order.item_oder"
                :key="item.id"
                class="border-b border-gray-200"
              >
                <td class="py-2 px-2 font-medium text-gray-900">
                  {{ item.product?.name || 'Deleted Product' }}
                </td>
                <td class="py-2 px-2 text-gray-700">{{ item.quantity }}</td>
                <td class="py-2 px-2 text-gray-700">${{ Number(item.price).toFixed(2) }}</td>
                <td class="py-2 px-2 text-gray-800 font-semibold">
                  ${{ (item.quantity * Number(item.price)).toFixed(2) }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </AppLayout>
</template>
