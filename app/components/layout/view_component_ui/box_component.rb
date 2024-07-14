module ViewComponentUI
  class BoxComponent < StyledComponent
    def call
      as_tag do
        content
      end
    end
  end
end
