// vite.config.js
import { defineConfig } from "vite";

export default defineConfig({
  build: {
    minify: false,
    lib: {
      entry: "/Users/guilherme-andrade/code/guilherme-andrade/projects/view-component-ui/assets/main.ts",
      name: "ViewComponentUI",
      fileName: "view-component-ui",
    },
    rollupOptions: {
      external: ["@hotwired/stimulus"],
      output: {
        assetFileNames: (assetInfo) => {
          if (assetInfo.name === 'style.css') return 'view-component-ui.css';

          return assetInfo.name;
        },
      },
    },
    outDir: "/Users/guilherme-andrade/code/guilherme-andrade/projects/view-component-ui/spec/dummy/public/assets",
    manifest: true
  },
});
