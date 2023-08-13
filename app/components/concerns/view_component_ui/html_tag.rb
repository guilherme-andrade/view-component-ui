module ViewComponentUI
  module HTMLTag
    extend ActiveSupport::Concern

    included do
      option :as, Types::Tag | Types.Instance(ViewComponentUI::Base), default: proc { :div }
      option :accesskey, Types::StringOrNil, default: proc {}
      option :class_name, Types::StringOrNil, default: proc {}
      option :contenteditable, Types::BoolOrNil, default: proc {}
      option :data, Types::HashOrNil, default: proc { {} }
      option :dir, Types::StringOrNil, default: proc {}
      option :draggable, Types::BoolOrNil, default: proc {}
      option :hidden, Types::BoolOrNil, default: proc {}
      option :id, Types::StringOrNil, default: proc {}
      option :lang, Types::StringOrNil, default: proc {}
      option :spellcheck, Types::BoolOrNil, default: proc {}
      option :style, Types::StringOrNil, default: proc {}
      option :tabindex, Types::StringOrNil, default: proc {}
      option :title, Types::StringOrNil, default: proc {}
      option :translate, Types::BoolOrNil, default: proc {}
      option :aria, Types::HashOrNil, default: proc { {} }
      option :role, Types::StringOrNil, default: proc {}
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

    def html_attributes
      HTML_ATTRIBUTES.index_with { options[_1] }.merge(class: class_name).compact
    end

    def options
      self.class.dry_initializer.definitions.keys.index_with { send(_1) }
    end

    def call
      return as.new(**options) if as.is_a?(ViewComponentUI::Base)

      super
    end
  end
end
