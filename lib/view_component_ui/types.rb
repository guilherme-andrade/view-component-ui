require 'dry-types'

module ViewComponentUI
  module Types
    include Dry.Types()
    include Constants

    StringOrNil = Coercible::String.optional
    IntOrNil = Coercible::Integer.optional
    BoolOrNil = Strict::Bool.optional
    HashOrNil = Strict::Hash.optional

    Tag = Coercible::Symbol.default(:div).enum(*HTML_TAGS)

    Component = Instance(ViewComponent::Base)

    PropValue = Types::Interface(:call) | Types::Any

    module OfStyleType
      def of_type(type)
        constructor do |value|
          values = Constants::STYLE_PROP_MAP[type].fetch(:values, [])
          values = values.call if values.respond_to?(:call)
          next value if value.nil? || value.respond_to?(:call) || values.any? { _1.to_s.dasherize == value.to_s.dasherize }

          raise ArgumentError, "#{value.inspect} must be one of #{values.join(', ')}"
        end
      end
    end

    StyleProp = PropValue.dup.extend(OfStyleType)

    HTML_PROPS = {
      as: (Types::Tag | Types.Instance(ViewComponent::Base)),
      accesskey: Types::StringOrNil,
      class: Types::StringOrNil,
      contenteditable: Types::BoolOrNil,
      data: Types::HashOrNil,
      dir: Types::StringOrNil,
      draggable: Types::BoolOrNil,
      hidden: Types::BoolOrNil,
      id: Types::StringOrNil,
      lang: Types::StringOrNil,
      spellcheck: Types::BoolOrNil,
      style: Types::HashOrNil,
      tabindex: Types::StringOrNil,
      title: Types::StringOrNil,
      translate: Types::BoolOrNil,
      aria: Types::HashOrNil,
      role: Types::StringOrNil,
      name: Types::StringOrNil,
      value: Types::StringOrNil,
      type: Types::StringOrNil,
      disabled: Types::BoolOrNil,
      readonly: Types::BoolOrNil,
      autofocus: Types::BoolOrNil,
      required: Types::BoolOrNil,
      placeholder: Types::StringOrNil,
      maxlength: Types::IntOrNil,
      minlength: Types::IntOrNil,
      autocomplete: Types::StringOrNil,
      pattern: Types::StringOrNil,
      _size: Types::IntOrNil,
      src: Types::StringOrNil,
      alt: Types::StringOrNil,
      step: Types::StringOrNil,
      min: Types::StringOrNil,
      max: Types::StringOrNil,
      list: Types::StringOrNil,
      multiple: Types::BoolOrNil,
      form: Types::StringOrNil,
    }

    PROPS = HTML_PROPS.merge(
      STYLE_PROP_MAP.map { |key, value| [key, Types::StyleProp.of_type(key)] }.to_h
    ).merge(
      JS_PROPS.map { |key| [key, Types::PropValue] }.to_h
    )

    BasePropTypes = Types::Hash.schema(PROPS.transform_keys { :"#{_1}?" })

    BREAKPOINT_PROPS = ViewComponentUI.config.breakpoints.each_with_object({}) do |bp, hash|
      hash[:"_#{bp}?"] = BasePropTypes
    end

    BreakpointPropTypes = Types::Hash.schema(BREAKPOINT_PROPS)

    PSEUDO_ELEMENT_PROPS = ViewComponentUI.config.pseudo_elements.each_with_object({}) do |pe, hash|
      hash[:"_#{pe}?"] = BreakpointPropTypes.merge(BasePropTypes)
    end

    PseudoElementPropTypes = Types::Hash.schema(PSEUDO_ELEMENT_PROPS)

    PSEUDO_CLASS_PROPS = ViewComponentUI.config.pseudo_classes.each_with_object({}) do |pc, hash|
      hash[:"_#{pc}?"] = PseudoElementPropTypes.merge(BreakpointPropTypes).merge(BasePropTypes)
    end

    PseudoClassPropTypes = Types::Hash.schema(PSEUDO_CLASS_PROPS)

    ALL_PROPS = PROPS.merge(BREAKPOINT_PROPS).merge(PSEUDO_ELEMENT_PROPS).merge(PSEUDO_CLASS_PROPS)

    PropTypes = Types::Hash.schema(ALL_PROPS.transform_keys { _1.to_s.end_with?('?') ? _1 : :"#{_1}?" })
  end
end
