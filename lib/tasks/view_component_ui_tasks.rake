# frozen_string_literal: true

namespace :view_component_ui do
  task compile: :environment do
    require 'view_component_ui/compiler'
    ViewComponentUI::Compiler::Runner.new.call
    loop do
    end
  end
end
