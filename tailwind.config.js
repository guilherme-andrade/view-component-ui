/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./assets/**/*.{js,ts,jsx,tsx}",
    "./app/components/**/*.rb",
    "./app/components/**/*.html.erb"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
  safelist: [
    {
      pattern: /./,
    },
  ]
}
