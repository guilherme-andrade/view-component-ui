module ViewComponentUI
  class IconComponent < BoxComponent
    include HasSizes

    default_props as: :span, display: :inline_block, size: :md

    prop :icon, Types::Coercible::String, optional: false

    size :xs, h: 2.5, w: 2.5
    size :sm, h: 3, w: 3
    size :md, h: 4, w: 4
    size :lg, h: 6, w: 6
    size :xl, h: 10, w: 10

    def class_list
      [super, "fas", icon_class].flatten
    end

    def icon_class
      "fa-#{props[:icon]}"
    end
  end
end
