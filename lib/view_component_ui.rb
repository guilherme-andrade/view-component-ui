# frozen_string_literal: true

require 'view_component_ui/version'
require 'view_component_ui/engine'
require 'view_component_ui/style_options'
require 'dry/configurable'

module ViewComponentUI
  extend Dry::Configurable

  include StyleOptions

  setting :output_path, default: proc { Engine.root.join('tmp/view_component_ui/compiler') }
  setting :breakpoints, default: BREAKPOINTS
  setting :pseudo_classes, default: PSEUDO_CLASSES
  setting :pseudo_elements, default: PSEUDO_ELEMENTS
  setting :content, default: proc {
                               [
                                 Rails.root.join('app/components'),
                                 Rails.root.join('app/views'),
                                 Engine.root.join('app/components'),
                                 Engine.root.join('app/views')
                               ]
                             }

  setting :theme do # rubocop:disable Metrics/BlockLength
    setting :border_radiuses, reader: true, default: BORDER_RADIUSES
    setting :background_size, reader: true, default: BACKGROUND_SIZE
    setting :border_radius, reader: true, default: BORDER_RADIUS
    setting :spacing, reader: true, default: SPACING
    setting :border_width, reader: true, default: BORDER_WIDTH
    setting :box_decoration_break, reader: true, default: BOX_DECORATION_BREAK
    setting :box_shadow, reader: true, default: BOX_SHADOW
    setting :box_sizing, reader: true, default: BOX_SIZING
    setting :caption_side, reader: true, default: CAPTION_SIDE
    setting :clear, reader: true, default: CLEAR
    setting :colors, reader: true, default: COLORS
    setting :color_scheme, reader: true, default: COLOR_SCHEME
    setting :columns, reader: true, default: COLUMNS
    setting :column_span, reader: true, default: COLUMN_SPAN
    setting :column_start, reader: true, default: COLUMN_START
    setting :column_end, reader: true, default: COLUMN_END
    setting :content, reader: true, default: CONTENT
    setting :cursor, reader: true, default: CURSOR
    setting :empty_cells, reader: true, default: EMPTY_CELLS
    setting :flex_basis, reader: true, default: FLEX_BASIS
    setting :flex_direction, reader: true, default: FLEX_DIRECTION
    setting :flex_grow, reader: true, default: FLEX_GROW
    setting :flex_shrink, reader: true, default: FLEX_SHRINK
    setting :flex_wrap, reader: true, default: FLEX_WRAP
    setting :flex, reader: true, default: FLEX
    setting :font_family, reader: true, default: FONT_FAMILY
    setting :font_size, reader: true, default: FONT_SIZE
    setting :font_style, reader: true, default: FONT_STYLE
    setting :font_variant_numeric, reader: true, default: FONT_VARIANT_NUMERIC
    setting :font_weight, reader: true, default: FONT_WEIGHT
    setting :grid_auto_columns, reader: true, default: GRID_AUTO_COLUMNS
    setting :grid_auto_flow, reader: true, default: GRID_AUTO_FLOW
    setting :grid_auto_rows, reader: true, default: GRID_AUTO_ROWS
    setting :grid_template_columns, reader: true, default: GRID_TEMPLATE_COLUMNS
    setting :grid_template_rows, reader: true, default: GRID_TEMPLATE_ROWS
    setting :sizes, reader: true, default: SIZES
    setting :hyphens, reader: true, default: HYPHENS
    setting :isolation, reader: true, default: ISOLATION
    setting :justify_content, reader: true, default: JUSTIFY_CONTENT
    setting :justify_items, reader: true, default: JUSTIFY_ITEMS
    setting :justify_self, reader: true, default: JUSTIFY_SELF
    setting :letter_spacing, reader: true, default: LETTER_SPACING
    setting :line_height, reader: true, default: LINE_HEIGHT
    setting :list_style_image, reader: true, default: LIST_STYLE_IMAGE
    setting :list_style_position, reader: true, default: LIST_STYLE_POSITION
    setting :list_style_type, reader: true, default: LIST_STYLE_TYPE
    setting :mix_blend_mode, reader: true, default: MIX_BLEND_MODE
    setting :object_fit, reader: true, default: OBJECT_FIT
    setting :object_position, reader: true, default: OBJECT_POSITION
    setting :opacity, reader: true, default: OPACITY
    setting :order, reader: true, default: ORDER
    setting :outline_style, reader: true, default: OUTLINE_STYLE
    setting :outline_width, reader: true, default: OUTLINE_WIDTH
    setting :overflow, reader: true, default: OVERFLOW
    setting :place_items, reader: true, default: PLACE_ITEMS
    setting :place_self, reader: true, default: PLACE_SELF
    setting :pointer_events, reader: true, default: POINTER_EVENTS
    setting :position, reader: true, default: POSITION
    setting :resize, reader: true, default: RESIZE
    setting :rotate, reader: true, default: ROTATE
    setting :row_span, reader: true, default: ROW_SPAN
    setting :row_start, reader: true, default: ROW_START
    setting :row_end, reader: true, default: ROW_END
    setting :scale, reader: true, default: SCALE
    setting :scroll_behavior, reader: true, default: SCROLL_BEHAVIOR
    setting :scroll_snap_align, reader: true, default: SCROLL_SNAP_ALIGN
    setting :scroll_snap_stop, reader: true, default: SCROLL_SNAP_STOP
    setting :scroll_snap_type, reader: true, default: SCROLL_SNAP_TYPE
    setting :table_layout, reader: true, default: TABLE_LAYOUT
    setting :text_align, reader: true, default: TEXT_ALIGN
    setting :text_decoration, reader: true, default: TEXT_DECORATION
    setting :text_decoration_style, reader: true, default: TEXT_DECORATION_STYLE
    setting :text_decoration_thickness, reader: true, default: TEXT_DECORATION_THICKNESS
    setting :text_overflow, reader: true, default: TEXT_OVERFLOW
    setting :text_transform, reader: true, default: TEXT_TRANSFORM
    setting :text_underline_offset, reader: true, default: TEXT_UNDERLINE_OFFSET
    setting :transform_origin, reader: true, default: TRANSFORM_ORIGIN
    setting :transition, reader: true, default: TRANSITION
    setting :user_select, reader: true, default: USER_SELECT
    setting :vertical_align, reader: true, default: VERTICAL_ALIGN
    setting :visibility, reader: true, default: VISIBILITY
    setting :whitespace, reader: true, default: WHITESPACE
    setting :will_change, reader: true, default: WILL_CHANGE
    setting :word_break, reader: true, default: WORD_BREAK
    setting :z_index, reader: true, default: Z_INDEX
  end
end
