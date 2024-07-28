# frozen_string_literal: true

require 'dry/configurable'
require 'deep_merge/rails_compat'

require 'tailwindcss'

require 'view_component_ui/version'
require 'view_component_ui/engine'
require 'view_component_ui/constants'
require 'view_component_ui/props'
require 'view_component_ui/javascript_code'
require 'view_component_ui/props_validator'

module ViewComponentUI
  extend Dry::Configurable

  include Constants

  setting :output_path, default: proc { Engine.root.join('tmp/view_component_ui/compiler') }

  setting :content, default: proc {
                               [
                                 Rails.root.join('app/components'),
                                 Rails.root.join('app/views'),
                                 Engine.root.join('app/components'),
                                 Engine.root.join('app/views')
                               ]
                             }

  setting :package_json_path, default: proc { Rails.root.join('package.json') }
  setting :vite do
    setting :config_file_path, default: proc { Rails.root.join('vite.config.js') }
  end
end

