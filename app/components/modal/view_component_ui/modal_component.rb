module ViewComponentUI
  class ModalComponent < BoxComponent
    include HasSizes

    default_props size: :md

    size :md, font_size: :base

    renders_one :trigger, "TriggerComponent"
    renders_one :head, "HeadComponent"
    renders_one :body, "BodyComponent"
    renders_one :footer, "FooterComponent"

    class TriggerComponent < ButtonComponent
      default_props on_click: "open = ! open"
    end

    class WrapperComponent < BoxComponent
      default_props position: :fixed, inset: 0, h: :screen, w: :screen, x_show: "open", display: :flex,
               justify_content: :center, align_items: :center, x_transition: ""
    end

    class BackDropComponent < BoxComponent
      default_props position: :absolute, inset: 0, bg: :black, opacity: 75, h: :full, w: :full, z: 40
    end

    class DialogComponent < PaperComponent
      default_props position: :relative, z: 50, min_w: 96
    end

    class HeadComponent < BoxComponent
      include HasSizes

      default_props size: :md

      size :md, font_size: :base, pb: '2'
    end

    class BodyComponent < BoxComponent
      include HasSizes

      default_props size: :md

      size :md, font_size: :base, py: '2'
    end

    class FooterComponent < BoxComponent
      include HasSizes

      default_props size: :md

      size :md, font_size: :base, pt: '2'
    end
  end
end
