<script setup>
import { onMounted } from 'vue'
import AppLayout from '@/Layouts/AppLayout.vue'
import { useForm } from '@inertiajs/vue3'
import { usePage } from '@inertiajs/vue3'
import { Link, router } from '@inertiajs/vue3';
import Swal from 'sweetalert2'
import { ref } from 'vue'

const form = useForm({
  name: '',
  description: '',
  price: '',
  stock: '',
  photo: null,
})

const preview = ref(null)

function handlePhotoUpload(e) {
  const file = e.target.files[0]
  form.photo = file
  if (file) {
    preview.value = URL.createObjectURL(file)
  }
}

onMounted(() => {
  if (page.props.flash.success) {
    Swal.fire('Success', page.props.flash.success, 'success')
  }
  if (page.props.flash.error) {
    Swal.fire('Error', page.props.flash.error, 'error')
  }
})

function submit() {
  form.post(route('products.store'), {
    onSuccess: () => {
      Swal.fire({
        icon: 'success',
        title: 'Product Created!',
        text: '🎉 Your product was added successfully.',
        timer: 2000,
        showConfirmButton: false,
      });
    },
    onError: () => {
      Swal.fire({
        icon: 'error',
        title: 'Validation Error',
        text: '⚠️ Please fix the validation errors below.',
      });
    },
  })
}

</script>

<template>
  <AppLayout title="Add Product">
    <template #header>
      <h2 class="font-semibold text-2xl text-gray-800">➕ Add New Product</h2>
    </template>

    <div class="p-6 max-w-3xl mx-auto bg-white rounded-xl shadow-lg mt-6">
      <form @submit.prevent="submit" enctype="multipart/form-data" class="space-y-6">

       
        <div>
          <label class="block mb-1 text-sm font-medium text-gray-700">Product Name</label>
          <input
            v-model="form.name"
            type="text"
            class="w-full px-4 py-2 border rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none"
            placeholder="e.g. Apple iPhone 14"
          />
          <div v-if="form.errors.name" class="text-sm text-red-600 mt-1">{{ form.errors.name }}</div>
        </div>

        <div>
          <label class="block mb-1 text-sm font-medium text-gray-700">Description</label>
          <textarea
            v-model="form.description"
            rows="3"
            class="w-full px-4 py-2 border rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none"
            placeholder="Write product details here..."
          ></textarea>
          <div v-if="form.errors.description" class="text-sm text-red-600 mt-1">{{ form.errors.description }}</div>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">Price (Rs.)</label>
            <input
              v-model="form.price"
              type="number"
              step="0.01"
              class="w-full px-4 py-2 border rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none"
              placeholder="150000.00"
            />
            <div v-if="form.errors.price" class="text-sm text-red-600 mt-1">{{ form.errors.price }}</div>
          </div>

          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700">Stock</label>
            <input
              v-model="form.stock"
              type="number"
              class="w-full px-4 py-2 border rounded-md focus:ring-2 focus:ring-blue-500 focus:outline-none"
              placeholder="e.g. 25"
            />
            <div v-if="form.errors.stock" class="text-sm text-red-600 mt-1">{{ form.errors.stock }}</div>
          </div>
        </div>

     
        <div>
          <label class="block mb-2 text-sm font-medium text-gray-700">Product Photo</label>
          <input
            type="file"
            accept="image/*"
            @change="handlePhotoUpload"
            class="file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:bg-blue-50 file:text-blue-600 hover:file:bg-blue-100"
          />
          <div v-if="form.errors.photo" class="text-sm text-red-600 mt-1">{{ form.errors.photo }}</div>

          <div v-if="preview" class="mt-4">
            <p class="text-sm text-gray-600 mb-2">Image Preview:</p>
            <img :src="preview" alt="Preview" class="w-40 h-40 object-cover rounded border" />
          </div>
        </div>

    
        <div>
          <button
            type="submit"
            class="w-full bg-blue-600 hover:bg-blue-700 transition text-white font-semibold py-2 px-4 rounded-md shadow"
          >
            🚀 Create Product
          </button>
        </div>
      </form>
    </div>
  </AppLayout>
</template>
