module ViewComponentUI
  class ButtonComponent < BoxComponent
    include HasSizes
    include HasVariants
    include HasColorScheme

    defaults variant: :solid, size: :md, color_scheme: :primary, tag: :button, type: :button,
             border_radius: :md, display: :inline_block, cursor: :pointer

    variant :solid,
            bg: proc { color_scheme_token(500) },
            color: 'white',
            _hover: proc { { bg: color_scheme_token(600) } }

    variant :outline,
            border: 'true',
            border_color: proc { color_scheme_token(500) },
            color: proc { color_scheme_token(500) },
            _hover: proc { { bg: color_scheme_token(500), text: 'white' } }

    variant :link,
            color: proc { color_scheme_token(500) },
            _hover: proc { { color: color_scheme_token(600) } }

    variant :ghost,
            bg: proc { color_scheme_token(50) },
            color: proc { color_scheme_token(500) },
            _hover: proc { { bg: color_scheme_token(100) } }

    size :sm, font_size: :sm, py: '1', px: '2'
    size :md, font_size: :base, py: '2', px: '4'
    size :lg, font_size: :lg, py: '3', px: '6'

    def call
      render BoxComponent.new(**html_attributes) do
        content
      end
    end
  end
end
