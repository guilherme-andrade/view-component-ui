module ViewComponentUI
  module HasStyleProps
    extend ActiveSupport::Concern

    def class_list
      props[:class_list].to_s.split(/\s+/).concat(class_names(props)).compact
    end

    def class_names(...)
      Compiler::ClassListBuilder.new.call(...)
    end

    def string_class_names(props)
      class_names(props).join(' ')
    end
  end
end
