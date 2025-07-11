<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3'

const form = useForm({
  name: '',
  email: '',
  password: '',
  password_confirmation: '',
  terms: false,
})

const submit = () => {
  form.post(route('register'), {
    onFinish: () => form.reset('password', 'password_confirmation'),
  })
}
</script>

<template>
  <Head title="Register" />

  <div class="min-h-screen flex items-center justify-center bg-gradient-to-r from-indigo-600 via-purple-700 to-pink-600 px-4">
    <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
      <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Create an Account</h2>

      <form @submit.prevent="submit" novalidate>
        <!-- Name -->
        <div class="mb-4">
          <label for="name" class="block text-gray-700 font-medium mb-2">Full Name</label>
          <input
            id="name"
            type="text"
            v-model="form.name"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autofocus
            autocomplete="name"
          />
          <p v-if="form.errors.name" class="text-sm text-red-600 mt-1">{{ form.errors.name }}</p>
        </div>

        <!-- Email -->
        <div class="mb-4">
          <label for="email" class="block text-gray-700 font-medium mb-2">Email</label>
          <input
            id="email"
            type="email"
            v-model="form.email"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autocomplete="email"
          />
          <p v-if="form.errors.email" class="text-sm text-red-600 mt-1">{{ form.errors.email }}</p>
        </div>

        <!-- Password -->
        <div class="mb-4">
          <label for="password" class="block text-gray-700 font-medium mb-2">Password</label>
          <input
            id="password"
            type="password"
            v-model="form.password"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autocomplete="new-password"
          />
          <p v-if="form.errors.password" class="text-sm text-red-600 mt-1">{{ form.errors.password }}</p>
        </div>

        <!-- Confirm Password -->
        <div class="mb-4">
          <label for="password_confirmation" class="block text-gray-700 font-medium mb-2">Confirm Password</label>
          <input
            id="password_confirmation"
            type="password"
            v-model="form.password_confirmation"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autocomplete="new-password"
          />
          <p v-if="form.errors.password_confirmation" class="text-sm text-red-600 mt-1">{{ form.errors.password_confirmation }}</p>
        </div>

        <!-- Terms -->
        <div v-if="$page.props.jetstream.hasTermsAndPrivacyPolicyFeature" class="mb-4">
          <label for="terms" class="flex items-center">
            <input
              id="terms"
              type="checkbox"
              v-model="form.terms"
              class="mr-2 h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500"
            />
            <span class="text-sm text-gray-600">
              I agree to the
              <a :href="route('terms.show')" target="_blank" class="underline text-indigo-600 hover:text-indigo-800">Terms of Service</a>
              and
              <a :href="route('policy.show')" target="_blank" class="underline text-indigo-600 hover:text-indigo-800">Privacy Policy</a>
            </span>
          </label>
          <p v-if="form.errors.terms" class="text-sm text-red-600 mt-1">{{ form.errors.terms }}</p>
             
        </div>
        
        <!-- Action Buttons -->
        <div class="flex items-center justify-between mt-6">
            <Link :href="route('login')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    Already registered?
                </Link>

          <button
            type="submit"
            class="py-3 px-6 bg-indigo-600 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-700 transition duration-300 disabled:opacity-50"
            :disabled="form.processing"
          >
            <span v-if="form.processing">Registering...</span>
            <span v-else>Register</span>
          </button>
        </div>
      </form>
    </div>
  </div>
</template>
