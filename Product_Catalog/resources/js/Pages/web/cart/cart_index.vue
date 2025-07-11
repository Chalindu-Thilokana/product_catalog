<script setup>
import Layout from '@/Pages/web/layout.vue'
import { computed } from 'vue'
import { Link, router } from '@inertiajs/vue3'

const props = defineProps({
  cartItems: {
    type: Array,
    default: () => [],
  },
})
//console.log('Session cart data:', props.cartItems);
const safeCartItems = computed(() => props.cartItems ?? [])

const updateQuantity = (productId, newQty) => {
  if (newQty < 1) return
  router.post('/cart/update', { product_id: productId, quantity: newQty }, { preserveScroll: true })
}

const removeItem = (productId) => {
  router.post('/cart/remove', { product_id: productId }, { preserveScroll: true })
}

const totalPrice = computed(() => {
  return safeCartItems.value.reduce((acc, item) => acc + item.total, 0).toFixed(2)
})



function checkout() {
  router.post('/checkout');
}

function order() {
  router.post('/orders.index');
}
</script>

<template>
  <Layout>
    <div class="max-w-4xl mx-auto my-10 bg-white shadow rounded-lg p-6">
      <h2 class="text-2xl font-semibold mb-6 border-b pb-2">Shopping Cart</h2>

      <div v-if="safeCartItems.length === 0" class="text-center text-gray-500 py-10">
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
            <tr v-for="item in safeCartItems" :key="item.product_id" class="border-b border-gray-200 hover:bg-gray-50">
              <td class="flex items-center space-x-4 py-4">
                <img
                  :src="item.product.photo ? '/storage/' + item.product.photo : 'https://via.placeholder.com/100'"
                  alt="Product Image"
                  class="w-16 h-16 object-cover rounded"
                />
                <div>
                  <p class="font-medium text-gray-800">{{ item.product.name }}</p>
                </div>
              </td>
              <td class="py-4 font-semibold text-gray-700">${{ item.product.price.toFixed(2) }}</td>
              <td class="py-4">
                <input
                  type="number"
                  min="1"
                  class="w-16 border rounded text-center py-1"
                  v-model.number="item.quantity"
                  @change="updateQuantity(item.product_id, item.quantity)"
                />
              </td>
              <td class="py-4 font-semibold text-gray-900">${{ item.total.toFixed(2) }}</td>
              <td
                class="py-4 text-red-600 cursor-pointer hover:text-red-800"
                @click="removeItem(item.product_id)"
              >
                Remove
              </td>
            </tr>
          </tbody>
        </table>

        <div class="flex justify-end mt-6 space-x-4 items-center">
          <div class="text-lg font-semibold">Total:</div>
          <div class="text-xl font-bold text-indigo-600">${{ totalPrice }}</div>
        </div>

        <div class="flex justify-end mt-6">
          <button
            class="bg-indigo-600 text-white px-6 py-3 rounded shadow hover:bg-indigo-700 transition duration-300"
             @click="checkout">
          
            Proceed to Checkout
          </button>

          
      </div>
    </div>
     <div class="flex justify-end mt-6">
          <Link href="/orders" class="bg-indigo-600 text-white px-6 py-3 rounded shadow">
            
           
            view orders
          </Link>
        </div>
  </div>
  </Layout>
</template>
