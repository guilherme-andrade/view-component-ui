module ViewComponentUI
  module HasProps
    extend ActiveSupport::Concern

    class_methods do
      def prop(*args)
        prop = PropDefinition.new(*args)
        props.push(prop.name)
        prop.define_on(self)
      end

      def default_props(**props)
        _default_props.merge!(props)
      end

      def _default_props
        @_default_props ||= Props.new
      end

      def inherited(base)
        super
        base.default_props(**_default_props)
        base.props.push(*props)
      end

      def props
        @props ||= []
      end
    end

    def initialize(**initial_props)
      @initial_props = Props.new(initial_props)

      super(**default_and_initial_props)
    end

    attr_reader :initial_props

    def default_props
      @default_props ||= self.class._default_props
    end

    def default_and_initial_props
      @default_and_initial_props ||= default_props.merge(initial_props)
    end

    def props
      @props ||= default_and_initial_props.merge(method_override_props)
    end

    def method_override_props
      @method_override_props ||= Props.defined_in(self)
    end
  end
end
