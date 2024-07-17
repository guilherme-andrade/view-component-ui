module ViewComponentUI
  class AccordionComponent < StackComponent
    default_props border: true, x_data: "{ activeIndex: 0 }", gap: 0, rounded: true

    renders_many :items, "AccordionItemComponent"

    erb_template <<-ERB
      <%= render_self do %>
        <% items.each_with_index do |item, index| %>
          <% item.index = index %>
          <%= item %>
        <% end %>
      <% end %>
    ERB

    class AccordionItemComponent < BoxComponent
      # tw-border-t first:tw-border-t-0
      default_props border_top: true, _first: { border_top: 0 },
                    on_click: "activeIndex = index", x_data: -> { "{ index: #{index} }" }

      attr_accessor :index

      # tw-p-3 tw-px-3 tw-pb-3 tw-pt-3 tw-pb-2
      erb_template <<-ERB
        <%= render_self do %>
          <%= render ViewComponentUI::BoxComponent.new(px: 3, pt: 3, pb: 2) do %>
            <%= title %>
          <% end %>
          <%= render ViewComponentUI::BoxComponent.new(px: 3, pb: 3, x_show: "activeIndex === index", font_size: :sm, color: 'gray-500') do %>
            <%= content %>
          <% end %>
        <% end %>
      ERB
    end
  end
end
