<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import AuthenticationCard from '@/Components/AuthenticationCard.vue';
import AuthenticationCardLogo from '@/Components/AuthenticationCardLogo.vue';
import Checkbox from '@/Components/Checkbox.vue';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';

defineProps({
    canResetPassword: Boolean,
    status: String,
});

const form = useForm({
    email: '',
    password: '',
    remember: false,
});

const submit = () => {
    form.transform(data => ({
        ...data,
        remember: form.remember ? 'on' : '',
    })).post(route('login'), {
        onFinish: () => form.reset('password'),
    });
};
</script>
<template>
  <Head title="Login" />

  <div class="min-h-screen flex items-center justify-center bg-gradient-to-r from-indigo-600 via-purple-700 to-pink-600 px-4">
    <div class="max-w-md w-full bg-white rounded-xl shadow-lg p-8">
      <h2 class="text-3xl font-bold text-center text-gray-800 mb-6"> Drazzle Fashion</h2>

      <form @submit.prevent="submit" novalidate>
        <!-- Email -->
        <div class="mb-4">
          <label for="email" class="block text-gray-700 font-medium mb-2">Email address</label>
          <input
            id="email"
            type="email"
            v-model="form.email"
            placeholder="you@example.com"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autocomplete="email"
            :disabled="form.processing"
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
            placeholder="Your password"
            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500"
            required
            autocomplete="current-password"
            :disabled="form.processing"
          />
          <p v-if="form.errors.password" class="text-sm text-red-600 mt-1">{{ form.errors.password }}</p>
        </div>

        <!-- Remember me -->
        <div class="flex items-center mb-6">
          <input
            id="remember"
            type="checkbox"
            v-model="form.remember"
            class="mr-2 h-4 w-4 text-indigo-600 border-gray-300 rounded focus:ring-indigo-500"
            :disabled="form.processing"
          />
          <label for="remember" class="text-gray-700 select-none cursor-pointer">Remember me</label>
        </div>

        <!-- Actions: Cancel (link), Forgot password (link), Submit (button) -->
        <div class="flex items-center justify-between mb-4">
          
         

        
           <Link
           
           :href="route('product_view')"
            class="text-indigo-600 hover:underline font-semibold text-sm"
          >
            Cancel?
          </Link>

          <Link v-if="canResetPassword" :href="route('password.request')" class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                    Forgot your password?
                </Link>
        </div>

        <!-- Submit button -->
        <button
          type="submit"
          class="w-full py-3 bg-indigo-600 text-white font-semibold rounded-lg shadow-md hover:bg-indigo-700 transition duration-300 disabled:opacity-50 disabled:cursor-not-allowed"
          :disabled="form.processing"
        >
          <span v-if="form.processing">Logging in...</span>
          <span v-else>Log In</span>
        </button>
      </form>

      <p class="mt-6 text-center text-gray-600 text-sm">
        Don't have an account?
        <Link href="/register" class="text-indigo-600 hover:underline font-semibold">Sign up</Link>
      </p>
    </div>
  </div>
</template>
