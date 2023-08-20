module ViewComponentUI
  class AspectRatioComponent < BoxComponent
    defaults position: :relative, max_width: :md

    renders_one :html, lambda { |**all_options|
      BoxComponent.new(
        overflow: :hidden,
        position: :absolute,
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        width: 'full',
        height: 'full',
        **all_options
      )
    }

    def call
      render BoxComponent.new(as:, **html_attributes) do
        space_fill = render BoxComponent.new(display: :block, height: 0, style: { padding_top: '100%' })
        safe_join([space_fill, html])
      end
    end
  end
end
