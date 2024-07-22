module ViewComponentUI
  module Constants
    HTML_TAGS = %i[
      a abbr address area article aside audio b base bdi bdo blockquote body br
      button canvas caption cite code col colgroup data datalist dd del details
      dfn dialog div dl dt em embed fieldset figcaption figure footer form h1 h2
      h3 h4 h5 h6 head header hr html i iframe img input ins kbd label legend li
      link main map mark meta meter nav noframes noscript object ol optgroup option
      output p param picture pre progress q rp rt ruby s samp script section select
      small source span strong style sub summary sup svg table tbody td template
      textarea tfoot th thead time title tr track u ul var video wbr
    ].freeze

    JS_PROPS = %i[x_data x_init x_show x_bind x_on x_text x_html x_model x_modelable x_for x_transition
                       x_effect x_ignore x_ref x_cloak x_teleport x_if x_id on_click on_focus].freeze    

    COLOR_WEIGHTS = ([nil] + %i[50 100 200 300 400 500 600 700 800 900]).freeze
    BREAKPOINTS = %i[xs sm md lg xl 2xl].freeze
    PSEUDO_CLASSES = %i[hover focus active visited disabled active first last first_of_type last_of_type
                        odd even].freeze
    PSEUDO_ELEMENTS = %i[before after file first-letter first-line selection backdrop marker].freeze

    ALIGN_CONTENT = %i[normal center start end between around evenly baseline stretch].freeze
    ALIGN_ITEMS = %i[start end center baseline stretch].freeze
    BACKFACE_VISIBILITY = %i[visible hidden].freeze
    BACKGROUND_ATTACHMENT = %i[fixed local scroll].freeze
    BACKGROUND_BLEND_MODE = %i[normal multiply screen overlay darken lighten color-dodge color-burn hard-light
                              soft-light difference exclusion hue saturation color luminosity].freeze
    BACKGROUND_CLIP = %i[border padding content].freeze
    BACKGROUND_IMAGE = %i[none gradient-to-t gradient-to-tr gradient-to-r gradient-to-br gradient-to-b gradient-to-bl
                          gradient-to-l gradient-to-tl].freeze
    BACKGROUND_ORIGIN = %i[border padding content].freeze
    BACKGROUND_POSITION = %i[bottom center left left-bottom left-top right right-bottom right-top
                            top].freeze
    BACKGROUND_REPEAT = %i[repeat repeat-x repeat-y no-repeat round space].freeze
    BORDER_RADIUSES = %i[none sm md lg full].freeze
    BACKGROUND_SIZE = %i[auto cover contain].freeze
    BORDER_COLLAPSE = %i[collapse separate].freeze
    BORDER_RADIUS = %i[none sm true md lg xl 2xl 3xl full] + [true].freeze
    SPACING = %i[0 px 0.5 1 1.5 2 2.5 3 3.5 4 5 6 7 8 9 10 11 12 14 16 20 24 28 32 36 40 44 48 52 56 60 64 72
                80 96 auto].freeze
    BORDER_STYLE = %i[solid dashed dotted double none].freeze
    BORDER = [true, false].freeze
    BORDER_WIDTH = %i[0 1 2 4 8].freeze
    BOX_DECORATION_BREAK = %i[slice clone].freeze
    BOX_SHADOW = (%i[sm md lg xl 2xl inner none] + [true]).freeze
    BOX_SIZING = %i[border content].freeze
    CAPTION_SIDE = %i[top bottom].freeze
    CLEAR = %i[left right both none].freeze
    COLORS = %i[transparent current inherit black white neutral zync stone gray red amber yellow lime green blue indigo
                violet purple pink slate emerald fuchsia rose cyan teal sky].freeze
    COLOR_SCHEME = {
      primary: :purple,
      secondary: :indigo,
      success: :emerald,
      danger: :rose,
      warning: :yellow,
      info: :teal,
      gray: :gray
    }.with_indifferent_access.freeze
    COLUMNS = %i[auto 1 2 3 4 5 6 7 8 9 10 11 12 3xs 2xs xs sm md lg xl 2xl 3xl 4xl 5xl 6xl 7xl].freeze
    COLUMN_SPAN = %i[auto 1 2 3 4 5 6 7 8 9 10 11 12 all].freeze
    COLUMN_START = %i[auto 1 2 3 4 5 6 7 8 9 10 11 12 13].freeze
    COLUMN_END = %i[auto 1 2 3 4 5 6 7 8 9 10 11 12 13].freeze
    CONTENT = %i[none].freeze
    CURSOR = %i[auto default pointer wait text move help not-allowed].freeze
    DISPLAY = %i[block inline-block inline inline-table table table-caption table-cell table-column table-column-group
                table-footer-group table-header-group table-row table-row-group flow-root grid inline-grid contents
                list-item hidden flex inline-flex].freeze
    EMPTY_CELLS = %i[show hide].freeze
    FLEX_BASIS = %i[auto 0].freeze
    FLEX_DIRECTION = %i[row row-reverse col col-reverse].freeze
    FLEX_GROW = [0, true].freeze
    FLEX_SHRINK = [0, true].freeze
    FLEX_WRAP = %i[wrap nowrap wrap-reverse].freeze
    FLEX = %i[1 auto initial none].freeze
    FONT_FAMILY = %i[sans serif mono].freeze
    FONT_SIZE = %i[xs sm base lg xl 2xl 3xl 4xl 5xl 6xl 7xl 8xl 9xl].freeze
    FONT_STYLE = %i[italic non-italic].freeze
    FONT_VARIANT_NUMERIC = %i[normal-nums ordinal slashed-zero lining-nums oldstyle-nums proportional-nums
                              tabular-nums diagonal-fractions stacked-fractions].freeze
    FONT_WEIGHT = %i[hairline thin light normal medium semibold bold extrabold black].freeze
    GRID_AUTO_COLUMNS = %i[auto min max fr].freeze
    GRID_AUTO_FLOW = %i[row column dense row-dense column-dense].freeze
    GRID_AUTO_ROWS = %i[auto min max fr].freeze
    GRID_TEMPLATE_COLUMNS = %i[none 1 2 3 4 5 6 7 8 9 10 11 12].freeze
    GRID_TEMPLATE_ROWS = %i[none 1 2 3 4 5 6].freeze
    SIZES = %i[0 px 0.5 1 1.5 2 2.5 3 3.5 4 5 6 7 8 9 10 11 12 14 16 20 24 28 32 36 40 44 48 52 56 60 64 72
              80 96 auto 1/2 1/3 2/3 1/4 2/4 3/4 1/5 2/5 3/5 4/5 1/6 2/6 3/6 4/6 5/6 full screen min max fit].freeze
    HYPHENS = %i[none manual auto].freeze
    ISOLATION = %i[isolate auto].freeze
    JUSTIFY_CONTENT = %i[start end center between around evenly].freeze
    JUSTIFY_ITEMS = %i[start end center baseline stretch].freeze
    JUSTIFY_SELF = %i[start end center auto stretch].freeze
    LETTER_SPACING = %i[tighter tight normal wide wider widest].freeze
    LINE_HEIGHT = %i[none tight snug normal relaxed loose 3 4 5 6 7 8 9 10].freeze
    LIST_STYLE_IMAGE = %i[none].freeze
    LIST_STYLE_POSITION = %i[inside outside].freeze
    LIST_STYLE_TYPE = %i[none disc decimal].freeze
    MAX_SIZE = %i[0 xs sm md lg xl 2xl 3xl 4xl 5xl 6xl 7xl full screen min max fit prose screen-sm screen-md
                  screen-lg screen-xl screen-2xl].freeze
    MIN_SIZE = [0, :full, :min, :max, :fit].freeze
    MIX_BLEND_MODE = %i[normal multiply screen overlay darken lighten color-dodge color-burn hard-light soft-light
                        difference exclusion hue saturation color luminosity].freeze
    OBJECT_FIT = %i[contain cover fill none scale-down].freeze
    OBJECT_POSITION = %i[top right bottom left center].freeze
    OPACITY = %i[0 5 10 20 25 30 40 50 60 70 75 80 90 95 100].freeze
    ORDER = %i[first last none 1 2 3 4 5 6 7 8 9 10 11 12].freeze
    OUTLINE_STYLE = %i[dotted dashed solid double none].freeze
    OUTLINE_WIDTH = %i[0 1 2 4 8].freeze
    OVERFLOW = %i[auto hidden visible scroll x-hidden y-hidden x-scroll y-scroll x-auto y-auto].freeze
    PLACE_ITEMS = %i[start end center stretch].freeze
    PLACE_SELF = %i[start end center stretch].freeze
    POINTER_EVENTS = %i[none auto].freeze
    POSITION = %i[static fixed absolute relative sticky].freeze
    RESIZE = %i[true false none x y].freeze
    ROTATE = %i[0 1 2 3 6 12 45 90 180].freeze
    ROW_SPAN = %i[auto 1 2 3 4 5 6 full].freeze
    ROW_START = %i[auto 1 2 3 4 5 6 7].freeze
    ROW_END = %i[auto 1 2 3 4 5 6 7].freeze
    SCALE = %i[0 50 75 90 95 100 105 110 125 150 200].freeze
    SCROLL_BEHAVIOR = %i[auto smooth].freeze
    SCROLL_SNAP_ALIGN = %i[start end center none].freeze
    SCROLL_SNAP_STOP = %i[always normal].freeze
    SCROLL_SNAP_TYPE = %i[none mandatory proximity].freeze
    TABLE_LAYOUT = %i[auto fixed].freeze
    TEXT_ALIGN = %i[left center right justify start end].freeze
    TEXT_DECORATION = %i[underline line-through no-underline].freeze
    TEXT_DECORATION_STYLE = %i[solid double dotted dashed wavy].freeze
    TEXT_DECORATION_THICKNESS = %i[auto from-font 0 1 2 4 8].freeze
    TEXT_OVERFLOW = %i[ellipsis truncate].freeze
    TEXT_TRANSFORM = %i[uppercase lowercase capitalize normal].freeze
    TEXT_UNDERLINE_OFFSET = %i[auto 0 1 2 4 8].freeze
    TRANSFORM_ORIGIN = %i[center top-right top top-left right bottom-right bottom bottom-left left].freeze
    TRANSITION = %i[none all colors opacity shadow transform].freeze
    USER_SELECT = %i[none text all auto].freeze
    VERTICAL_ALIGN = %i[top middle bottom baseline text-top text-bottom sub super].freeze
    VISIBILITY = %i[visible invisible collapse].freeze
    WHITESPACE = %i[normal nowrap pre pre-line pre-wrap break-words].freeze
    WILL_CHANGE = %i[auto scroll contents opacity transform].freeze
    WORD_BREAK = %i[normal words all keep].freeze
    Z_INDEX = %i[0 10 20 30 40 50 auto].freeze

    COLOR_WITH_WEIGHTS = proc {
      ViewComponentUI.config.theme.colors.map do |color|
        COLOR_WEIGHTS.map { |weight| [color, weight].compact.join('-') }
      end.flatten.freeze
    }

    STYLE_PROP_MAP = {
      align_content: { values: ALIGN_CONTENT, token: 'content' },
      align_items: { values: ALIGN_ITEMS, token: 'items' },
      backface_visibility: { values: BACKFACE_VISIBILITY, token: 'backface' },
      background: { values: COLOR_WITH_WEIGHTS, token: 'bg', alias: :bg },
      background_attachment: { values: BACKGROUND_ATTACHMENT, token: 'bg' },
      background_blend_mode: { values: BACKGROUND_BLEND_MODE, token: 'bg' },
      background_clip: { values: BACKGROUND_CLIP, token: 'bg' },
      background_color: { values: COLOR_WITH_WEIGHTS, token: 'bg' },
      background_image: { values: BACKGROUND_IMAGE, token: 'bg' },
      background_origin: { values: BACKGROUND_ORIGIN, token: 'bg' },
      background_position: { values: BACKGROUND_POSITION, token: 'bg' },
      background_repeat: { values: BACKGROUND_REPEAT, token: 'bg' },
      background_size: { values: proc { ViewComponentUI.config.theme.background_size }, token: 'bg' },
      border_bottom_left_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-bl' },
      border_bottom_right_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-br' },
      border_top_left_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-tl' },
      border_top_right_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-tr' },
      border_top_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-t' },
      border_bottom_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-b' },
      border_left_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-l' },
      border_right_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded-r' },
      border_collapse: { values: BORDER_COLLAPSE, token: 'border' },
      border_color: { values: COLOR_WITH_WEIGHTS, token: 'border' },
      border_radius: { values: proc { ViewComponentUI.config.theme.border_radius }, token: 'rounded', alias: :rounded },
      border_spacing: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'border-spacing' },
      border_spacing_x: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'border-spacing-x' },
      border_spacing_y: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'border-spacing-y' },
      border_style: { values: BORDER_STYLE, token: 'border' },
      border: { values: BORDER, token: 'border' },
      border_top: { values: BORDER + BORDER_WIDTH, token: 'border-t' },
      border_bottom: { values: BORDER + BORDER_WIDTH, token: 'border-b' },
      border_left: { values: BORDER + BORDER_WIDTH, token: 'border-l' },
      border_right: { values: BORDER + BORDER_WIDTH, token: 'border-r' },
      border_width: { values: proc { ViewComponentUI.config.theme.border_width }, token: 'border' },
      border_y: { values: proc { ViewComponentUI.config.theme.border_width }, token: 'border-y' },
      border_x: { values: proc { ViewComponentUI.config.theme.border_width }, token: 'border-x' },
      border_start: { values: proc { ViewComponentUI.config.theme.border_width }, token: 'border-s' },
      border_end: { values: proc { ViewComponentUI.config.theme.border_width }, token: 'border-e' },
      bottom: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'bottom' },
      box_decoration_break: { values: BOX_DECORATION_BREAK, token: 'box-decoration-break' },
      box_shadow: { values: proc { ViewComponentUI.config.theme.box_shadow }, token: 'shadow', alias: :shadow },
      box_sizing: { values: proc { ViewComponentUI.config.theme.box_sizing }, token: 'box' },
      caption_side: { values: proc { ViewComponentUI.config.theme.caption_side }, token: 'caption' },
      clear: { values: proc { ViewComponentUI.config.theme.clear }, token: 'clear' },
      color: { values: COLOR_WITH_WEIGHTS, token: 'text' },
      column_gap: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'gap' },
      column_span: { values: proc { ViewComponentUI.config.theme.column_span }, token: 'col-span', alias: :col_span },
      column_start: { values: proc { ViewComponentUI.config.theme.column_start }, token: 'col-start', alias: :col_start },
      column_end: { values: proc { ViewComponentUI.config.theme.column_end }, token: 'col-end', alias: :col_end },
      columns: { values: proc { ViewComponentUI.config.theme.columns }, token: 'columns' },
      _content: { values: proc { ViewComponentUI.config.theme.content }, token: 'content' },
      cursor: { values: proc { ViewComponentUI.config.theme.cursor }, token: 'cursor' },
      display: { values: DISPLAY, token: nil },
      empty_cells: { values: proc { ViewComponentUI.config.theme.empty_cells }, token: 'empty' },
      end: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'end' },
      fill: { values: COLOR_WITH_WEIGHTS, token: 'fill' },
      flex_basis: { values: proc { ViewComponentUI.config.theme.flex_basis }, token: 'flex' },
      flex_direction: { values: proc { ViewComponentUI.config.theme.flex_direction }, token: 'flex', alias: :direction },
      flex_grow: { values: proc { ViewComponentUI.config.theme.flex_grow }, token: 'flex' },
      flex_shrink: { values: proc { ViewComponentUI.config.theme.flex_shrink }, token: 'flex' },
      flex_wrap: { values: proc { ViewComponentUI.config.theme.flex_wrap }, token: 'flex' },
      flex: { values: proc { ViewComponentUI.config.theme.flex }, token: 'flex' },
      font_family: { values: proc { ViewComponentUI.config.theme.font_family }, token: 'font' },
      font_size: { values: proc { ViewComponentUI.config.theme.font_size }, token: 'text' },
      font_style: { values: proc { ViewComponentUI.config.theme.font_style }, token: nil },
      font_variant_numeric: { values: proc { ViewComponentUI.config.theme.font_variant_numeric }, token: nil },
      font_weight: { values: proc { ViewComponentUI.config.theme.font_weight }, token: 'font' },
      grid_auto_columns: { values: proc { ViewComponentUI.config.theme.grid_auto_columns }, token: 'auto-cols' },
      grid_auto_flow: { values: proc { ViewComponentUI.config.theme.grid_auto_flow }, token: 'grid-flow' },
      grid_auto_rows: { values: proc { ViewComponentUI.config.theme.grid_auto_rows }, token: 'auto-rows' },
      gap: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'gap' },
      gap_x: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'gap-x' },
      gap_y: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'gap-y' },
      grid_template_columns: { values: proc { ViewComponentUI.config.theme.grid_template_columns }, token: 'grid-cols', alias: :grid_cols },
      grid_template_rows: { values: proc { ViewComponentUI.config.theme.grid_template_rows }, token: 'grid-rows' },
      height: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'h', alias: :h },
      hyphens: { values: proc { ViewComponentUI.config.theme.hyphens }, token: 'hyphens' },
      inset: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'inset' },
      inset_x: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'inset-x' },
      inset_y: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'inset-y' },
      isolation: { values: proc { ViewComponentUI.config.theme.isolation }, token: 'isolation' },
      justify_content: { values: proc { ViewComponentUI.config.theme.justify_content }, token: 'justify' },
      justify_items: { values: proc { ViewComponentUI.config.theme.justify_items }, token: 'justify' },
      justify_self: { values: proc { ViewComponentUI.config.theme.justify_self }, token: 'justify' },
      left: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'left' },
      letter_spacing: { values: proc { ViewComponentUI.config.theme.letter_spacing }, token: 'tracking' },
      line_height: { values: proc { ViewComponentUI.config.theme.line_height }, token: 'leading' },
      list_style_image: { values: proc { ViewComponentUI.config.theme.list_style_image }, token: 'list-image' },
      list_style_position: { values: proc { ViewComponentUI.config.theme.list_style_position }, token: 'list' },
      list_style_type: { values: proc { ViewComponentUI.config.theme.list_style_type }, token: 'list' },
      margin_bottom: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'mb', alias: :mb },
      margin_end: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'me', alias: :me },
      margin_left: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'ml', alias: :ml },
      margin_right: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'mr', alias: :mr },
      margin_start: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'ms', alias: :ms },
      margin_top: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'mt', alias: :mt },
      margin_x: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'mx', alias: :mx },
      margin_y: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'my', alias: :my },
      margin: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'm', alias: :m },
      max_height: { values: SIZES, token: 'max-h', alias: :max_h },
      max_width: { values: SIZES, token: 'max-w', alias: :max_w },
      min_height: { values: SIZES, token: 'min-h', alias: :min_h },
      min_width: { values: SIZES, token: 'min-w', alias: :min_w },
      mix_blend_mode: { values: proc { ViewComponentUI.config.theme.mix_blend_mode }, token: 'mix-blend' },
      object_fit: { values: proc { ViewComponentUI.config.theme.object_fit }, token: 'object' },
      object_position: { values: proc { ViewComponentUI.config.theme.object_position }, token: 'object' },
      opacity: { values: proc { ViewComponentUI.config.theme.opacity }, token: 'opacity' },
      order: { values: proc { ViewComponentUI.config.theme.order }, token: 'order' },
      outline_color: { values: COLOR_WITH_WEIGHTS, token: 'outline' },
      outline_style: { values: proc { ViewComponentUI.config.theme.outline_style }, token: 'outline', alias: :outline },
      outline_width: { values: proc { ViewComponentUI.config.theme.outline_width }, token: 'outline' },
      overflow: { values: proc { ViewComponentUI.config.theme.overflow }, token: 'overflow' },
      overflow_x: { values: proc { ViewComponentUI.config.theme.overflow }, token: 'overflow-x' },
      overflow_y: { values: proc { ViewComponentUI.config.theme.overflow }, token: 'overflow-y' },
      padding: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'p', alias: :p },
      padding_bottom: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'pb', alias: :pb },
      padding_left: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'pl', alias: :pl },
      padding_right: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'pr', alias: :pr },
      padding_top: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'pt', alias: :pt },
      padding_x: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'px', alias: :px },
      padding_y: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'py', alias: :py },
      place_items: { values: proc { ViewComponentUI.config.theme.place_items }, token: 'place' },
      place_self: { values: proc { ViewComponentUI.config.theme.place_self }, token: 'place' },
      pointer_events: { values: proc { ViewComponentUI.config.theme.pointer_events }, token: 'pointer' },
      position: { values: proc { ViewComponentUI.config.theme.position }, token: nil },
      resize: { values: proc { ViewComponentUI.config.theme.resize }, token: 'resize' },
      right: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'right' },
      rotate: { values: proc { ViewComponentUI.config.theme.rotate }, token: 'rotate' },
      row_gap: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'gap' },
      row_span: { values: proc { ViewComponentUI.config.theme.row_span }, token: 'row-span' },
      row_start: { values: proc { ViewComponentUI.config.theme.row_start }, token: 'row-start' },
      row_end: { values: proc { ViewComponentUI.config.theme.row_end }, token: 'row-end' },
      scale: { values: proc { ViewComponentUI.config.theme.scale }, token: 'scale' },
      scale_x: { values: proc { ViewComponentUI.config.theme.scale }, token: 'scale-x' },
      scale_y: { values: proc { ViewComponentUI.config.theme.scale }, token: 'scale-y' },
      scroll_behavior: { values: proc { ViewComponentUI.config.theme.scroll_behavior }, token: 'scroll' },
      scroll_margin_bottom: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-mb' },
      scroll_margin_left: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-ml' },
      scroll_margin_right: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-mr' },
      scroll_margin_top: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-mt' },
      scroll_margin_x: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-mx' },
      scroll_margin_y: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-my' },
      scroll_margin_start: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-ms' },
      scroll_margin_end: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-me' },
      scroll_padding_bottom: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-pb' },
      scroll_padding_left: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-pl' },
      scroll_padding_right: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-pr' },
      scroll_padding_top: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-pt' },
      scroll_padding_x: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-px' },
      scroll_padding_y: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-py' },
      scroll_padding_start: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-ps' },
      scroll_padding_end: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'scroll-pe' },
      scroll_snap_align: { values: proc { ViewComponentUI.config.theme.scroll_snap_align }, token: 'snap' },
      scroll_snap_stop: { values: proc { ViewComponentUI.config.theme.scroll_snap_stop }, token: 'snap' },
      scroll_snap_type: { values: proc { ViewComponentUI.config.theme.scroll_snap_type }, token: 'snap' },
      start: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'start' },
      table_layout: { values: proc { ViewComponentUI.config.theme.table_layout }, token: 'table' },
      text_align: { values: proc { ViewComponentUI.config.theme.text_align }, token: 'text' },
      text_decoration_color: { values: COLOR_WITH_WEIGHTS, token: 'decoration' },
      text_decoration_style: { values: proc { ViewComponentUI.config.theme.text_decoration_style }, token: 'decoration' },
      text_decoration_thickness: { values: proc { ViewComponentUI.config.theme.text_decoration_thickness }, token: 'decoration' },
      text_decoration: { values: proc { ViewComponentUI.config.theme.text_decoration }, token: proc { _1 } },
      text_indent: { values: proc { ViewComponentUI.config.theme.spacing }, token: 'indent' },
      text_overflow: { values: proc { ViewComponentUI.config.theme.text_overflow }, token: proc { |v| v == 'truncate' ? 'truncate' : "text-#{v}" } },
      text_transform: { values: proc { ViewComponentUI.config.theme.text_transform }, token: nil },
      text_underline_offset: { values: proc { ViewComponentUI.config.theme.text_underline_offset }, token: 'underline-offset' },
      top: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'top' },
      transform_origin: { values: proc { ViewComponentUI.config.theme.transform_origin }, token: 'origin' },
      transition: { values: proc { ViewComponentUI.config.theme.transition }, token: 'transition' },
      user_select: { values: proc { ViewComponentUI.config.theme.user_select }, token: 'select' },
      vertical_align: { values: proc { ViewComponentUI.config.theme.vertical_align }, token: 'align' },
      visibility: { values: proc { ViewComponentUI.config.theme.visibility }, token: nil },
      whitespace: { values: proc { ViewComponentUI.config.theme.whitespace }, token: 'whitespace', alias: :white_space },
      width: { values: proc { ViewComponentUI.config.theme.sizes }, token: 'w', alias: :w },
      will_change: { values: proc { ViewComponentUI.config.theme.will_change }, token: 'will-change' },
      word_break: { values: proc { ViewComponentUI.config.theme.word_break }, token: 'break' },
      z_index: { values: proc { ViewComponentUI.config.theme.z_index }, token: 'z', alias: :z },
    }.freeze                       
  end
end
