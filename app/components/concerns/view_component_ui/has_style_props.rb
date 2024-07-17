require 'view_component_ui/style_properties/schemas'

module ViewComponentUI
  module HasStyleProps
    extend ActiveSupport::Concern

    include ViewComponentUI::StyleProperties::Schemas

    def class_list
      super.to_s.split(/\s+/).concat(class_names(**style_props)).compact
    end

    def style_props
      StylePropertySchema.call(props).to_h
    end

    def class_names(**opts)
      compiled_options = compile_proc_options(**opts)
      class_builder.call(**compiled_options)
    end

    def string_class_names(**opts)
      class_names(**opts).join(' ')
    end

    def compile_proc_options(**opts)
      opts.deep_transform_values { _1.respond_to?(:call) ? instance_eval(&_1) : _1 }
    end

    def class_builder
      @class_builder ||= Compiler::ClassListBuilder.new
    end
  end
end
