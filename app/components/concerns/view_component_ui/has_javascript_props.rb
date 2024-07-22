module ViewComponentUI
  module HasJavascriptProps
    extend ActiveSupport::Concern

    def html_attributes
      super.merge(javascript_attributes)
    end

    def javascript_attributes
      JavascriptAttribute::List.new(props: props.slice(*Constants::JS_PROPS)).to_html_attributes
    end

    class_methods do
      def js(string)
        JavascriptCode.new(string)
      end
    end

    delegate :js, to: :class
  end
end
