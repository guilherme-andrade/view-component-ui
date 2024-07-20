module ViewComponentUI
  class ContainerComponent < BoxComponent
    include HasSizes

    default_props tag: :div, width: :full, mx: :auto, size: :lg

    size :md, max_w: 80
    size :sm, max_w: 64
    size :lg, max_w: 96
    size :full, max_w: :full
  end
end
