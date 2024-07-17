module ViewComponentUI
  class Base < ViewComponent::Base
    extend Dry::Initializer
    include HasProps
    include HasHTMLCommonProps
    include HasJavascriptProps
  end
end
