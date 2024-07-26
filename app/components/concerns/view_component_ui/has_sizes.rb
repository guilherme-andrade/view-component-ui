module ViewComponentUI
  module HasSizes
    extend ActiveSupport::Concern

    included do
      class_attribute :inherit_sizes, default: true

      prop :size, Types::Coercible::Symbol.optional
    end

    class_methods do
      def sizes
        @sizes ||= begin
          if inherit_sizes && superclass.respond_to?(:sizes)
            superclass.sizes.merge(local_sizes)
          else
            local_sizes
          end
        end
      end

      def local_sizes
        @local_sizes ||= {}.with_indifferent_access
      end

      def size(name, **props)
        local_sizes[name] = Props.new(props)
      end
    end

    delegate :sizes, to: :class

    def size
      (initial_props[:size] || self.class._default_props[:size])
    end

    def size_props
      sizes[size]
    end

    def default_props
      @default_props ||= begin
        base_props = super
        return base_props unless size_props

        base_props.merge(size_props)
      end
    end
  end
end
