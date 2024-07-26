module Navigation
  class HamburgerComponentPreview < ViewComponent::Preview
    def default
      render(ViewComponentUI::HamburgerComponent.new)
    end
  end
end
