module ViewComponentUI
  module HasColorScheme
    extend ActiveSupport::Concern

    included do
      class_attribute :_color_scheme
      self._color_scheme = nil

      option :color_scheme, Types::Coercible::Symbol.optional.enum(*theme_color_scheme.keys.map(&:to_sym)),
             default: proc { theme_color_scheme.keys.first }, reader: true
    end

    class_methods do
      def color_scheme(&block)
        self._color_scheme = block
      end

      def theme_color_scheme
        ViewComponentUI.config.theme.color_scheme
      end
    end

    def color_scheme_config
      self.class._color_scheme
    end

    def class_list
      return super unless color_scheme_config

      theme_class = instance_eval(&color_scheme_config)
      [super, theme_class].flatten.compact
    end

    def color_scheme_token(weight)
      color = self.class.theme_color_scheme.fetch(color_scheme.to_sym, color_scheme)

      "#{color}-#{weight}"
    end
  end
end
