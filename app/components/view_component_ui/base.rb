module ViewComponentUI
  class Base < ViewComponent::Base
    extend Dry::Initializer
    include HTMLTag
  end
end
