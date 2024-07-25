module ViewComponentUI
  class BreadcrumbsComponent < BoxComponent
    include ViewComponentUI::HasSizes

    default_props as: :nav, display: :flex, align_items: :center

    renders_many :items, "BreadcrumbItemComponent"

    erb_template <<~ERB
      <%= render_self do %>
        <% items.each_with_index do |item, index| %>
          <%= render ViewComponentUI::BoxComponent.new(color: 'gray-500', font_size: :sm).with_content("/") unless index.zero? %>
          <% item.index = index %>
          <% item.total = items.size %>
          <%= item %>
        <% end %>
      <% end %>
    ERB

    class BreadcrumbItemComponent < ViewComponentUI::Base
      default_props px: 2, py: 1

      attr_accessor :index, :total

      def as
        if index != total - 1
          LinkComponent
        else
          BoxComponent
        end
      end
    end
  end
end
