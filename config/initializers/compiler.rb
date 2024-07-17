require 'view_component_ui/compiler'

ViewComponentUI::Engine.config.after_initialize do
  thread = Thread.new do
    ViewComponentUI::Compiler::Runner.new.call
  end

  thread.join
end
