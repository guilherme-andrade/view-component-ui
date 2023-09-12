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

    config.autoload_paths << root.join('app/components/layout')
    config.autoload_paths << root.join('app/components/forms')
    config.autoload_paths << root.join('app/components/feedback')
    config.autoload_paths << root.join('app/components/typography')
    config.autoload_paths << root.join('app/components/media_and_icons')
    config.autoload_paths << root.join('app/components/data_display')
    config.autoload_paths << root.join('app/components/navigation')
    config.autoload_paths << root.join('app/components/overlay')
    config.autoload_paths << root.join('app/components/other')

    config.after_initialize do
      require 'view_component_ui/style_properties/schemas'
    end
  end
end
