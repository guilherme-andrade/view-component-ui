module Layout
  class AspectRatioComponentPreview < ViewComponent::Preview
    # @param as text "A symbol representing the HTML tag to use for the component."
    def default(as: :div)
      render ViewComponentUI::AspectRatioComponent.new(as:) do |aspect_ratio|
        aspect_ratio.with_html(bg: 'gray-200') do
          'This is a box.'
        end
      end
    end
  end
end
