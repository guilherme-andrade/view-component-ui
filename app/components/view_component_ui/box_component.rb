module ViewComponentUI
  class BoxComponent < Base
    include CSSOptions

    def call
      content_tag(as, **html_attributes) do
        content
      end
    end
  end
end
