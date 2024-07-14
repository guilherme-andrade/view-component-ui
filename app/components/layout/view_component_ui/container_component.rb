module ViewComponentUI
  class ContainerComponent < BoxComponent
    include HasSizes

    defaults tag: :div, width: :full, mx: :auto, size: :lg

    size :sm, max_w: 48
    size :md, max_w: 64
    size :lg, max_w: 96
  end
end
