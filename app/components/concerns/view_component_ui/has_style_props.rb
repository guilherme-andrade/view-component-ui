require 'view_component_ui/style_properties/schemas'

module ViewComponentUI
  module HasStyleProps
    extend ActiveSupport::Concern

    include ViewComponentUI::StyleProperties::Schemas

    class_methods do
      def inherited(base)
        super
        base.class_eval do
          add_style_props = -> {
            STYLE_PROPERTY_MAP.each do |name, config|
              prop name, **config, optional: true
            end
          }
    
          add_breakpoint_props = -> {
            ViewComponentUI.config.breakpoints.each do |bp|
              prop bp, Types::Hash, optional: true do
                add_style_props.call
              end
            end
          }
    
          add_pseudo_element_props = -> {
            ViewComponentUI.config.pseudo_elements.each do |pc|
              prop pc, Types::Hash, optional: true do
                add_style_props.call
                add_breakpoint_props.call
              end
            end
          }
    
          add_pseudo_class_props = -> {
            ViewComponentUI.config.pseudo_classes.each do |pc|
              prop pc, Types::Hash, optional: true do
                add_style_props.call
                add_breakpoint_props.call
                add_pseudo_element_props.call
              end
            end
          }
    
          add_style_props.call
          add_breakpoint_props.call
          add_pseudo_element_props.call
          add_pseudo_class_props.call
        end
      end

      def style_props
        aliases = STYLE_PROPERTY_MAP.values.map { _1[:alias] }.compact
        aliases + STYLE_PROPERTY_MAP.keys + ViewComponentUI.config.breakpoints + ViewComponentUI.config.pseudo_elements + ViewComponentUI.config.pseudo_classes
      end
    end

    def class_list
      super.to_s.split(/\s+/).concat(class_names(**style_props)).compact
    end

    def style_props
      props.slice(*self.class.style_props).compact
    end

    def class_names(**opts)
      compiled_options = compile_proc_options(**opts)
      class_builder.call(**compiled_options)
    end

    def compile_proc_options(**opts)
      opts.deep_transform_values { _1.respond_to?(:call) ? instance_eval(&_1) : _1 }
    end

    def class_builder
      @class_builder ||= Compiler::ClassListBuilder.new
    end
  end
end
