require 'dry-struct'
require 'view_component_ui/types'

module ViewComponentUI
  class StyleAttribute < Dry::Struct
    attribute :name, Types::Coercible::String
    attribute :value, Types::Coercible::String

    def to_html_attribute
      {style: "#{html_name}: #{value};" }
    end

    def html_name
      name.to_s.dasherize
    end

    class List
      def initialize(attributes)
        @attributes = attributes.map { |name, value| StyleAttribute.new(name:, value:) }
      end

      def to_html_attributes
        values = @attributes.map { _1.to_html_attribute[:style] }.join(' ')

        { style: values }
      end
    end
  end
end
