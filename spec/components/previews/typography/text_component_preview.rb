module Typography
  class TextComponentPreview < ViewComponent::Preview
    # @param font_size select {{ ViewComponentUI::FONT_SIZE }}
    def default(font_size: :base)
      render ViewComponentUI::TextComponent.new(font_size:) do
        'Magna exercitation aliqua cupidatat nulla veniam nulla ullamco ' \
          'proident aute dolore cupidatat nostrud fugiat adipisicing.'
      end
    end
  end
end
