require 'view_component_ui/style_properties/schemas'

module ViewComponentUI
  module HasStyleProps
    extend ActiveSupport::Concern

    include ViewComponentUI::StyleProperties::Schemas

    attr_reader :style_props

    def class_list
      super.to_s.split(/\s+/).concat(build_style_classes(**style_props)).compact
    end

    def style_props
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
