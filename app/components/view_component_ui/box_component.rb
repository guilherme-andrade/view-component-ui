module ViewComponentUI
  class BoxComponent < Base
    include CSSOptions

    def call
      content_tag(tag, **html_attributes) do
        content
      end
    end
  end
end
