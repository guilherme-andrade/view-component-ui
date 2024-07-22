module ViewComponentUI
  module HasHTMLCommonProps
    extend ActiveSupport::Concern

    def call
      return as.new(**props.except(:as)) if as.is_a?(ViewComponentUI::Base)

      super
    end

    def html_attributes
      class_values = class_list.flatten.uniq.compact.join(' ')

      Types::HTML_PROPS.keys.index_with { props[_1] }.merge(class: class_values, style: style_string).compact
    end

    def render_self(&block)
      content_tag(props[:as], **html_attributes.to_h, &block)
    end

    def style_string
      return unless props[:style]

      StyleAttribute::List.new(props[:style]).to_html_attributes[:style]
    end
  end
end
