module Buttons
  class ActionIconComponentPreview < ViewComponent::Preview
    def default
      render ViewComponentUI::ActionIconComponent.new(icon: 'trash', color_scheme: :danger, size: :xs)
    end
  end
end
