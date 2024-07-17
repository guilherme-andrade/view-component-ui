module ViewComponentUI
  module HasHTMLCommonProps
    extend ActiveSupport::Concern

    included do
      prop :as, Types::Tag | Types.Instance(ViewComponentUI::Base), default: proc { :div }, reader: true
      prop :accesskey, Types::StringOrNil, default: proc {}, reader: true
      prop :class, Types::StringOrNil, default: proc {}, as: :class_list, reader: true
      prop :contenteditable, Types::BoolOrNil, default: proc {}, reader: true
      prop :data, Types::HashOrNil, default: proc { {} }, reader: true
      prop :dir, Types::StringOrNil, default: proc {}, reader: true
      prop :draggable, Types::BoolOrNil, default: proc {}, reader: true
      prop :hidden, Types::BoolOrNil, default: proc {}, reader: true
      prop :id, Types::StringOrNil, default: proc {}, reader: true
      prop :lang, Types::StringOrNil, default: proc {}, reader: true
      prop :spellcheck, Types::BoolOrNil, default: proc {}, reader: true
      prop :style, Types::HashOrNil, default: proc {}, reader: true
      prop :tabindex, Types::StringOrNil, default: proc {}, reader: true
      prop :title, Types::StringOrNil, default: proc {}, reader: true
      prop :translate, Types::BoolOrNil, default: proc {}, reader: true
      prop :aria, Types::HashOrNil, default: proc { {} }, reader: true
      prop :role, Types::StringOrNil, default: proc {}, reader: true
    end

    HTML_ATTRIBUTES = %i[
      accesskey
      contenteditable
      data
      dir
      draggable
      hidden
      id
      lang
      spellcheck
      style
      tabindex
      title
      translate
      aria
      role
    ].freeze

    def call
      return as.new(**props.except(:as)) if as.is_a?(ViewComponentUI::Base)

      super
    end

    def html_attributes
      class_values = class_list.flatten.uniq.compact.join(' ')

      HTML_ATTRIBUTES.index_with { send(_1) }.merge(class: class_values, style: style_string).compact
    end

    def render_self(&block)
      content_tag(as, **html_attributes, &block)
    end

    def style_string
      return unless style

      StyleAttribute::List.new(style).to_html_attributes[:style]
    end
  end
end
