module Layout
  class ContainerComponentPreview < ViewComponent::Preview
    def default
      render ViewComponentUI::ContainerComponent.new do
        'In mollit do excepteur ullamco eu duis. Esse dolore anim enim nisi. Adipisicing mollit cillum quis officia ' \
          'ea eiusmod laborum labore cillum pariatur nulla occaecat. Et culpa non non quis ad et.'
      end
    end
  end
end
