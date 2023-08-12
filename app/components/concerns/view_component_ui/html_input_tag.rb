module ViewComponentUI
  module HTMLInputTag
    extend ActiveSupport::Concern

    included do
      include HtmlTag

      option :name, Types::StringOrNil, default: proc {}
      option :value, Types::StringOrNil, default: proc {}
      option :type, Types::StringOrNil, default: proc { 'text' }
      option :disabled, Types::BoolOrNil, default: proc {}
      option :readonly, Types::BoolOrNil, default: proc {}
      option :autofocus, Types::BoolOrNil, default: proc {}
      option :required, Types::BoolOrNil, default: proc {}
      option :placeholder, Types::StringOrNil, default: proc {}
      option :maxlength, Types::IntOrNil, default: proc {}
      option :minlength, Types::IntOrNil, default: proc {}
      option :autocomplete, Types::StringOrNil, default: proc {}
      option :pattern, Types::StringOrNil, default: proc {}
      option :size, Types::IntOrNil, default: proc {}
      option :src, Types::StringOrNil, default: proc {}
      option :alt, Types::StringOrNil, default: proc {}
      option :step, Types::StringOrNil, default: proc {}
      option :min, Types::StringOrNil, default: proc {}
      option :max, Types::StringOrNil, default: proc {}
      option :list, Types::StringOrNil, default: proc {}
      option :multiple, Types::BoolOrNil, default: proc {}
      option :form, Types::StringOrNil, default: proc {}
    end
  end
end
