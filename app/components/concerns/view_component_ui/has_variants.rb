module ViewComponentUI
  module HasVariants
    extend ActiveSupport::Concern

    included do
      class_attribute :variants
      self.variants = {}.with_indifferent_access

      prop :variant, Types::Coercible::Symbol.optional, optional: true
    end

    class_methods do
      def variant(name, **props)
        variants[name] = Props.new(props)
      end
    end

    delegate :variants, to: :class

    def variant
      (super || self.class.default_props[:variant]).tap do |variant|
        raise ArgumentError, "#{self.class.name} is missing a default variant" unless variant
      end
    end

    def variant_props
      variants[variant]
    end

    def html_attributese
      variant_props.bind(self).slice(*HasHTMLCommonProps::HTML_ATTRIBUTES).merge(super).to_h
    end

    def default_props
      super.merge(variant_props.bind(self))
    end
  end
end
