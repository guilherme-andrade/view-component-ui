module ViewComponentUI
  module HasSizes
    extend ActiveSupport::Concern

    included do
      class_attribute :sizes
      self.sizes = {}.with_indifferent_access

      prop :size, Types::Coercible::Symbol.optional, optional: true
    end

    class_methods do
      def size(name, **props)
        sizes[name] = Props.new(props)
      end
    end

    delegate :sizes, to: :class

    def size
      (super || self.class._default_props[:size]).tap do |size|
        raise ArgumentError, "#{self.class.name} is missing a default size" unless size
      end
    end

    def size_props
      sizes[size]
    end

    def html_attributes
      size_props.bind(self).slice(*HasHTMLCommonProps::HTML_ATTRIBUTES).merge(super).to_h
    end

    def default_props
      super.merge(size_props.bind(self))
    end
  end
end
