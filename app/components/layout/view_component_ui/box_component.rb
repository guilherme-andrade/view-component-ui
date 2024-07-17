module ViewComponentUI
  class BoxComponent < StyledComponent
    def call
      render_self do
        content
      end
    end
  end
end
