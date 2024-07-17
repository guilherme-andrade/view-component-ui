require 'dry-struct'

module ViewComponentUI
  class JavascriptAttribute < Dry::Struct
    SUB_PROPERTY_MAP = {
      x_transition: %i[enter leave enter_start enter_end leave_start leave_end],
      x_on: :all,
      x_bind: :all,
    }.freeze

    ALL = %i[x_data x_init x_show x_bind x_on x_text x_html x_model x_modelable x_for x_transition
             x_effect x_ignore x_ref x_cloak x_teleport x_if x_id on_click on_focus].freeze

    attribute :component, Types::Component
    attribute :name, Types::Coercible::Symbol
    attribute :value, Types::PropValue

    def to_html_attribute
      return { html_name => html_value } unless value.is_a?(Hash)

      value.reduce({}) do |acc, (k, v)|
        property_name = sub_property_name(k)
        acc.merge(JavascriptAttribute.new(name: property_name, value: v, component:).to_html_attribute)
      end
    end

    def html_name
      return name.to_s.gsub('on_', '@').dasherize if name.to_s.start_with?('on')

      name.to_s.dasherize
    end

    def sub_property_name(sub_property)
      return "#{name}:#{sub_property}" if is_namespace_subproperty?(sub_property)

      "#{name}.#{sub_property}"
    end

    def is_namespace_subproperty?(sub_property)
      SUB_PROPERTY_MAP[name].is_a?(Array) && SUB_PROPERTY_MAP[name].include?(sub_property) || SUB_PROPERTY_MAP[name] == :all
    end

    def html_value
      case value
      when NilClass, "", TrueClass
        nil
      when Integer, Float
        value
      when String, Symbol
        value.to_s
      when proc { _1.respond_to?(:call) }
        val = value
        val = component.instance_exec(&val) while val.respond_to?(:call)
        val.to_s
      else
        value
      end
    end

    class List < Dry::Struct
      attribute :component, Types::Instance(ViewComponent::Base)
      attribute :values, Types::Hash

      def to_html_attributes
        vals = values.map { |name, value| JavascriptAttribute.new(component:, name: name, value: value) }
        vals.map(&:to_html_attribute).reduce({}, :merge)
      end
    end
  end
end
