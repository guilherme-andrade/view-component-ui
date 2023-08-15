module ViewComponentUI
  module HasSizes
    extend ActiveSupport::Concern

    included do
      class_attribute :sizes
      self.sizes = []

      option :size, Types::Coercible::Symbol.optional, default: proc { :md }
    end

    class_methods do
      def size(name, **options)
        sizes << Size.new(name, options)
      end
    end

    def size_config
      self.class.sizes.find { _1.name == size.to_sym } || sizes.first
    end

    def html_attributes
      size_config.options(self).except(:class).merge(super)
    end

    def _class
      value = size_config.options(self)
      style_classes = build_style_classes(**value)
      classes = value[:class].then do |cn|
        cn.is_a?(Proc) ? instance_eval(&cn) : cn
      end
      return super if value.blank? && style_classes.blank?

      [super, classes, style_classes].flatten.compact
    end

    class Size
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
