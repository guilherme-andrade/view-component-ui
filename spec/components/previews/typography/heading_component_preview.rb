module Typography
  class HeadingComponentPreview < ViewComponent::Preview
    # @!group Levels
    # @label h1
    def one
      render ViewComponentUI::HeadingComponent.new(level: 1) do
        'This is an h1.'
      end
    end

    # @label h2
    def two
      render ViewComponentUI::HeadingComponent.new(level: 2) do
        'This is an h2.'
      end
    end

    # @label h3
    def three
      render ViewComponentUI::HeadingComponent.new(level: 3) do
        'This is an h3.'
      end
    end

    # @label h4
    def four
      render ViewComponentUI::HeadingComponent.new(level: 4) do
        'This is an h4.'
      end
    end

    # @label h3
    def five
      render ViewComponentUI::HeadingComponent.new(level: 5) do
        'This is an h5.'
      end
    end

    # @label h3
    def six
      render ViewComponentUI::HeadingComponent.new(level: 6) do
        'This is an h6.'
      end
    end
    # @!endgroup
  end
end
