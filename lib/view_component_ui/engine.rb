# frozen_string_literal: true

require 'view_component'
require 'lookbook'
require 'dry/initializer'
require 'dry/types'

module ViewComponentUI
  class Engine < ::Rails::Engine
    isolate_namespace ViewComponentUI

    def self.preview_paths
      [root.join('spec/components/previews')]
    end

    Dir[root.join('spec/components/previews/**/*_preview.rb')].each do |file|
      require file
    end

    Dir[root.join('app/types/**/*.rb')].each do |file|
      require file
    end

    Dir[root.join('app/components/**/*.rb')].each do |file|
      require file
    end

    config.eager_load_paths += Dir[root.join('spec/components/previews/**/*_preview.rb')]
    config.eager_load_paths += Dir[root.join('app/components/**/*_component.rb')]

    config.before_initialize do
      config.view_component.preview_paths = ViewComponentUI::Engine.preview_paths
      config.lookbook.project_name = 'ViewComponentUI'
    end

    initializer 'view_component_ui' do |app|
      app.config.assets.paths << Engine.root.join('assets/compiled')
    end
  end
end
