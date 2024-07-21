module ViewComponentUI
  module HasProps
    extend ActiveSupport::Concern

    class_methods do
      def prop(*args)
        prop = PropDefinition.new(*args)
        prop.define_on(self)
        props.push(prop.name)
      end

      def default_props(props = {})
        @_default_props = _default_props.merge(Props.new(props.to_h))
      end

      def _default_props
        @_default_props ||= Props.new
      end

      def inherited(base)
        super
        base.default_props(_default_props)
        base.props.push(*props)
      end

      def props
        @props ||= []
      end
    end

    def initialize(...)
      super(...)
      @initial_props = Props.new(...)
    end

    attr_reader :initial_props

    def default_props
      self.class._default_props
    end

    def props
      default_props.merge(initial_props).merge(Props.overriden_in(self)).bind(self)
    end
  end
end
