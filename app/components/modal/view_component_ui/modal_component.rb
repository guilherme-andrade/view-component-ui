module ViewComponentUI
  class ModalComponent < BoxComponent
    include HasSizes

    defaults size: :md

    size :md, font_size: :base

    renders_one :head, "HeadComponent"
    renders_one :body, "BodyComponent"
    renders_one :footer, "FooterComponent"

    class WrapperComponent < CenterComponent
      defaults position: :fixed, inset: 0, h: :screen, w: :screen
    end

    class BackDropComponent < BoxComponent
      defaults position: :absolute, inset: 0, bg: :black, opacity: 75, h: :full, w: :full, z: 40
    end

    class DialogComponent < PaperComponent
      defaults position: :relative, z: 50, min_w: 96
    end

    class HeadComponent < BoxComponent
      include HasSizes

      defaults size: :md

      size :md, font_size: :base, pb: '2'
    end

    class BodyComponent < BoxComponent
      include HasSizes

      defaults size: :md

      size :md, font_size: :base, py: '2'
    end

    class FooterComponent < BoxComponent
      include HasSizes

      defaults size: :md

      size :md, font_size: :base, pt: '2'
    end
  end
end
