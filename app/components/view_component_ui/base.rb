module ViewComponentUI
  class Base < ViewComponent::Base
    extend Dry::Initializer

    class << self
      def prop(*args)
        options = args.extract_options!
        key = options[:required] ? args.first : :"#{args.first}?"
        defined_props[key] = args.last || Types::Any
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
        base.defined_props.merge!(defined_props)
      end

      def defined_props
        @defined_props ||= {}
      end

      def js(string)
        JavascriptCode.new(string)
      end

      def props_type
        Types::Hash.schema(defined_props).merge(Types::PropTypes)
      end
    end

    def initialize(...)
      @initial_props = Props.new(...)
      super
    end

    delegate :js, to: :class

    def call
      render_self do
        content
      end
    end

    def before_render
      PropsValidator.new(schema_type: self.class.props_type).call(props)
    end

    def render_self(&block)
      if props[:as].is_a?(ViewComponentUI::Base)
        render props[:as].new(**props.except(:as), &block)
      else
        content_tag(props.fetch(:as, :div), **html_attributes.to_h, &block)
      end
    end

    attr_reader :initial_props

    def default_props
      self.class._default_props
    end

    def html_attributes
      class_values = class_list.flatten.uniq.compact.join(' ')

      Types::HTML_PROPS.keys.index_with { props[_1] }
                            .merge(class: class_values, style: style_string)
                            .compact
                            .merge(javascript_attributes)
    end

    def style_string
      return unless props[:style]

      StyleAttribute::List.new(props[:style]).to_html_attributes[:style]
    end

    def props
      default_props.merge(initial_props).merge(Props.overriden_in(self)).bind(self)
    end

    def javascript_attributes
      JavascriptAttribute::List.new(props: props.slice(*Constants::JS_PROPS)).to_html_attributes
    end

    def class_list
      props[:class_list].to_s.split(/\s+/).concat(class_names(props)).compact
    end

    def class_names(...)
      Compiler::ClassListBuilder.new.call(...)
    end

    def string_class_names(props)
      class_names(props).join(' ')
    end
  end
end
