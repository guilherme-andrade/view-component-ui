module Tailwindcss
  class StyleAttributesToListConverter
    extend Dry::Initializer

    option :include_breakpoints, default: proc { true }, reader: true
    option :include_pseudo_selectors, default: proc { true }, reader: true
    option :include_pseudo_elements, default: proc { true }, reader: true

    delegate :pseudo_selectors, :pseudo_elements, :breakpoints, to: :config, prefix: :config

    def call(style)
      style = style.to_h
      classes = []

      classes << build_style_prop_classes(style)

      classes << build_breakpoint_classes(style) if include_breakpoints
      classes << build_pseudo_selectors_classes(style) if include_pseudo_selectors
      classes << build_pseudo_elements_classes(style) if include_pseudo_elements

      classes.flatten
    end

    private

    def build_style_prop_classes(style)
      style_prop_style(style).each_with_object([]) do |(style_prop, value), memo|
        token = find_property_config(style_prop)[:token]
        classes = build_token(token, value)

        memo << classes
      end
    end

    def build_breakpoint_classes(style)
      builder = StyleAttributesToListConverter.new(include_breakpoints: false)

      breakpoint_style(style).each_with_object([]) do |(bp, bp_style), memo|
        classes = builder.call(**bp_style)

        memo << classes.map { "#{bp[1..].to_s.dasherize}:#{_1}" }
      end
    end

    def build_pseudo_selectors_classes(style)
      builder = StyleAttributesToListConverter.new(include_pseudo_selectors: false, include_breakpoints: false)

      pseudo_selectors_style(style).each_with_object([]) do |(pc, pc_style), memo|
        classes = builder.call(**pc_style.to_h.symbolize_keys)
        memo << classes.map { "#{pc[1..].to_s.dasherize}:#{_1}" }
      end
    end

    def build_pseudo_elements_classes(style)
      builder = StyleAttributesToListConverter.new(include_pseudo_selectors: false, include_pseudo_elements: false,
                                      include_breakpoints: false)

      pseudo_elements_style(style).each_with_object([]) do |(pe, pe_style), memo|
        classes = builder.call(**pe_style.to_h.symbolize_keys)

        memo << classes.map { "#{pe[1..].to_s.dasherize}:#{_1}" }
      end
    end

    def pseudo_selectors_style(style)
      pseudo_class_utilities = config_pseudo_selectors.map { :"_#{_1}" }
      style.slice(*pseudo_class_utilities)
    end

    def pseudo_elements_style(style)
      pseudo_element_utilities = config_pseudo_elements.map { :"_#{_1}" }
      style.slice(*pseudo_element_utilities)
    end

    def breakpoint_style(style)
      breakpoint_style_properties = config_breakpoints.map { :"_#{_1}" }
      style.slice(*breakpoint_style_properties)
    end

    def style_prop_style(style)
      all_keys = theme.keys.map do |prop_key|
        [prop_key, theme[prop_key][:alias]].compact
      end.flatten

      style.slice(*all_keys)
    end

    def build_token(token, value)
      html_class = html_class(token, value)
      "tw-#{html_class}" unless html_class.nil?
    end

    def html_class(token, value)
      case [token, value]
      in [String, TrueClass | 'true']
        token
      in [String, String | Symbol]
        "#{token}-#{value.to_s.dasherize}"
      in [String, Integer | Float | Decimal]
        "#{token}-#{value}"
      in [Proc, _]
        token.call(value)
      in [NilClass, _]
        value.to_s.dasherize
      else
        nil
      end
    end

    def config
      Tailwindcss.config
    end

    def theme
      Constants::THEME
    end

    def find_property_config(name_or_alias)
      theme.find do |key, value|
        key == name_or_alias || value[:alias] == name_or_alias
      end.last
    end
  end
end
