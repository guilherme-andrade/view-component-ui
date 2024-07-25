module ViewComponentUI
  module HasVariants
    extend ActiveSupport::Concern

    included do
      class_attribute :inherit_variants, default: true

      prop :variant, Types::Coercible::Symbol.optional
    end

    class_methods do
      def variants
        @variants ||= begin
          if inherit_variants && superclass.respond_to?(:variants)
            superclass.variants.merge(local_variants)
          else
            local_variants
          end
        end
      end

      def local_variants
        @local_variants ||= {}.with_indifferent_access
      end

      def variant(name, **props)
        local_variants[name] = Props.new(props)
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
      @default_props ||= begin
        base_props = super
        return base_props unless variant_props

        base_props.merge(variant_props.bind(self))
      end
    end
  end
end
