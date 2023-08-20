module Typography
  class LinkComponentPreview < ViewComponent::Preview
    def default
      render ViewComponentUI::LinkComponent.new do
        'This is a link.'
      end
    end
  end
end
