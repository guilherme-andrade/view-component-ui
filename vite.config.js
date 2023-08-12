// vite.config.js
import { resolve } from "path";
import { defineConfig } from "vite";

export default defineConfig({
  build: {
    lib: {
      entry: resolve(__dirname, "assets/main.ts"),
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
    outDir: "assets/compiled",
  },
});
