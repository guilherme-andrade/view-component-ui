module ViewComponentUI
  module HasHTMLInputProps
    extend ActiveSupport::Concern

    included do
      prop :name, Types::StringOrNil, default: proc {}
      prop :value, Types::StringOrNil, default: proc {}
      prop :type, Types::StringOrNil, default: proc { 'text' }
      prop :disabled, Types::BoolOrNil, default: proc {}
      prop :readonly, Types::BoolOrNil, default: proc {}
      prop :autofocus, Types::BoolOrNil, default: proc {}
      prop :required, Types::BoolOrNil, default: proc {}
      prop :placeholder, Types::StringOrNil, default: proc {}
      prop :maxlength, Types::IntOrNil, default: proc {}
      prop :minlength, Types::IntOrNil, default: proc {}
      prop :autocomplete, Types::StringOrNil, default: proc {}
      prop :pattern, Types::StringOrNil, default: proc {}
      prop :size, Types::IntOrNil, default: proc {}
      prop :src, Types::StringOrNil, default: proc {}
      prop :alt, Types::StringOrNil, default: proc {}
      prop :step, Types::StringOrNil, default: proc {}
      prop :min, Types::StringOrNil, default: proc {}
      prop :max, Types::StringOrNil, default: proc {}
      prop :list, Types::StringOrNil, default: proc {}
      prop :multiple, Types::BoolOrNil, default: proc {}
      prop :form, Types::StringOrNil, default: proc {}
    end
  end
end
