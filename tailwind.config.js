/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./tmp/view_component_ui/compiler/**/*",
    "./app/components/**/*.rb",
    "./app/components/**/*.html.erb"
  ],
  prefix: 'tw-',
  plugins: [],
}
