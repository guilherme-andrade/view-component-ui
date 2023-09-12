require 'view_component_ui/style_properties/schemas'

module ViewComponentUI
  module CSSOptions
    extend ActiveSupport::Concern

    include ViewComponentUI::StyleProperties::Schemas

    class InvalidOptionError < StandardError
      def initialize(name, value, options)
        super("Invalid option value #{name}: #{value}.\n\nValid options are: #{options.join(', ')}")
      end
    end

    class_methods do
      def defaults(**values)
        @default_props = values
      end

      def default_props
        @default_props ||= {}
      end

      def inherited(base)
        super
        base.defaults(**default_props)
      end
    end

    def initialize(**props)
      @default_props = self.class.default_props
      @style_props = StylePropertySchema.call(default_props.merge(props)).to_h
      @props = default_props.merge(props.merge(style_props))

      super(**@props)
    end

    attr_reader :props, :default_props, :style_props

    def _class
      super.to_s.split(/\s+/).concat(build_style_classes(**style_options)).compact
    end

    def style_options
      StylePropertySchema.call(props).to_h
    end

    def build_style_classes(**opts)
      class_builder = ClassListBuilder.new
      class_builder.call(**opts)
    end
  end
end
