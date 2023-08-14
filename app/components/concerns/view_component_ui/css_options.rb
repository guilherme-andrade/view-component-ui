module ViewComponentUI
  module CSSOptions # rubocop:disable Metrics/ModuleLength
    extend ActiveSupport::Concern

    class_methods do
      def utility_property(name, *args)
        options = args.extract_options!

        type = Types::Coercible::String.enum(*options[:options])
                                       .optional
                                       .meta(class: options[:class])
        option name, type, **options
        utility_properties.concat([name, options[:alias]].compact)
      end

      def utility_properties
        @utility_properties ||= []
      end
    end

    DEFINE_CSS_PROPERTIES = proc do # rubocop:disable Metrics/BlockLength
      utility_property :align_content, options: ALIGN_CONTENT, class: proc { |v| "content-#{v}" }
      utility_property :align_items, options: ALIGN_ITEMS, class: proc { |v| "items-#{v}" }
      utility_property :backface_visibility, options: BACKFACE_VISIBILITY, class: proc { |v| "backface-#{v}" }
      utility_property :background, options: BACKGROUND_COLOR, class: proc { |v| "bg-#{v}" }
      utility_property :background_attachment, options: BACKGROUND_ATTACHMENT, class: proc { |v| "bg-#{v}" }
      utility_property :background_blend_mode, options: BACKGROUND_BLEND_MODE, class: proc { |v| "bg-#{v}" }
      utility_property :background_clip, options: BACKGROUND_CLIP, class: proc { |v| "bg-#{v}" }
      utility_property :background_color, options: BACKGROUND_COLOR, class: proc { |v| "bg-#{v}" }
      utility_property :background_image, options: BACKGROUND_IMAGE, class: proc { |v| "bg-#{v}" }
      utility_property :background_origin, options: BACKGROUND_ORIGIN, class: proc { |v| "bg-#{v}" }
      utility_property :background_position, options: BACKGROUND_POSITION, class: proc { |v| "bg-#{v}" }
      utility_property :background_repeat, options: BACKGROUND_REPEAT, class: proc { |v| "bg-#{v}" }
      utility_property :background_size, options: BACKGROUND_SIZE, class: proc { |v| "bg-#{v}" }
      utility_property :border_bottom_left_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-bl-#{v}" }
      utility_property :border_bottom_right_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-br-#{v}" }
      utility_property :border_top_left_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-tl-#{v}" }
      utility_property :border_top_right_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-tr-#{v}" }
      utility_property :border_top_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-t-#{v}" }
      utility_property :border_bottom_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-b-#{v}" }
      utility_property :border_left_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-l-#{v}" }
      utility_property :border_right_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-r-#{v}" }
      utility_property :border_collapse, options: BORDER_COLLAPSE, class: proc { |v| "border-#{v}" }
      utility_property :border_color, options: BORDER_COLOR, class: proc { |v| "border-#{v}" }
      utility_property :border_image_outset, options: BORDER_IMAGE_OUTSET, class: proc { |v| "border-#{v}" }
      utility_property :border_radius, options: BORDER_RADIUSES, class: proc { |v| "rounded-#{v}" }
      utility_property :border_spacing, options: BORDER_SPACING, class: proc { |v| "border-spacing-#{v}" }
      utility_property :border_style, options: BORDER_STYLE, class: proc { |v| "border-#{v}" }
      utility_property :border_width, options: BORDER_WIDTH, class: proc { |v| "border-#{v}" }
      utility_property :bottom, options: BORDER_WIDTH, class: proc { |v| "bottom-#{v}" }
      utility_property :box_decoration_break, options: BOX_DECORATION_BREAK, class: proc { |v|
                                                                                      "box-decoration-break-#{v}"
                                                                                    }
      utility_property :box_shadow, options: BOX_SHADOW, class: proc { |v| "shadow-#{v}" }
      utility_property :box_sizing, options: BOX_SIZING, class: proc { |v| "box-#{v}" }
      utility_property :caption_side, options: CAPTION_SIDE, class: proc { |v| "caption-#{v}" }
      utility_property :clear, options: CLEAR, class: proc { |v| "clear-#{v}" }
      utility_property :color, options: COLOR, class: proc { |v| "text-#{v}" }
      utility_property :column_gap, options: COLUMN_GAP, class: proc { |v| "gap-#{v}" }
      utility_property :column_span, alias: :col_span, options: COLUMN_SPAN, class: proc { |v| "col-span-#{v}" }
      utility_property :columns, options: COLUMNS, class: proc { |v| "col-#{v}" }
      utility_property :_content, options: CONTENT, class: proc { |v| "content-#{v}" }
      utility_property :cursor, options: CURSOR, class: proc { |v| "cursor-#{v}" }
      utility_property :display, options: DISPLAY, class: proc { |v| v }
      utility_property :empty_cells, options: EMPTY_CELLS, class: proc { |v| "empty-#{v}" }
      utility_property :fill, options: FILL, class: proc { |v| "fill-#{v}" }
      utility_property :filter, options: FILTER, class: proc { |v| "filter-#{v}" }
      utility_property :flex_basis, options: FLEX_BASIS, class: proc { |v| "flex-#{v}" }
      utility_property :flex_direction, options: FLEX_DIRECTION, class: proc { |v| "flex-#{v}" }
      utility_property :flex_grow, options: FLEX_GROW, class: proc { |v| "flex-#{v}" }
      utility_property :flex_shrink, options: FLEX_SHRINK, class: proc { |v| "flex-#{v}" }
      utility_property :flex_wrap, options: FLEX_WRAP, class: proc { |v| "flex-#{v}" }
      utility_property :flex, options: FLEX, class: proc { |v| "flex-#{v}" }
      utility_property :font_family, options: FONT_FAMILY, class: proc { |v| "font-#{v}" }
      utility_property :font_size, options: FONT_SIZE, class: proc { |v| "text-#{v}" }
      utility_property :font_style, options: FONT_STYLE, class: proc { |v| v }
      utility_property :font_variant_numeric, options: FONT_VARIANT_NUMERIC, class: proc { |v| v }
      utility_property :font_weight, options: FONT_WEIGHT, class: proc { |v| "font-#{v}" }
      utility_property :grid_auto_columns, options: GRID_AUTO_COLUMNS, class: proc { |v| "auto-cols-#{v}" }
      utility_property :grid_auto_flow, options: GRID_AUTO_FLOW, class: proc { |v| "grid-flow-#{v}" }
      utility_property :grid_auto_rows, options: GRID_AUTO_ROWS, class: proc { |v| "auto-rows-#{v}" }
      utility_property :grid_column, options: GRID_COLUMN, class: proc { |v| "col-#{v}" }
      utility_property :grid_gap, options: GRID_GAP, class: proc { |v| "gap-#{v}" }
      utility_property :grid_row, options: GRID_ROW, class: proc { |v| "row-#{v}" }
      utility_property :grid_template_columns, options: GRID_TEMPLATE_COLUMNS, class: proc { |v| "grid-cols-#{v}" }
      utility_property :grid_template_rows, options: GRID_TEMPLATE_ROWS, class: proc { |v| "grid-rows-#{v}" }
      utility_property :height, alias: :h, options: HEIGHT, class: proc { |v| "h-#{v}" }
      utility_property :hyphens, options: HYPHENS, class: proc { |v| "hyphens-#{v}" }
      utility_property :isolation, options: ISOLATION, class: proc { |v| "isolation-#{v}" }
      utility_property :justify_content, options: JUSTIFY_CONTENT, class: proc { |v| "justify-#{v}" }
      utility_property :justify_items, options: JUSTIFY_ITEMS, class: proc { |v| "justify-#{v}" }
      utility_property :justify_self, options: JUSTIFY_SELF, class: proc { |v| "justify-#{v}" }
      utility_property :left, options: LEFT, class: proc { |v| "left-#{v}" }
      utility_property :letter_spacing, options: LETTER_SPACING, class: proc { |v| "tracking-#{v}" }
      utility_property :line_height, options: LINE_HEIGHT, class: proc { |v| "leading-#{v}" }
      utility_property :list_style_image, options: LIST_STYLE_IMAGE, class: proc { |v| "list-image-#{v}" }
      utility_property :list_style_position, options: LIST_STYLE_POSITION, class: proc { |v| "list-#{v}" }
      utility_property :list_style_type, options: LIST_STYLE_TYPE, class: proc { |v| "list-#{v}" }
      utility_property :margin_bottom, alias: :mb, options: MARGIN, class: proc { |v| "mb-#{v}" }
      utility_property :margin_left, alias: :ml, options: MARGIN, class: proc { |v| "ml-#{v}" }
      utility_property :margin_right, alias: :mr, options: MARGIN, class: proc { |v| "mr-#{v}" }
      utility_property :margin_top, alias: :mt, options: MARGIN, class: proc { |v| "mt-#{v}" }
      utility_property :margin_x, alias: :mx, options: MARGIN, class: proc { |v| "mx-#{v}" }
      utility_property :margin_y, alias: :my, options: MARGIN, class: proc { |v| "my-#{v}" }
      utility_property :margin, alias: :m, options: MARGIN, class: proc { |v| "m-#{v}" }
      utility_property :max_height, alias: :max_h, options: MAX_HEIGHT, class: proc { |v| "max-h-#{v}" }
      utility_property :max_width, alias: :max_w, options: MAX_WIDTH, class: proc { |v| "max-w-#{v}" }
      utility_property :min_height, alias: :min_h, options: MIN_HEIGHT, class: proc { |v| "min-h-#{v}" }
      utility_property :min_width, alias: :min_w, options: MIN_WIDTH, class: proc { |v| "min-w-#{v}" }
      utility_property :mix_blend_mode, options: MIX_BLEND_MODE, class: proc { |v| "mix-blend-#{v}" }
      utility_property :object_fit, options: OBJECT_FIT, class: proc { |v| "object-#{v}" }
      utility_property :object_position, options: OBJECT_POSITION, class: proc { |v| "object-#{v}" }
      utility_property :opacity, options: OPACITY, class: proc { |v| "opacity-#{v}" }
      utility_property :order, options: ORDER, class: proc { |v| "order-#{v}" }
      utility_property :outline_color, options: OUTLINE_COLOR, class: proc { |v| "outline-#{v}" }
      utility_property :outline_style
      utility_property :outline_width
      utility_property :outline
      utility_property :overflow
      utility_property :padding, alias: :p
      utility_property :padding_bottom, alias: :pb
      utility_property :padding_left, alias: :pl
      utility_property :padding_right, alias: :pr
      utility_property :padding_top, alias: :pt
      utility_property :padding_x, alias: :px
      utility_property :padding_y, alias: :py
      utility_property :perspective_origin
      utility_property :perspective
      utility_property :place_items
      utility_property :place_self
      utility_property :pointer_events
      utility_property :position
      utility_property :quotes
      utility_property :resize
      utility_property :right
      utility_property :rotate
      utility_property :row_gap
      utility_property :scale
      utility_property :scroll_behavior
      utility_property :scroll_margin_bottom
      utility_property :scroll_margin_left
      utility_property :scroll_margin_right
      utility_property :scroll_margin_top
      utility_property :scroll_padding_bottom
      utility_property :scroll_padding_left
      utility_property :scroll_padding_right
      utility_property :scroll_padding_top
      utility_property :scroll_snap_align
      utility_property :scroll_snap_stop
      utility_property :scroll_snap_type
      utility_property :shape_image_threshold
      utility_property :shape_margin
      utility_property :shape_outside
      utility_property :stroke
      utility_property :tab_size
      utility_property :table_layout
      utility_property :text_align_last
      utility_property :text_align
      utility_property :text_combine_upright
      utility_property :text_decoration_color
      utility_property :text_decoration_line
      utility_property :text_decoration_style
      utility_property :text_decoration_thickness
      utility_property :text_decoration
      utility_property :text_indent
      utility_property :text_justify
      utility_property :text_orientation
      utility_property :text_overflow
      utility_property :text_shadow
      utility_property :text_transform
      utility_property :text_underline_position
      utility_property :text_underline_offset
      utility_property :top
      utility_property :transform_box
      utility_property :transform_origin
      utility_property :transform_style
      utility_property :transform
      utility_property :transition_delay
      utility_property :transition_duration
      utility_property :transition_property
      utility_property :transition_timing_function
      utility_property :transition
      utility_property :unicode_bidi
      utility_property :user_select
      utility_property :vertical_align
      utility_property :visibility
      utility_property :white_space
      utility_property :whitespace
      utility_property :widows
      utility_property :width, alias: :w
      utility_property :will_change
      utility_property :word_break
      utility_property :word_spacing
      utility_property :word_wrap
      utility_property :writing_mode
      utility_property :z_index, alias: :z
      utility_property :zoom
    end

    included(&DEFINE_CSS_PROPERTIES)

    def _cl
      super.to_s.split(/\s+/).concat(style_classes).compact
    end

    def style_classes
      STYLE_ATTRIBUTE_TAILWIND_CLASS_TRANSFORMERS.keys.filter_map do |attribute|
        value = send(attribute)
        next if value.nil?

        STYLE_ATTRIBUTE_TAILWIND_CLASS_TRANSFORMERS[attribute].call(value.to_s.dasherize)
      end
    end
  end
end
