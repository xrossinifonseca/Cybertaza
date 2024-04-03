/** @type {import('tailwindcss').Config} */
export default {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx,vue}'],
  theme: {
    extend: {
      colors: {
        yellow: '#F3CA47',
        blue: '#0055B6',
        black: '#202020',
        'black-secondary': '#2d2d2d'
      }
    }
  },
  plugins: [require('daisyui')]
}
