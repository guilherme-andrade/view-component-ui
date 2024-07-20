module Forms
  class ButtonComponentPreview < ViewComponent::Preview
    # @param variant select {{ ViewComponentUI::ButtonComponent.variants.keys }} "The variant of the button"
    # @param color_scheme select {{ ViewComponentUI.config.theme.color_scheme.keys }} "The color scheme of the button"
    # @param size select {{ ViewComponentUI::ButtonComponent.sizes.keys }} "The size of the button"
    def default(size: :md, variant: :solid, color_scheme: :primary)
      render ViewComponentUI::ButtonComponent.new(size:, variant:, color_scheme:) do
        "This is a #{size} #{variant} #{color_scheme} button."
      end
    end

    # @!group Variants
    def solid
      render ViewComponentUI::ButtonComponent.new(variant: :solid) do
        'This is a button.'
      end
    end

    def outline
      render ViewComponentUI::ButtonComponent.new(variant: :outline) do
        'This is a button.'
      end
    end

    def link
      render ViewComponentUI::ButtonComponent.new(variant: :link) do
        'This is a button.'
      end
    end

    def ghost
      render ViewComponentUI::ButtonComponent.new(variant: :ghost) do
        'This is a button.'
      end
    end
    # @!endgroup

    # @!group Sizes
    def sm
      render ViewComponentUI::ButtonComponent.new(size: :sm) do
        'This is a button.'
      end
    end

    def md
      render ViewComponentUI::ButtonComponent.new(size: :md) do
        'This is a button.'
      end
    end

    def lg
      render ViewComponentUI::ButtonComponent.new(size: :lg) do
        'This is a button.'
      end
    end
    # @!endgroup

    # @!group Colors
    def primary
      render ViewComponentUI::ButtonComponent.new(color_scheme: :primary) do
        'This is a button.'
      end
    end

    def secondary
      render ViewComponentUI::ButtonComponent.new(color_scheme: :secondary) do
        'This is a button.'
      end
    end

    def success
      render ViewComponentUI::ButtonComponent.new(color_scheme: :success) do
        'This is a button.'
      end
    end

    def danger
      render ViewComponentUI::ButtonComponent.new(color_scheme: :danger) do
        'This is a button.'
      end
    end

    def warning
      render ViewComponentUI::ButtonComponent.new(color_scheme: :warning) do
        'This is a button.'
      end
    end

    def info
      render ViewComponentUI::ButtonComponent.new(color_scheme: :info) do
        'This is a button.'
      end
    end

    def gray
      render ViewComponentUI::ButtonComponent.new(color_scheme: :gray) do
        'This is a button.'
      end
    end
    # @!endgroup
  end
end
