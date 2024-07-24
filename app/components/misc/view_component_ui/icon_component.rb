module ViewComponentUI
  class IconComponent < BoxComponent
    default_props as: :span, display: :inline_block, font_size: :xs

    prop :icon, Types::String, optional: false

    def class_list
      [super, "fas", icon_class]
    end

    def icon_class
      "fa-#{props[:icon]}"
    end
  end
end
