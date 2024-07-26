module ViewComponentUI
  class NavLinkComponent < LinkComponent
    include HasVariants
    include HasColorScheme

    self.ignored_parent_default_props = %i[color bg _hover]

    renders_one :left_section, "LeftSection"
    renders_one :right_section, "RightSection"
    renders_one :description, "Description"

    prop :light, Types::Bool.default(false).optional
    prop :active, Types::Bool.optional

    default_props variant: :default, px: 4, py: 2, cursor: :pointer, display: :flex, align_items: :center, justify_content: :center, font_size: :sm

    # hover:tw-bg-gray-50
    variant :default, x_bind: {
      class: proc {
        js({
          string_class_names(bg: 'transparent', color: props_color_scheme_token(500), _hover: { bg: props_color_scheme_token(100) }) => js(active?),
          string_class_names(bg: 'transparent', _hover: { bg: color_scheme_token(:neutral, 50) }) => js(!active?),
        })
      }
    }

    variant :light, x_bind: {
      class: proc {
        js({
          string_class_names(bg: props_color_scheme_token(100), color: props_color_scheme_token(600), _hover: { bg: props_color_scheme_token(200) }) => js(active?),
          string_class_names(bg: 'transparent', _hover: { bg: color_scheme_token(:neutral, 50) }) => js(!active?),
        })
      }
    }

    variant :subtle, x_bind: {
      class: proc {
        js({
          string_class_names(bg: 'transparent', color: props_color_scheme_token(600), _hover: { bg: props_color_scheme_token(100) }) => js(active?),
          string_class_names(bg: 'transparent', _hover: { bg: color_scheme_token(:neutral, 50) }) => js(!active?),
        })
      }
    }

    variant :filled, x_bind: {
      class: proc {
        js({
          string_class_names(bg: props_color_scheme_token(600), color: 'white', _hover: { bg: props_color_scheme_token(700) }) => js(active?),
          string_class_names(bg: 'transparent', _hover: { bg: color_scheme_token(:neutral, 50) }) => js(!active?),
        })
      }
    }

    # tw-flex-1 tw-mb-0 tw-mb-2 tw-grow-1
    erb_template <<-ERB
      <%= render_self do %>
        <%= left_section if left_section? %>
        <%= render ViewComponentUI::BoxComponent.new(as: :span, grow: 1) do %>
          <%= content %>
          <%= description if description? %>
        <% end %>
        <%= right_section if right_section? %>
      <% end %>
    ERB

    def light?
      props[:light].present?
    end

    def active?
      props[:active].present?
    end

    class LeftSection < BoxComponent
      default_props mr: 3, as: :span, display: :block
    end

    class RightSection < BoxComponent
      default_props ml: 3, as: :span, display: :block
    end

    class Description < TextComponent
      default_props color: :gray_500, as: :span, font_size: :xs, display: :block, my: 0.5
    end
  end
end
