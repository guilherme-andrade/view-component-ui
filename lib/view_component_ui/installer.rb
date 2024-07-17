module ViewComponentUI
  class Installer
    def call
      generate_vite_config_file
      generate_tailwind_config_file
      add_vite_package_to_package_json unless package_json["devDependencies"]["vite"]
      add_vite_scripts_to_package_json unless package_json["scripts"]["build:view-component-ui"]
      save_package_json
    end

    private

    def generate_vite_config_file
      File.open(ViewComponentUI.config.vite.config_file_path.call, 'w') do |file|
        file.write(vite_config_file_content)
      end
    end

    def generate_tailwind_config_file
      File.open(File.join(File.dirname(package_json_path), 'tailwind.config.js'), 'w') do |file|
        file.write(tailwind_config_file_content)
      end
    end

    def add_vite_package_to_package_json
      package_json["devDependencies"].merge!(vite_package_config)
    end

    def add_vite_scripts_to_package_json
      package_json["scripts"].merge!(vite_scripts)
    end

    def save_package_json
      File.open(package_json_path, 'w') do |file|
        file.write(JSON.pretty_generate(package_json))
      end
    end

    def package_json
      @package_json ||= JSON.parse(File.read(package_json_path))
    end

    def vite_package_config
      { "vite": "^4.4.5" }
    end

    def vite_scripts
      { "build:view-component-ui": "vite build --config #{vite_config_file_path}" }
    end

    def package_json_path
      value = ViewComponentUI.config.package_json_path
      return value unless value.respond_to?(:call)

      value.call
    end

    def vite_config_file_path
      value = ViewComponentUI.config.vite.config_file_path
      return value unless value.respond_to?(:call)

      value.call
    end

    def content
      value = ViewComponentUI.config.content
      return value unless value.respond_to?(:call)

      value.call
    end

    def output_path
      value = ViewComponentUI.config.output_path
      return value unless value.respond_to?(:call)

      value.call
    end

    def tailwind_config_file_content
      content_option = (content + [output_path]).map { "#{_1}/**/*" }
      <<~TAILWIND_CONFIG
      /** @type {import('tailwindcss').Config} */
      export default {
        content: #{content_option.to_json},
        prefix: 'tw-',
        plugins: [],
      }
      TAILWIND_CONFIG
    end

    def vite_config_file_content
      <<~VITE_CONFIG
      // vite.config.js
      import { defineConfig } from "vite";

      export default defineConfig({
        build: {
          lib: {
            entry: "#{Engine.root.join('assets', 'main.ts')}",
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
          outDir: "#{Rails.root.join('public', 'assets')}",
          manifest: true
        },
      });
      VITE_CONFIG
    end
  end
end
