module ViewComponentUI
  module HasSizes
    extend ActiveSupport::Concern

    included do
      class_attribute :sizes
      self.sizes = []

      prop :size, Types::Coercible::Symbol.optional, default: proc { :md }
    end

    class_methods do
      def size(name, **props)
        sizes << Size.new(name, props)
      end
    end

    def size_config
      self.class.sizes.find { _1.name == size.to_sym } || sizes.first
    end

    def html_attributes
      size_config.props(self).slice(*HasHTMLCommonProps::HTML_ATTRIBUTES).merge(super)
    end

    def class_list
      value = size_config.props(self)
      style_classes = class_names(**value)
      classes = value[:class].then do |cn|
        cn.is_a?(Proc) ? instance_eval(&cn) : cn
      end
      return super if value.blank? && style_classes.blank?

      [super, classes, style_classes].flatten.compact
    end

    class Size
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
