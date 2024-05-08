require 'view_component_ui/compiler'

ViewComponentUI.configure do |config|
  config.compiler.on_compile = proc { system 'yarn build' }
end

ViewComponentUI::Engine.config.after_initialize do
  ViewComponentUI::Compiler::Runner.new.call
end
