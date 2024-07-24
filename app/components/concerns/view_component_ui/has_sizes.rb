module ViewComponentUI
  module HasSizes
    extend ActiveSupport::Concern

    included do
      class_attribute :sizes
      self.sizes = {}.with_indifferent_access

      prop :size, Types::Coercible::Symbol.optional
    end

    class_methods do
      def size(name, **props)
        sizes[name] = Props.new(props)
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
      base_props = super
      return base_props unless size_props

      base_props.merge(size_props.bind(self))
    end
  end
end
