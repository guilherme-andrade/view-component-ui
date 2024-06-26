# frozen_string_literal: true

require 'view_component'
require 'lookbook'
require 'dry/initializer'
require 'dry/types'

module ViewComponentUI
  class Engine < ::Rails::Engine
    isolate_namespace ViewComponentUI

    def self.preview_paths
      [root.join('spec/components/previews').to_s]
    end

    initializer 'view_component_ui' do |app|
      app.config.assets.paths << Engine.root.join('assets/compiled')
    end

    %w[layout forms feedback typography media_and_icons data_display navigation overlay other modal].each do
      config.autoload_paths << root.join("app/components/#{_1}")
    end

    config.after_initialize do
      require 'view_component_ui/style_properties/schemas'
    end
  end
end
