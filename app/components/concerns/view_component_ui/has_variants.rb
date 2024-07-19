module ViewComponentUI
  module HasVariants
    extend ActiveSupport::Concern

    included do
      class_attribute :variants
      self.variants = []

      prop :variant, Types::Coercible::Symbol.optional, default: proc { :default }
    end

    class_methods do
      def variant(name, **props)
        variants << Variant.new(name, props)
      end
    end

    def variant_config
      self.class.variants.find { _1.name == variant.to_s.to_sym } || variants.first
    end

    def html_attributes
      variant_config.props(self).slice(*HasHTMLCommonProps::HTML_ATTRIBUTES).merge(super)
    end

    def default_and_initial_props
      variant_config.props(self).deeper_merge(super)
    end

    class Variant
      extend Dry::Initializer

      param :name, reader: true
      param :props, default: proc { {} }

      def props(instance)
        @props.transform_values do |value|
          value.is_a?(Proc) ? instance.instance_eval(&value) : value
        end
      end
    end
  end
end
