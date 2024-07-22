module ViewComponentUI
  class ActionIconComponent < ButtonComponent
    default_props align_items: :center, justify_content: :center

    prop :icon, Types::String

    size :sm, font_size: :sm, w: 6, h: 6, rounded: :sm
    size :md, font_size: :base, w: 8, h: 8, rounded: :sm
    size :lg, font_size: :xl, w: 10, h: 10, rounded: :sm
    size :xl, font_size: :"3xl", w: 12, h: 12, rounded: :sm

    def call
      render_self do
        render(ViewComponentUI::IconComponent.new(icon: icon, font_size: props[:font_size]))
      end
    end
  end
end
