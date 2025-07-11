<script setup>
import Layout from '@/Pages/web/layout.vue'
import { ref } from 'vue'



const cartItems = ref([
  {
    id: 1,
    name: 'Wireless Headphones',
    price: 120.0,
    quantity: 2,
    image: 'https://via.placeholder.com/100',
  },
  {
    id: 2,
    name: 'Smart Watch',
    price: 200.0,
    quantity: 1,
    image: 'https://via.placeholder.com/100',
  },
]);

const totalPrice = () => {
  return cartItems.value.reduce((acc, item) => acc + item.price * item.quantity, 0).toFixed(2);
};


const updateQuantity = (id, newQty) => {
  if (newQty < 1) return;
  const item = cartItems.value.find(i => i.id === id);
  if (item) item.quantity = newQty;
};


const removeItem = (id) => {
  cartItems.value = cartItems.value.filter(i => i.id !== id);
};
</script>

<template>
    <Layout>
  <div class="max-w-4xl mx-auto my-10 bg-white shadow rounded-lg p-6">
    <h2 class="text-2xl font-semibold mb-6 border-b pb-2">Shopping Cart</h2>

    <div v-if="cartItems.length === 0" class="text-center text-gray-500 py-10">
      Your cart is empty.
    </div>

    <div v-else>
      <table class="w-full text-left border-collapse">
        <thead>
          <tr class="border-b border-gray-300">
            <th class="py-2">Product</th>
            <th class="py-2">Price</th>
            <th class="py-2">Quantity</th>
            <th class="py-2">Total</th>
            <th class="py-2"></th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="item in cartItems" :key="item.id" class="border-b border-gray-200 hover:bg-gray-50">
            <td class="flex items-center space-x-4 py-4">
              <img :src="item.image" alt="Product Image" class="w-16 h-16 object-cover rounded" />
              <div>
                <p class="font-medium text-gray-800">{{ item.name }}</p>
              </div>
            </td>
            <td class="py-4 font-semibold text-gray-700">${{ item.price.toFixed(2) }}</td>
            <td class="py-4">
              <input
                type="number"
                min="1"
                class="w-16 border rounded text-center py-1"
                v-model.number="item.quantity"
                @change="updateQuantity(item.id, item.quantity)"
              />
            </td>
            <td class="py-4 font-semibold text-gray-900">${{ (item.price * item.quantity).toFixed(2) }}</td>
            <td class="py-4 text-red-600 cursor-pointer hover:text-red-800" @click="removeItem(item.id)">
              Remove
            </td>
          </tr>
        </tbody>
      </table>

      <div class="flex justify-end mt-6 space-x-4 items-center">
        <div class="text-lg font-semibold">Total:</div>
        <div class="text-xl font-bold text-indigo-600">${{ totalPrice() }}</div>
      </div>

      <div class="flex justify-end mt-6">
        <button
          class="bg-indigo-600 text-white px-6 py-3 rounded shadow hover:bg-indigo-700 transition duration-300"
          @click="$router.visit('/checkout')"
        >
          Proceed to Checkout
        </button>
      </div>
    </div>
  </div>
  </Layout>
</template>
