require 'view_component_ui/compiler'

ViewComponentUI::Engine.config.after_initialize do
  ViewComponentUI::Compiler::Runner.new.call
end
