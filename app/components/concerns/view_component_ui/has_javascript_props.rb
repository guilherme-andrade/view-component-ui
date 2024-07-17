module ViewComponentUI
  module HasJavascriptProps
    extend ActiveSupport::Concern

    included do
      JavascriptAttribute::ALL.each do |attribute|
        prop attribute, optional: true
      end
    end

    def html_attributes
      super.merge(javascript_attributes)
    end

    def property_keys
      super + JAVASCRIPT_ATTRIBUTES
    end

    def javascript_attributes
      values = props.slice(*JavascriptAttribute::ALL)
      JavascriptAttribute::List.new(component: self, values:).to_html_attributes
    end
  end
end
