module Layout
  class BoxComponentPreview < ViewComponent::Preview
    # @param as text "A symbol representing the HTML tag to use for the component."
    def default(as: :div)
      render ViewComponentUI::BoxComponent.new(as:) do
        'This is a box.'
      end
    end
  end
end
