module ViewComponentUI
  module HasProps
    extend ActiveSupport::Concern

    class_methods do
      def prop(*args)
        Props.attribute *args
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
      end
    end

    def initialize(...)
      @initial_props = Props.new(...)
      super
    end

    def before_render
      props.validate!
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
