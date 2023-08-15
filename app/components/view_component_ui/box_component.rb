module ViewComponentUI
  class BoxComponent < StyledComponent
    def call
      content_tag(as, **html_attributes) do
        content
      end
    end
  end
end
