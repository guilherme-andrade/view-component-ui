module ViewComponentUI
  class BreadcrumbsComponent < BoxComponent
    include ViewComponentUI::HasSizes

    default_props as: :nav, display: :flex, align_items: :center, _hover: { color: 'gray-600' }

    renders_many :items, "BreadcrumbItemComponent"

    erb_template <<~ERB
      <%= render_self do %>
        <% items.each_with_index do |item, index| %>
          <% item.index = index %>
          <% item.total = items.size %>
          <%= item %>
        <% end %>
      <% end %>
    ERB

    class BreadcrumbItemComponent < ViewComponentUI::Base
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
