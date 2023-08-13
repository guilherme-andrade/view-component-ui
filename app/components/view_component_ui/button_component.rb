module ViewComponentUI
  class ButtonComponent < BoxComponent
    include HasSizes
    include HasVariants
    include HasColorScheme

    variant :solid,
            class_name: proc { "bg-#{color_scheme_token(500)} hover:bg-#{color_scheme_token(600)} text-white" }

    variant :outline,
            class_name: proc {
                          "border border-#{color_scheme_token(500)} " \
                            "hover:bg-#{color_scheme_token(500)} text-#{color_scheme_token(500)} hover:text-white"
                        }
    variant :link,
            class_name: proc { "text-#{color_scheme_token(500)} hover:text-#{color_scheme_token(600)}" }
    variant :ghost,
            class_name: proc {
                          "bg-#{color_scheme_token(100)} hover:bg-#{color_scheme_token(200)} " \
                            "text-#{color_scheme_token(500)}"
                        }

    size :sm, class_name: proc { 'text-sm py-1 px-2' }
    size :md, class_name: proc { 'text-base py-2 px-4' }
    size :lg, class_name: proc { 'text-lg py-3 px-6' }

    option :tag, default: proc { :button }
    option :type, default: proc { :button }
    option :border_radius, default: proc { :md }
    option :display, default: proc { :inline_block }
    option :cursor, default: proc { :pointer }

    def call
      render BoxComponent.new(**options) do
        content
      end
    end
  end
end
