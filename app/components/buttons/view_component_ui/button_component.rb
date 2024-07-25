module ViewComponentUI
  class ButtonComponent < GroupComponent
    include HasSizes
    include HasVariants
    include HasColorScheme

    default_props variant: :solid, size: :md, color_scheme: :primary, as: :button, type: :button,
             rounded: :md, cursor: :pointer, _hover: { bg: 'white' }, gap: 1, display: :inline_flex, align_items: :center

    variant :solid,
            color: 'white',
            bg: proc { color_scheme_token(500) },
            _hover: { bg: proc { color_scheme_token(600) } }

    variant :outline,
            border: true,
            border_color: proc { color_scheme_token(500) },
            color: proc { color_scheme_token(500) },
            _hover: { bg: proc { color_scheme_token(500) }, color: 'white' }

    variant :link,
            color: proc { color_scheme_token(500) },
            _hover: { color: proc { color_scheme_token(600) } }

    variant :ghost,
            bg: proc { color_scheme_token(50) },
            color: proc { color_scheme_token(500) },
            _hover: { bg: proc { color_scheme_token(100) } }

    size :sm, font_size: :sm, py: '1', px: '2'
    size :md, font_size: :base, py: '2', px: '4'
    size :lg, font_size: :lg, py: '3', px: '6'

    prop :icon_left, Types::String
    prop :icon_right, Types::String

    # tw-mr-1 tw-ml-1
    erb_template <<~ERB
      <%= render_self do %>
        <%= render(ViewComponentUI::IconComponent.new(icon: render_props[:icon_left], mr: 1)) if render_props[:icon_left] %>
        <%= content %>
        <%= render(ViewComponentUI::IconComponent.new(icon: render_props[:icon_right], ml: 1)) if render_props[:icon_right] %>
      <% end %>
    ERB

    def render_self(&block)
      binding.pry
      super(&block)
    end
  end
end
