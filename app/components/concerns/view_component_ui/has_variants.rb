module ViewComponentUI
  module HasVariants
    extend ActiveSupport::Concern

    included do
      class_attribute :variants
      self.variants = []

      option :variant, Types::Coercible::Symbol.optional, default: proc { :default }
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
      variant_config.options(self).except(:class).merge(super)
    end

    def _class
      value = variant_config.options(self)
      style_classes = build_style_classes(**value)
      classes = value[:class].then do |cn|
        cn.is_a?(Proc) ? instance_eval(&cn) : cn
      end
      return super if value.blank? && style_classes.blank?

      [super, classes, style_classes].flatten.compact
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
