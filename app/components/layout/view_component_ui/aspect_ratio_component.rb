module ViewComponentUI
  class AspectRatioComponent < BoxComponent
    default_props position: :relative, max_width: :md

    renders_one :html, lambda { |**props|
      BoxComponent.new(
        overflow: :hidden,
        position: :absolute,
        top: 0,
        right: 0,
        bottom: 0,
        left: 0,
        width: 'full',
        height: 'full',
        **props
      )
    }

    def call
      render_self do
        safe_join([space_fill, html])
      end
    end

    def space_fill
      render BoxComponent.new(display: :block, height: 0, style: { padding_top: '100%' })
    end
  end
end
