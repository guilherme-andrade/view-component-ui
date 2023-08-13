/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./assets/**/*.{js,ts,jsx,tsx}",
    "./app/components/**/*.rb",
    "./app/components/**/*.html.erb"
  ],
  plugins: [],
  safelist: [
    {
      pattern: /./,
    },
    {
      pattern: /(bg|text|border)-(red|green|blue|yellow|gray|indigo|purple|pink)-[0-9]{3}/,
      variants: ['active', 'disabled', 'checked', 'hover', 'focus', 'visited']
    }
  ]
}
