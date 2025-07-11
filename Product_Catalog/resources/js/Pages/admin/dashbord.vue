<script setup>
import { ref, computed } from 'vue';
import { router, Link } from '@inertiajs/vue3';
import Swal from 'sweetalert2';
import AppLayout from '@/Layouts/AppLayout.vue';

const props = defineProps({
  products: Object, // Laravel paginator object with: data, links, meta
});

const searchTerm = ref('');
const sortKey = ref('id');
const sortAsc = ref(true);

// Filter local page data (only current page data)
const filteredProducts = computed(() => {
  if (!searchTerm.value) return props.products.data;
  return props.products.data.filter(p =>
    p.name.toLowerCase().includes(searchTerm.value.toLowerCase())
  );
});

// Sort filtered data locally
const sortedProducts = computed(() => {
  return [...filteredProducts.value].sort((a, b) => {
    const aVal = a[sortKey.value];
    const bVal = b[sortKey.value];

    if (aVal === bVal) return 0;

    if (sortAsc.value) {
      return aVal > bVal ? 1 : -1;
    } else {
      return aVal < bVal ? 1 : -1;
    }
  });
});

function changeSort(key) {
  if (sortKey.value === key) {
    sortAsc.value = !sortAsc.value;
  } else {
    sortKey.value = key;
    sortAsc.value = true;
  }
}

function destroy(id) {
  Swal.fire({
    title: 'Are you sure?',
    text: 'Delete this product?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Yes, delete it!',
  }).then((result) => {
    if (result.isConfirmed) {
      router.delete(`/products/${id}`, {
        onSuccess: () => {
          router.reload({ preserveScroll: true });
          Swal.fire('Deleted!', 'Product removed.', 'success');
        },
      });
    }
  });
}

function goToPage(url) {
  if (!url) return;
  try {
    const parsedUrl = new URL(url);
    const relativeUrl = parsedUrl.pathname + parsedUrl.search;
    router.visit(relativeUrl, { preserveScroll: true, preserveState: true });
  } catch {
    router.visit(url, { preserveScroll: true, preserveState: true });
  }
}
</script>

<template>
  <AppLayout title="Product Dashboard">
    <template #header>
      <h2 class="font-semibold text-2xl text-gray-800">📦 List Products</h2>
    </template>

    <div class="p-6 max-w-7xl mx-auto">
      <div class="flex justify-between mb-4">
        <Link href="/products/create" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700">
          ➕ Add Product
        </Link>

        <input
          v-model="searchTerm"
          type="text"
          placeholder="Search products by name (current page only)"
          class="border rounded px-3 py-2 w-64 focus:outline-none focus:ring-2 focus:ring-blue-500"
        />
      </div>

      <table class="min-w-full divide-y divide-gray-200 border rounded shadow">
        <thead class="bg-gray-50">
          <tr>
            <th
              @click="changeSort('id')"
              class="cursor-pointer px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              ID <span v-if="sortKey === 'id'">{{ sortAsc ? '▲' : '▼' }}</span>
            </th>
            <th
              @click="changeSort('name')"
              class="cursor-pointer px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Name <span v-if="sortKey === 'name'">{{ sortAsc ? '▲' : '▼' }}</span>
            </th>
            <th
              @click="changeSort('price')"
              class="cursor-pointer px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Price (Rs.) <span v-if="sortKey === 'price'">{{ sortAsc ? '▲' : '▼' }}</span>
            </th>
            <th
              @click="changeSort('stock')"
              class="cursor-pointer px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
            >
              Stock <span v-if="sortKey === 'stock'">{{ sortAsc ? '▲' : '▼' }}</span>
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Photo
            </th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>

        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="product in sortedProducts" :key="product.id">
            <td class="px-6 py-4 whitespace-nowrap">{{ product.id }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ product.name }}</td>
            <td class="px-6 py-4 whitespace-nowrap">Rs. {{ product.price }}</td>
            <td class="px-6 py-4 whitespace-nowrap">{{ product.stock }}</td>
            <td class="px-6 py-4 whitespace-nowrap">
              <img
                v-if="product.photo"
                :src="`/storage/${product.photo}`"
                alt="Product Photo"
                class="w-10 h-10 rounded object-cover"
              />
              <span v-else class="text-gray-400 italic text-sm">No image</span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap space-x-2">
              <Link :href="`/products/${product.id}/edit`" class="text-blue-600 hover:underline">Edit</Link>
              <button @click="destroy(product.id)" class="text-red-600 hover:underline">Delete</button>
            </td>
          </tr>

          <tr v-if="sortedProducts.length === 0">
            <td colspan="6" class="text-center py-4 text-gray-500 italic">No products found.</td>
          </tr>
        </tbody>
      </table>

      <!-- Pagination Controls -->
      <div class="flex justify-center mt-4 space-x-2">
        <button
          v-for="link in products.links"
          :key="link.label"
          @click="goToPage(link.url)"
          v-html="link.label"
          :disabled="!link.url"
          class="px-3 py-1 rounded"
          :class="{
            'bg-blue-500 text-white cursor-pointer': link.active,
            'bg-gray-200 text-gray-500 cursor-not-allowed': !link.url && !link.active,
            'bg-gray-100 text-gray-700 cursor-pointer': !link.active && link.url
          }"
        />
      </div>
    </div>
  </AppLayout>
</template>
