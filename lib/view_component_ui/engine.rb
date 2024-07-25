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

    %w[layout forms feedback typography media_and_icons data_display navigation overlay other modal buttons misc].each do
      config.autoload_paths << root.join("app/components/#{_1}")
      preview_paths.each { |path| config.autoload_paths << path } if Rails.env.development?
    end

    config.after_initialize do
      require 'view_component_ui/types'
      require 'view_component_ui/javascript_attribute'
      require 'view_component_ui/style_attribute'
    end
  end
end
