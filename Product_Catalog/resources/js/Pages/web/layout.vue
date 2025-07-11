<script setup>
import Navigation from '@/Pages/web/navigation.vue'
import Footer from '@/Pages/web/footer.vue'



</script>



<template>
  <div>

    <Navigation />
    <main class="min-h-screen">

    
      <slot />
    </main>

    <Footer />
  </div>
</template>