module Buttons
  class ActionIconComponentPreview < ViewComponent::Preview
    def default
      binding.pry
      render ViewComponentUI::ActionIconComponent.new(icon: 'trash', color_scheme: :danger, size: :xl)
    end
  end
end
