/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        yellow: '#F3CA47',
        blue: '#0055B6',
        gray: '#F0F0F0',
        black: '#202020'
      }
    }
  },
  plugins: [require('daisyui')]
}
