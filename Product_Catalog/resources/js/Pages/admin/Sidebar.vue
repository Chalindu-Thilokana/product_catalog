<script setup>
import { Link } from '@inertiajs/vue3';
function isActive(route) {
  return page.url === route
}

</script>
<template>

    <aside class="fixed top-0 left-0 h-screen w-64 bg-gray-800 text-white flex flex-col">
      <div class="p-6 text-2xl font-bold border-b border-gray-700">
        E commerse
      </div>
      <nav class="flex-1 px-4 py-6">
        <ul>
          <li class="mb-4">
            <Link href="/dashboard" class="block py-2 px-3 rounded hover:bg-gray-700">Dashboard</Link>
          </li>
          <li class="mb-4">
            <Link href="/orders/show" class="block py-2 px-3 rounded hover:bg-gray-70 ">coustomers oders</Link>
          </li>
          
        </ul>
      </nav>
    </aside>
</template>




