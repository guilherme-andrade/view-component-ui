module ViewComponentUI
  class Base < ViewComponent::Base
    include HasProps
    include HasHTMLCommonProps
    include HasJavascriptProps
  end
end
