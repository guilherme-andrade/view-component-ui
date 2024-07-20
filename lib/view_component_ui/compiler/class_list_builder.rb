require 'view_component_ui/style_properties/schemas'

module ViewComponentUI
  module Compiler
    class ClassListBuilder
      extend Dry::Initializer

      option :include_breakpoints, default: proc { true }, reader: true
      option :include_pseudo_classes, default: proc { true }, reader: true
      option :include_pseudo_elements, default: proc { true }, reader: true

      delegate :pseudo_classes, :pseudo_elements, :breakpoints, to: :config, prefix: :config

      def call(props)
        props = props.to_h
        classes = []

        classes << build_style_prop_classes(props)

        classes << build_breakpoint_classes(props) if include_breakpoints
        classes << build_pseudo_classes_classes(props) if include_pseudo_classes
        classes << build_pseudo_elements_classes(props) if include_pseudo_elements

        classes.flatten
      end

      private

      def build_style_prop_classes(props)
        style_prop_props(props).each_with_object([]) do |(style_prop, value), memo|
          token = find_property_config(style_prop)[:token]
          classes = build_token(token, value)

          memo << classes
        end
      end

      def build_breakpoint_classes(props)
        builder = ClassListBuilder.new(include_breakpoints: false)

        breakpoint_props(props).each_with_object([]) do |(bp, bp_props), memo|
          classes = builder.call(**bp_props)

          memo << classes.map { "#{bp}:#{_1}" }
        end
      end

      def build_pseudo_classes_classes(props)
        builder = ClassListBuilder.new(include_pseudo_classes: false, include_breakpoints: false)

        pseudo_classes_props(props).each_with_object([]) do |(pc, pc_props), memo|
          classes = builder.call(**pc_props.to_h.symbolize_keys)
          memo << classes.map { "#{pc[1..]}:#{_1}" }
        end
      end

      def build_pseudo_elements_classes(props)
        builder = ClassListBuilder.new(include_pseudo_classes: false, include_pseudo_elements: false,
                                       include_breakpoints: false)

        pseudo_elements_props(props).each_with_object([]) do |(pe, pe_props), memo|
          classes = builder.call(**pe_props.to_h.symbolize_keys)

          memo << classes.map { "#{pe[1..]}:#{_1}" }
        end
      end

      def pseudo_classes_props(props)
        pseudo_class_utilities = config_pseudo_classes.map { :"_#{_1}" }
        props.slice(*pseudo_class_utilities)
      end

      def pseudo_elements_props(props)
        pseudo_element_utilities = config_pseudo_elements.map { :"_#{_1}" }
        props.slice(*pseudo_element_utilities)
      end

      def breakpoint_props(props)
        props.slice(*config_breakpoints)
      end

      def style_prop_props(props)
        all_keys = config_style_prop_properties.keys.map do |prop_key|
          [prop_key, config_style_prop_properties[prop_key][:alias]].compact
        end.flatten

        props.slice(*all_keys)
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
        in [String, Integer]
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
        ViewComponentUI.config
      end

      def config_style_prop_properties
        StyleProperties::Schemas::STYLE_PROPERTY_MAP
      end

      def find_property_config(name_or_alias)
        config_style_prop_properties.find do |key, value|
          key == name_or_alias || value[:alias] == name_or_alias
        end.last
      end
    end
  end
end
