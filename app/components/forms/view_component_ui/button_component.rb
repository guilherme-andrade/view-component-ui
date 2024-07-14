module ViewComponentUI
  class ButtonComponent < BoxComponent
    include HasSizes
    include HasVariants
    include HasColorScheme

    defaults variant: :solid, size: :md, color_scheme: :primary, as: :button, type: :button,
             border_radius: :md, display: :inline_block, cursor: :pointer, _hover: { bg: 'white' }

    variant :solid,
            color: 'white',
            bg: proc { color_scheme_token(500) },
            _hover: { bg: proc { color_scheme_token(600) } }

    variant :outline,
            border: true,
            border_color: proc { color_scheme_token(500) },
            color: proc { color_scheme_token(500) },
            _hover: { bg: proc { color_scheme_token(500) }, color: 'white' }

    variant :link,
            color: proc { color_scheme_token(500) },
            _hover: { color: proc { color_scheme_token(600) } }

    variant :ghost,
            bg: proc { color_scheme_token(50) },
            color: proc { color_scheme_token(500) },
            _hover: { bg: proc { color_scheme_token(100) } }

    size :sm, font_size: :sm, py: '1', px: '2'
    size :md, font_size: :base, py: '2', px: '4'
    size :lg, font_size: :lg, py: '3', px: '6'
  end
end
