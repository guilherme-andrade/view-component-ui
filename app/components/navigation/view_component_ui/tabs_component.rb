module ViewComponentUI
  class TabsComponent < PaperComponent
    POINTER_METHOD_TYPE = Types::Coercible::String.enum('index', 'id')
    POINTER_METHOD_PROPS = {
      index: {
        tabs: { x_data: "{ active: 0 }" },
        tab: { on_click: "active = Array.prototype.indexOf.call($el.parentNode.children, $el)" },
        tab_pane: { x_show: "active == Array.prototype.indexOf.call($el.parentNode.children, $el)" }
      },
      id: {
        tabs: { x_data: proc { "{ active: '#{tab_panes.first.id}' } " } },
        tab: { on_click: "active = $el.dataset.id" },
        tab_pane: { x_show: "active === $el.id" }
      }
    }.with_indifferent_access.freeze

    renders_many :tabs, proc { TabComponent.new(**_1, pointer_method:) }
    renders_many :tab_panes, proc { TabPaneComponent.new(**_1, pointer_method:) }

    prop :pointer_method, POINTER_METHOD_TYPE, default: proc { 'index' }, optional: true

    default_props x_data: proc { POINTER_METHOD_PROPS[pointer_method][:tabs][:x_data] }

    erb_template <<~ERB
      <%= render_self do %>
        <%= render ViewComponentUI::GroupComponent.new do %>
          <% tabs.each do |tab| %>
            <%= tab %>
          <% end %>
        <% end %>
        <%= render ViewComponentUI::BoxComponent.new do %>
          <% tab_panes.each do |tab_pane| %>
            <%= tab_pane %>
          <% end %>
        <% end %>
      <% end %>
    ERB

    class TabComponent < ActiveLinkComponent
      # tw-bg-blue-100
      default_props as: :a, display: :inline_block, cursor: :pointer, px: 4, py: 2, rounded: true, _hover: { color: 'blue-600' },
               on_click: proc { POINTER_METHOD_PROPS[pointer_method][:tab][:on_click] },
               x_bind: { class: proc { js({ string_class_names(bg: "blue-100") => js("active === $el.dataset.id") }) } }

      prop :pointer_method, POINTER_METHOD_TYPE
    end

    class TabPaneComponent < BoxComponent
      default_props x_show: proc { POINTER_METHOD_PROPS[pointer_method][:tab_pane][:x_show] }

      prop :pointer_method, POINTER_METHOD_TYPE
    end
  end
end
