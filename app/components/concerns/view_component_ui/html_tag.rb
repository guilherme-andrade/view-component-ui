module ViewComponentUI
  module HTMLTag
    extend ActiveSupport::Concern

    included do
      option :as, Types::Tag | Types.Instance(ViewComponentUI::Base), default: proc { :div }, reader: true
      option :accesskey, Types::StringOrNil, default: proc {}, reader: true
      option :class, Types::StringOrNil, default: proc {}, as: :_class, reader: true
      option :contenteditable, Types::BoolOrNil, default: proc {}, reader: true
      option :data, Types::HashOrNil, default: proc { {} }, reader: true
      option :dir, Types::StringOrNil, default: proc {}, reader: true
      option :draggable, Types::BoolOrNil, default: proc {}, reader: true
      option :hidden, Types::BoolOrNil, default: proc {}, reader: true
      option :id, Types::StringOrNil, default: proc {}, reader: true
      option :lang, Types::StringOrNil, default: proc {}, reader: true
      option :spellcheck, Types::BoolOrNil, default: proc {}, reader: true
      option :style, Types::HashOrNil, default: proc {}, reader: true
      option :tabindex, Types::StringOrNil, default: proc {}, reader: true
      option :title, Types::StringOrNil, default: proc {}, reader: true
      option :translate, Types::BoolOrNil, default: proc {}, reader: true
      option :aria, Types::HashOrNil, default: proc { {} }, reader: true
      option :role, Types::StringOrNil, default: proc {}, reader: true
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
      class_values = _class.flatten.uniq.compact.join(' ')
      HTML_ATTRIBUTES.index_with { options[_1] }.merge(class: class_values).compact
    end

    def options
      self.class.dry_initializer.attributes(self).except(:class).transform_keys do |key|
        %i[hover].include?(key.to_sym) ? :"_#{key}" : key
      end
    end

    def call
      return as.new(**options) if as.is_a?(ViewComponentUI::Base)

      super
    end

    def style
      super&.each_with_object('') do |(key, value), memo|
        memo << "#{key.to_s.dasherize}: #{value};"
      end
    end
  end
end
