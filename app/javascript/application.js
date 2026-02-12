// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// Vue 3
import { createApp } from 'vue'
import App from './app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = createApp(App)
  app.mount('#app')
})