import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [
    RubyPlugin()
  ],
  resolve: {
    extensions: ['.ts', '.js'], // Ensure .ts files are resolved correctly
  },
})
