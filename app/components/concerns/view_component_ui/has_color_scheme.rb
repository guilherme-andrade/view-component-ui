module ViewComponentUI
  module HasColorScheme
    extend ActiveSupport::Concern

    COLOR_SCHEME = {
      primary: :purple,
      secondary: :indigo,
      success: :emerald,
      danger: :rose,
      warning: :yellow,
      info: :teal,
      gray: :gray
    }.with_indifferent_access.freeze

    included do
      class_attribute :_color_scheme
      self._color_scheme = nil

      option :color_scheme, Types::Coercible::Symbol.optional, default: proc { :primary }
    end

    class_methods do
      def color_scheme(&block)
        self._color_scheme = block
      end
    end

    def color_scheme_config
      self.class._color_scheme
    end

    def class_name
      return super unless color_scheme_config

      theme_class_name = instance_eval(&color_scheme_config)
      "#{super} #{theme_class_name}"
    end

    def color_scheme_token(weight)
      color = COLOR_SCHEME.fetch(color_scheme.to_sym, color_scheme)

      "#{color}-#{weight}"
    end
  end
end
