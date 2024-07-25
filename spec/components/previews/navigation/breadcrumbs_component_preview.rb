module Navigation
  class BreadcrumbsComponentPreview < ViewComponent::Preview
    def default
      render ViewComponentUI::BreadcrumbsComponent.new do |component|
        component.with_item(to: 'sadasd') do
          'Item'
        end

        component.with_item(to: 'asdasd') do
          'Item'
        end

        component.with_item(to: 'asdasd') do 
          'Item'
        end
      end
    end
  end
end
