<script setup>
import { ref } from 'vue'
import { Link, usePage } from '@inertiajs/vue3'


const open = ref(false)
const page = usePage()

const props = defineProps({
  canLogin: {
    type: Boolean,
    default: true,
  },
  canRegister: {
    type: Boolean,
    default: true,
  },
});

function isActive(route) {
  return page.url === route
}
</script>

<template>

  <nav class="bg-white border-b border-gray-200">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between h-16 items-center">

      
         <div class="flex items-center">
          <Link href="/" class="text-2xl font-bold text-indigo-600 hover:text-indigo-800 transition">
            🌀 Luminix e-com
          </Link>
        </div>


        <div class="hidden sm:-my-px sm:ml-6 sm:flex sm:space-x-8"  v-if="canLogin">
          <Link href="/" class="inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium text-gray-500 hover:border-indigo-500 hover:text-gray-700" 
            :class="{ 'border-indigo-500 text-gray-900': isActive('/') }"> Product</Link>
          <Link  v-if="$page.props.auth.user && $page.props.auth.user.usertype === 'user'" :href="route('Cart_index')" class="inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium text-gray-500 hover:border-indigo-500 hover:text-gray-700" 
            :class="{ 'border-indigo-500 text-gray-900': isActive('/about') }"> <svg xmlns="http://www.w3.org/2000/svg" 
         class="h-6 w-6 text-gray-700" fill="none" viewBox="0 0 24 24" 
         stroke="currentColor" stroke-width="2">
             <path stroke-linecap="round" stroke-linejoin="round" 
            d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-1.5 7h13L17 13M9 21a1 1 0 11-2 0 1 1 0 012 0zm10 0a1 1 0 11-2 0 1 1 0 012 0z" />
             </svg>cart</Link>

             
        
        

       
      
          <template v-if="$page.props.auth.user">

            <Link v-if="$page.props.auth.user.usertype === 'user'"
        href="/logout"
        method="post"
        as="button"
        class="text-red-600 hover:underline px-3 py-2 text-sm font-medium"
      >
        Logout
      </Link>
            <!----<Link v-if="$page.props.auth.user.usertype === 'user'" :href="route('dashboard')" class="font-semibold text-gray-600 hover:text-gray-900 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Dashboard</Link>
    -->
            <Link v-if="$page.props.auth.user.usertype === 'admin'" :href="route('dashboard')" class="font-semibold text-gray-600 hover:text-gray-900 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Dashboard</Link>
          </template>
          <template v-else>
            <Link :href="route('login')" class="font-semibold text-gray-600 hover:text-gray-900 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Log in</Link>
          
            <!--nk v-if="canRegister" :href="route('register')" class="ms-4 font-semibold text-gray-600 hover:text-gray-900 focus:outline focus:outline-2 focus:rounded-sm focus:outline-red-500">Register</Link>
          -->
        </template>
        </div>
        

        <div class="-mr-2 flex items-center sm:hidden">
          <button @click="open = !open" type="button" 
            class="inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-indigo-600 hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500" 
            aria-controls="mobile-menu" aria-expanded="false">
            <span class="sr-only">Open main menu</span>
            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
              <path v-if="!open" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
              <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
            </svg>
          </button>
        </div>
      </div>
    </div>

    <div v-show="open" class="sm:hidden" id="mobile-menu">
      <div class="pt-2 pb-3 space-y-1">
        <Link href="/" class="block pl-3 pr-4 py-2 border-l-4 border-indigo-500 bg-indigo-50 text-indigo-700 text-base font-medium">Product</Link>
        
        <Link href="/login" class="block pl-3 pr-4 py-2 border-l-4 border-transparent hover:border-indigo-500 hover:bg-indigo-50 hover:text-indigo-700 text-base font-medium">Log in</Link>
      </div>
    </div>
  </nav>



</template>










 