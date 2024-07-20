module ViewComponentUI
  module HasColorScheme
    extend ActiveSupport::Concern

    included do
      prop :color_scheme, Types::Coercible::Symbol.optional.enum(*theme_color_scheme.keys.map(&:to_sym)),
             default: proc { ViewComponentUI.config.theme.color_scheme.keys.first }, reader: true
    end

    class_methods do
      def theme_color_scheme
        ViewComponentUI.config.theme.color_scheme
      end
    end

    def color_scheme
      initial_props[:color_scheme] || self.class._default_props[:color_scheme] || self.class.theme_color_scheme.keys.first
    end

    def color_scheme_token(weight)
      color = self.class.theme_color_scheme.fetch(color_scheme.to_s.to_sym)

      "#{color}-#{weight}"
    end
  end
end
