require 'active_support/core_ext/hash/indifferent_access'

module ViewComponentUI
  module StyleProperties # rubocop:disable Metrics/ModuleLength
    COLOR_WEIGHTS = ([nil] + %i[50 100 200 300 400 500 600 700 800 900]).freeze
    BREAKPOINTS = %i[sm md lg xl 2xl].freeze
    PSEUDO_CLASSES = %i[hover focus active visited disabled first-child last-child first-of-type last-of-type
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
    BORDER_RADIUS = %i[none sm true md lg xl 2xl 3xl full].freeze
    SPACING = %i[0 px 0.5 1 1.5 2 2.5 3 3.5 4 5 6 7 8 9 10 11 12 14 16 20 24 28 32 36 40 44 48 52 56 60 64 72
                 80 96 auto].freeze
    BORDER_STYLE = %i[solid dashed dotted double none].freeze
    BORDER = [true, false].freeze
    BORDER_WIDTH = %i[0 1 2 4 8].freeze
    BOX_DECORATION_BREAK = %i[slice clone].freeze
    BOX_SHADOW = (%i[sm md lg xl 2xl inner none] + [:true]).freeze
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
    FLEX_DIRECTION = %i[row row-reverse column column-reverse].freeze
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
  end
end
