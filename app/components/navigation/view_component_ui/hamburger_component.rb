module ViewComponentUI
  class HamburgerComponent < ButtonComponent
    default_props variant: :ghost, color_scheme: :neutral, group: true, w: :fit, direction: :col, justify: :center, items: :center, gap: 1, w: 8, h: 8

    erb_template <<~ERB
      <%= render_self do %>
        <%= render ViewComponentUI::BoxComponent.new(h: 1, w: 6, rounded: :full, bg: :black, transition: true, _group_hover: { rotate: 45, translate_y: 1 }) %>
        <%= render ViewComponentUI::BoxComponent.new(h: 1, w: 6, rounded: :full, bg: :black, transition: true, _group_hover: { rotate: -45, translate_y: -1 }) %>
      <% end %>
    ERB
  end
end

# <div class="tw-items-center tw-flex tw-flex-col tw-gap-1 tw-justify-center tw-w-fit tw-w-8 tw-h-8">
#           <div class="tw-bg-black tw-rounded-full tw-h-1 tw-transition tw-w-6 group-hover:tw-rotate-45 group-hover:tw-translate-y-1"></div>
#           <div class="tw-bg-black tw-rounded-full tw-h-1 tw-transition tw-w-6 group-hover:tw--rotate-45 group-hover:tw--translate-y-1"></div>
# </div>

# tw-translate-y-2.5 tw-translate-y-2 tw-translate-y-1.5 tw-translate-y-1
