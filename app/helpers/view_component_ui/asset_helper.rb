module ViewComponentUI
  module AssetHelper
    include ActionView::Helpers::AssetTagHelper

    extend self

    MANIFEST_PATH = Rails.root.join('public', 'assets', 'manifest.json')

    def vite_asset_path(name)
      manifest = JSON.parse(File.read(MANIFEST_PATH))
      File.join('/assets', manifest.dig(name, 'file'))
    end

    def view_component_ui_asset_tags
      safe_join [
        content_tag(:script, '', src: vite_asset_path('assets/main.ts')),
        content_tag(:link, '', rel: 'stylesheet', href: vite_asset_path('style.css'))
      ]
    end
  end
end
