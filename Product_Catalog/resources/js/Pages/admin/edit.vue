<script setup>
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'
import Swal from 'sweetalert2'
import AppLayout from '@/Layouts/AppLayout.vue'

const props = defineProps({
  product: Object
})

const form = useForm({
  name: props.product.name || '',
  description: props.product.description || '',
  price: props.product.price || '',
  stock: props.product.stock || '',
  photo: null,
})

//const preview = ref(props.product.photo_url || '')

const preview = ref(
  props.product.photo_url 
  || (props.product.photo ? `/storage/${props.product.photo}` : '') 
  || ''
)

const handlePhotoChange = (e) => {
  const file = e.target.files[0]
  if (file) {
    form.photo = file
    preview.value = URL.createObjectURL(file)
  } else {
    form.photo = null
    preview.value = 
      props.product.photo_url 
      || (props.product.photo ? `/storage/${props.product.photo}` : '') 
      || ''
  }
}

const submit = () => {
  form.transform((data) => ({
    ...data,
    _method: 'put'
  })).post(route('products.update', props.product.id), {
    onSuccess: () => {
      Swal.fire({
        icon: 'success',
        title: 'Product updated!',
        timer: 1500,
        showConfirmButton: false,
      })
    },
    onError: () => {
      Swal.fire({
        icon: 'error',
        title: 'Failed to update product',
        text: 'Please fix the errors and try again.',
      })
    }
  })
}
</script>

<template>
  <AppLayout title="Edit Product">
    <template #header>
      <h2 class="font-semibold text-3xl text-gray-900">Edit Product</h2>
    </template>

    <div class="max-w-xl mx-auto mt-8 p-6 bg-white rounded-lg shadow-md">
      <form @submit.prevent="submit" enctype="multipart/form-data" class="space-y-6">
        
        <!-- Name -->
        <div>
          <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Name *</label>
          <input
            id="name"
            type="text"
            v-model="form.name"
            :class="['block w-full rounded-md border px-3 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500', form.errors.name ? 'border-red-500' : 'border-gray-300']"
            required
          />
          <p v-if="form.errors.name" class="mt-1 text-sm text-red-600">{{ form.errors.name }}</p>
        </div>

        <!-- Description -->
        <div>
          <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
          <textarea
            id="description"
            rows="3"
            v-model="form.description"
            :class="['block w-full rounded-md border px-3 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500', form.errors.description ? 'border-red-500' : 'border-gray-300']"
          ></textarea>
          <p v-if="form.errors.description" class="mt-1 text-sm text-red-600">{{ form.errors.description }}</p>
        </div>

        <!-- Price and Stock -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
          <div>
            <label for="price" class="block text-sm font-medium text-gray-700 mb-1">Price (Rs.) *</label>
            <input
              id="price"
              type="number"
              step="0.01"
              min="0"
              v-model="form.price"
              :class="['block w-full rounded-md border px-3 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500', form.errors.price ? 'border-red-500' : 'border-gray-300']"
              required
            />
            <p v-if="form.errors.price" class="mt-1 text-sm text-red-600">{{ form.errors.price }}</p>
          </div>

          <div>
            <label for="stock" class="block text-sm font-medium text-gray-700 mb-1">Stock *</label>
            <input
              id="stock"
              type="number"
              min="0"
              v-model="form.stock"
              :class="['block w-full rounded-md border px-3 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500', form.errors.stock ? 'border-red-500' : 'border-gray-300']"
              required
            />
            <p v-if="form.errors.stock" class="mt-1 text-sm text-red-600">{{ form.errors.stock }}</p>
          </div>
        </div>

        <!-- Photo -->
        <div>
          <label for="photo" class="block text-sm font-medium text-gray-700 mb-1">Product Photo</label>
          <input
            id="photo"
            type="file"
            accept="image/*"
            @change="handlePhotoChange"
            class="block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:text-sm file:bg-indigo-50 file:text-indigo-700 hover:file:bg-indigo-100"
          />
          <p v-if="form.errors.photo" class="mt-1 text-sm text-red-600">{{ form.errors.photo }}</p>

          <div v-if="preview" class="mt-3">
            <p class="mb-1 text-sm font-medium text-gray-700">Image Preview:</p>
            <img :src="preview" alt="Preview" class="max-h-40 rounded-md border object-contain w-full" />
          </div>
        </div>

        <!-- Buttons -->
        <div class="flex justify-end space-x-4">
          <a
            :href="route('dashboard')"
            class="inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-100"
          >
            Cancel
          </a>
          <button
            type="submit"
            :disabled="form.processing"
            class="inline-flex justify-center px-6 py-2 bg-indigo-600 text-white text-sm font-medium rounded-md shadow-sm hover:bg-indigo-700 disabled:opacity-50"
          >
            <span v-if="form.processing">Updating...</span>
            <span v-else>Update Product</span>
          </button>
        </div>
      </form>
    </div>
  </AppLayout>
</template>
