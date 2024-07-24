module ViewComponentUI
  module HasVariants
    extend ActiveSupport::Concern

    included do
      class_attribute :variants
      self.variants = {}.with_indifferent_access

      prop :variant, Types::Coercible::Symbol.optional
    end

    class_methods do
      def variant(name, **props)
        variants[name] = Props.new(props)
      end
    end

    delegate :variants, to: :class

    def variant
      (initial_props[:variant] || self.class.default_props[:variant])
    end

    def variant_props
      variants[variant]
    end

    def default_props
      base_props = super
      return base_props unless variant_props

      base_props.merge(variant_props.bind(self))
    end
  end
end
