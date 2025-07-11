<script setup>
import Layout from '@/Pages/web/layout.vue'
import { ref, computed, onMounted } from 'vue'
import Cart from '@/Pages/web/cart/cart_index.vue'
import { router } from '@inertiajs/vue3'
import Swal from 'sweetalert2'
const filters = ref({
  name: '',
})

function showSuccessAlert() {
  Swal.fire({
    title: "Good job!",
    text: "You clicked the button!",
    icon: "success"
  });
}



const addToCart = (productId) => {

  

  
  router.post('/cart/add', { product_id: productId, quantity: 1 }, {
    preserveScroll: true,
    onSuccess: () => {
      Swal.fire({
        icon: 'success',
        title: 'Added to cart!',
        text: 'You will be redirected to your cart.',
        timer: 1500,
        showConfirmButton: false,
      })

      setTimeout(() => {
        router.visit(route('cart.index'))
      }, 1500)
    },
    onError: () => {
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'There was a problem adding the product to your cart.',
      })
    },
  })
}

const props = defineProps({
  products: Object,
  filters: Object
});

onMounted(() => {
  if (props.filters) {
    filters.value = { ...props.filters }
  }
})


const currentPage = computed(() => props.products?.current_page || 1)

function goToPage(page) {
  
  const params = {
    page: page,
    ...(props.filters || {}) 
  }
  

  
  router.get(route('product_view'), params, { 
    preserveState: true, 
    replace: true,
    preserveScroll: true 
  });
}

function filter() {
  console.log('Apply filters:', filters.value)
 
  const params = {
    page: 1,
    ...filters.value
  }
  
 
  router.get(route('products.filter'), params, { 
    preserveState: true, 
    replace: true,
    preserveScroll: true,
  });
}

import { watch } from 'vue'
watch(() => props.filters, (newFilters) => {
  if (newFilters) {
    filters.value = { ...newFilters }
  }
}, { immediate: true })
</script>

<template>
  <Layout>
    <section class="relative min-h-[60vh] flex items-center justify-center overflow-hidden bg-black">

      <div class="absolute inset-0 z-0 bg-gradient-to-r from-indigo-800 via-fuchsia-600 to-pink-700 bg-[length:400%_400%] animate-gradient pointer-events-none blur-2xl opacity-50"></div>

      <div class="relative z-10 text-center text-white px-4 sm:px-6">
        <h1 class="text-5xl sm:text-6xl font-bold tracking-tight drop-shadow-[0_0_25px_#c084fc]">
          Where Fashion Glows
        </h1>
        <p class="mt-6 text-xl max-w-2xl mx-auto text-gray-300 drop-shadow-[0_0_10px_#22d3ee]">
          Explore the blend of neon and elegance.
        </p>
        <div class="mt-8 flex justify-center gap-4">
          <a href="/shop" class="bg-indigo-600 hover:bg-indigo-700 text-white font-semibold px-6 py-3 rounded-full shadow-xl transition duration-300">
            Shop Now
          </a>
          <a href="/learn" class="bg-gradient-to-r from-fuchsia-600 to-pink-500 hover:from-pink-600 hover:to-orange-500 text-white font-semibold px-6 py-3 rounded-full shadow-xl transition duration-300">
            Discover More
          </a>
        </div>
      </div>
    </section>

    <div class="min-h-screen bg-gray-100 p-6">

      <form @submit.prevent="filter" class="bg-white p-6 rounded-lg shadow mb-8">
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700">Product name</label>
            <input
              type="text"
              v-model="filters.name"
              class="mt-2 w-full border rounded-md p-2"
              placeholder="Search products..."
            />
            <div class="text-right mt-4"></div>
            <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-lg">Filter</button>
          </div>
        </div>
   
        <div v-if="props.filters && Object.keys(props.filters).length > 0" class="mt-4 pt-4 border-t">
          <p class="text-sm text-gray-600">Current filters:</p>
          <div class="flex flex-wrap gap-2 mt-2">
            <span v-for="(value, key) in props.filters" :key="key" 
                  v-if="value" 
                  class="px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm">
              {{ key }}: {{ value }}
            </span>
          </div>
        </div>
      </form>

    
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div v-for="product in products.data" :key="product.id" class="bg-white rounded-lg shadow p-4">
   <div class="w-48 mx-auto aspect-w-4 aspect-h-3">
  <img
    :src="product.photo ? `/storage/${product.photo}` : 'https://via.placeholder.com/300x225'"
    alt="product image"
    class="w-full h-full object-cover rounded"
  />
</div>

          <h3 class="mt-4 text-lg font-semibold text-gray-800">{{ product.name }}</h3>
          <p class="text-gray-600 mt-1 text-sm line-clamp-3">
            {{ product.description || 'No description available.' }}
          </p>
          <div class="mt-2 flex justify-between items-center">
            <span class="text-xl font-bold text-indigo-600">Rs. {{ product.price }}</span>
           <button
           
                  @click="addToCart(product.id)"
                 class="text-sm bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded">
                    Go to Cart
               </button>
          </div>
        </div>
      </div>

      <div class="flex justify-center items-center gap-4 mt-8" v-if="products.last_page > 1">
        <button
          class="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded disabled:opacity-50 disabled:cursor-not-allowed"
          :disabled="!products.prev_page_url"
          @click="goToPage(currentPage - 1)"
        >
          Previous
        </button>

        <div class="flex gap-2">
          <template v-for="page in Math.min(products.last_page, 5)" :key="page">
            <button
              :class="[
                'px-3 py-2 rounded',
                page === currentPage 
                  ? 'bg-indigo-600 text-white' 
                  : 'bg-gray-200 hover:bg-gray-300 text-gray-700'
              ]"
              @click="goToPage(page)"
            >
              {{ page }}
            </button>
          </template>
          
          <span v-if="products.last_page > 5" class="px-3 py-2">...</span>
        </div>

        <span class="text-sm text-gray-600">
          Page {{ currentPage }} of {{ products.last_page }}
        </span>

        <button
          class="px-4 py-2 bg-gray-300 hover:bg-gray-400 rounded disabled:opacity-50 disabled:cursor-not-allowed"
          :disabled="!products.next_page_url"
          @click="goToPage(currentPage + 1)"
        >
          Next
        </button>
      </div>

      
      <div v-if="!products.data || products.data.length === 0" class="text-center py-12">
        <p class="text-gray-500 text-lg">No products found.</p>
      </div>
    </div>
  </Layout>
</template>

<style scoped>
@keyframes gradient {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

.animate-gradient {
  animation: gradient 6s ease infinite;
}
</style>