require 'dry-struct'
require 'tailwindcss/types'
require 'tailwindcss/style_attributes_to_list_converter'

module Tailwindcss
  class RootStyle < Dry::Struct
    Constants::THEME.each do |name, config|
      attribute? name, Types.Directive(name)
      attribute? config[:alias], Types.Directive(name) if config[:alias]
    end

    def to_a
      to_string_converter.call(@attributes)
    end

    def to_s
      to_a.join(' ')
    end

    def to_html_attribute
      { class: to_s }
    end

    private

    def to_string_converter
      @to_string_converter ||= StyleAttributesToListConverter.new(
        include_breakpoints: true,
        include_pseudo_selectors: true,
        include_pseudo_elements: true
      )
    end    
  end

  class PseudoElementStyle < RootStyle
    Tailwindcss.config.breakpoints.each do |breakpoint|
      attribute? :"_#{breakpoint}", RootStyle
    end
  end

  class PseudoSelectorStyle < PseudoElementStyle
    Tailwindcss.config.pseudo_elements.each do |pseudo_element|
      attribute? :"_#{pseudo_element}", PseudoElementStyle
    end
  end

  class Style < PseudoSelectorStyle
    Tailwindcss.config.pseudo_selectors.each do |pseudo_selector|
      attribute? :"_#{pseudo_selector}", PseudoSelectorStyle
    end

    module Helpers
      def tailwind(**style_attributes)
        Style.new(**style_attributes).to_s
      end
    end
  end
end
