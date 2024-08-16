import { defineConfig } from 'vite'
import RubyPlugin from 'vite-plugin-ruby'

export default defineConfig({
  plugins: [
    RubyPlugin()
  ],
  resolve: {
    extensions: ['.ts', '.js'], // Ensure .ts files are resolved correctly
  },
  build: {
    minify: 'terser',
    terserOptions: {
      // turn off mangling to avoid minifying class names, which Catalyst relies on
      mangle: false,
      compress: true
    }
  }
})
