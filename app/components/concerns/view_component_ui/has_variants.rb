module ViewComponentUI
  module HasVariants
    extend ActiveSupport::Concern

    included do
      class_attribute :variants
      self.variants = []

      prop :variant, Types::Coercible::Symbol.optional, default: proc { :default }
    end

    class_methods do
      def variant(name, **options)
        variants << Variant.new(name, options)
      end
    end

    def variant_config
      self.class.variants.find { _1.name == variant.to_sym } || variants.first
    end

    def html_attributes
      size_config.options(self).slice(*HasHTMLCommonProps::HTML_ATTRIBUTES).merge(super)
    end

    def style_options
      variant_config.options(self).deeper_merge(super)
    end

    class Variant
      extend Dry::Initializer

      param :name, reader: true
      param :options, default: proc { {} }

      def options(instance)
        @options.transform_values do |value|
          value.is_a?(Proc) ? instance.instance_eval(&value) : value
        end
      end
    end
  end
end
