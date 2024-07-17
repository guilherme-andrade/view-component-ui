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
        tab_pane: { x_show: "active == $el.id" }
      }
    }.with_indifferent_access.freeze

    renders_many :tabs, proc { TabComponent.new(**_1, pointer_method:) }
    renders_many :tab_panes, proc { TabPaneComponent.new(**_1, pointer_method:) }

    prop :pointer_method, POINTER_METHOD_TYPE, default: proc { 'index' }, optional: true

    default_props x_data: proc { POINTER_METHOD_PROPS[pointer_method][:tabs][:x_data] }

    def on_active_tab_change_function
      <<~ALPINEJS
        function onActiveChange(active, element) {
          if (active === element.dataset.id) {
            element.classList.remove('tw-text-gray-600', 'tw-bg-transparent', 'hover:tw-bg-gray-50')
            element.classList.add('tw-text-blue-900', 'tw-bg-blue-50', 'hover:tw-bg-blue-50')
          } else {
            element.classList.remove('tw-text-blue-900', 'tw-bg-blue-50', 'hover:tw-bg-blue-50')
            element.classList.add('tw-text-gray-600', 'tw-bg-transparent', 'hover:tw-bg-gray-50')
          }
        }
      ALPINEJS
    end

    class TabComponent < ActiveLinkComponent
      default_props as: :a, display: :inline_block, cursor: :pointer, px: 4, py: 2, rounded: true, mr: 1,
               on_click: proc { POINTER_METHOD_PROPS[pointer_method][:tab][:on_click] }, _hover: { color: 'blue-600' },
               x_effect: proc { "onActiveChange(active, $el)" }

      prop :pointer_method, POINTER_METHOD_TYPE
    end

    class TabPaneComponent < BoxComponent
      default_props x_show: proc { POINTER_METHOD_PROPS[pointer_method][:tab_pane][:x_show] }

      prop :pointer_method, POINTER_METHOD_TYPE
    end
  end
end
