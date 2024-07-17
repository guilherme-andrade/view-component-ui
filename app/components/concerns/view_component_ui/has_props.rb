module ViewComponentUI
  module HasProps
    extend ActiveSupport::Concern

    class_methods do
      def prop(name, *args)
        options = args.extract_options!
        alias_name = options.delete(:alias)

        if alias_name
          default_proc = proc { |default_method| proc { send(default_method) } }
          base_options = { default: default_proc.call(alias_name) }
          option(name, *args, **base_options.merge(options))
          option(alias_name, *args, **base_options.merge(options))
        else
          option(name, *args, **options)
        end
      end

      def default_props(**props)
        _default_props.merge!(props)
      end

      def _default_props
        @_default_props ||= {}
      end

      def inherited(base)
        super
        base.default_props(**_default_props)
      end
    end

    def initialize(**initial_props)
      @initial_props = initial_props

      super(**props)
    end

    delegate :_default_props, to: :class
    attr_reader :default_props, :initial_props

    def props
      @props ||= _default_props.merge(initial_props)
    end
  end
end
