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
        default_props.merge!(values)
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
      @initial_props = props
      @default_props = self.class.default_props
      @style_props = StylePropertySchema.call(default_props.merge(props)).to_h
      @props = default_props.merge(props.merge(style_props))

      super(**@props)
      add_dynamic_style_properties
    end

    attr_reader :props, :default_props, :style_props, :initial_props

    def as_tag(&block)
      content_tag(as, **html_attributes, &block)
    end

    def add_dynamic_style_properties
      STYLE_PROPERTY_MAP.keys.each do |key|
        next unless respond_to?(key, true) && !props.key?(key)

        value = send(key)
        props[key] = value if value
      end
    end

    def class_list
      super.to_s.split(/\s+/).concat(build_style_classes(**style_options)).compact
    end

    def style_options
      StylePropertySchema.call(props).to_h
    end

    def build_style_classes(**opts)
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
