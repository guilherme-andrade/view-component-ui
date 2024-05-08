module ViewComponentUI
  class ModalComponent < BoxComponent
    include HasSizes

    defaults size: :md, rounded: :lg, shadow: :lg

    size :md, font_size: :base, px: '4', py: '4'

    renders_one :head, "HeadComponent"
    renders_one :body, "BodyComponent"
    renders_one :footer, "FooterComponent"

    def call
      render BoxComponent.new(**html_attributes) do
        safe_join([head, body, footer])
      end
    end

    class HeadComponent < BoxComponent
      include HasSizes

      defaults size: :md

      size :md, font_size: :base, py: '2', px: '4'
    end

    class BodyComponent < BoxComponent
      include HasSizes

      defaults size: :md

      size :md, font_size: :base, py: '2', px: '4'
    end

    class FooterComponent < BoxComponent
      include HasSizes

      defaults size: :md

      size :md, font_size: :base, py: '2', px: '4'
    end
  end
end
