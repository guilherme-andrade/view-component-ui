require 'dry/schema'

module ViewComponentUI
  module StyleProperties
    module Schemas
      COLOR_WITH_WEIGHTS = ViewComponentUI.config.theme.colors.map do |color|
        COLOR_WEIGHTS.map { |weight| [color, weight].compact.join('-') }
      end.flatten.freeze

      STYLE_PROPERTY_MAP = {
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
        background_size: { values: ViewComponentUI.config.theme.background_size, token: 'bg' },
        border_bottom_left_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-bl' },
        border_bottom_right_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-br' },
        border_top_left_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-tl' },
        border_top_right_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-tr' },
        border_top_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-t' },
        border_bottom_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-b' },
        border_left_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-l' },
        border_right_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded-r' },
        border_collapse: { values: BORDER_COLLAPSE, token: 'border' },
        border_color: { values: COLOR_WITH_WEIGHTS, token: 'border' },
        border_radius: { values: ViewComponentUI.config.theme.border_radius, token: 'rounded', alias: :rounded },
        border_spacing: { values: ViewComponentUI.config.theme.spacing, token: 'border-spacing' },
        border_spacing_x: { values: ViewComponentUI.config.theme.spacing, token: 'border-spacing-x' },
        border_spacing_y: { values: ViewComponentUI.config.theme.spacing, token: 'border-spacing-y' },
        border_style: { values: BORDER_STYLE, token: 'border' },
        border: { values: BORDER, token: 'border' },
        border_width: { values: ViewComponentUI.config.theme.border_width, token: 'border' },
        bottom: { values: ViewComponentUI.config.theme.sizes, token: 'bottom' },
        box_decoration_break: { values: BOX_DECORATION_BREAK, token: 'box-decoration-break' },
        box_shadow: { values: ViewComponentUI.config.theme.box_shadow, token: 'shadow', alias: :shadow },
        box_sizing: { values: ViewComponentUI.config.theme.box_sizing, token: 'box' },
        caption_side: { values: ViewComponentUI.config.theme.caption_side, token: 'caption' },
        clear: { values: ViewComponentUI.config.theme.clear, token: 'clear' },
        color: { values: COLOR_WITH_WEIGHTS, token: 'text' },
        column_gap: { values: ViewComponentUI.config.theme.spacing, token: 'gap' },
        column_span: { values: ViewComponentUI.config.theme.column_span, token: 'col-span', alias: :col_span },
        column_start: { values: ViewComponentUI.config.theme.column_start, token: 'col-start', alias: :col_start },
        column_end: { values: ViewComponentUI.config.theme.column_end, token: 'col-end', alias: :col_end },
        columns: { values: ViewComponentUI.config.theme.columns, token: 'col' },
        _content: { values: ViewComponentUI.config.theme.content, token: 'content' },
        cursor: { values: ViewComponentUI.config.theme.cursor, token: 'cursor' },
        display: { values: DISPLAY, token: nil },
        empty_cells: { values: ViewComponentUI.config.theme.empty_cells, token: 'empty' },
        end: { values: ViewComponentUI.config.theme.sizes, token: 'end' },
        fill: { values: COLOR_WITH_WEIGHTS, token: 'fill' },
        flex_basis: { values: ViewComponentUI.config.theme.flex_basis, token: 'flex' },
        flex_direction: { values: ViewComponentUI.config.theme.flex_direction, token: 'flex' },
        flex_grow: { values: ViewComponentUI.config.theme.flex_grow, token: 'flex' },
        flex_shrink: { values: ViewComponentUI.config.theme.flex_shrink, token: 'flex' },
        flex_wrap: { values: ViewComponentUI.config.theme.flex_wrap, token: 'flex' },
        flex: { values: ViewComponentUI.config.theme.flex, token: 'flex' },
        font_family: { values: ViewComponentUI.config.theme.font_family, token: 'font' },
        font_size: { values: ViewComponentUI.config.theme.font_size, token: 'text' },
        font_style: { values: ViewComponentUI.config.theme.font_style, token: nil },
        font_variant_numeric: { values: ViewComponentUI.config.theme.font_variant_numeric, token: nil },
        font_weight: { values: ViewComponentUI.config.theme.font_weight, token: 'font' },
        grid_auto_columns: { values: ViewComponentUI.config.theme.grid_auto_columns, token: 'auto-cols' },
        grid_auto_flow: { values: ViewComponentUI.config.theme.grid_auto_flow, token: 'grid-flow' },
        grid_auto_rows: { values: ViewComponentUI.config.theme.grid_auto_rows, token: 'auto-rows' },
        grid_gap: { values: ViewComponentUI.config.theme.spacing, token: 'gap' },
        grid_gap_x: { values: ViewComponentUI.config.theme.spacing, token: 'gap-x' },
        grid_gap_y: { values: ViewComponentUI.config.theme.spacing, token: 'gap-y' },
        grid_template_columns: { values: ViewComponentUI.config.theme.grid_template_columns, token: 'grid-cols' },
        grid_template_rows: { values: ViewComponentUI.config.theme.grid_template_rows, token: 'grid-rows' },
        height: { values: ViewComponentUI.config.theme.sizes, token: 'h', alias: :h },
        hyphens: { values: ViewComponentUI.config.theme.hyphens, token: 'hyphens' },
        inset: { values: ViewComponentUI.config.theme.sizes, token: 'inset' },
        inset_x: { values: ViewComponentUI.config.theme.sizes, token: 'inset-x' },
        inset_y: { values: ViewComponentUI.config.theme.sizes, token: 'inset-y' },
        isolation: { values: ViewComponentUI.config.theme.isolation, token: 'isolation' },
        justify_content: { values: ViewComponentUI.config.theme.justify_content, token: 'justify' },
        justify_items: { values: ViewComponentUI.config.theme.justify_items, token: 'justify' },
        justify_self: { values: ViewComponentUI.config.theme.justify_self, token: 'justify' },
        left: { values: ViewComponentUI.config.theme.sizes, token: 'left' },
        letter_spacing: { values: ViewComponentUI.config.theme.letter_spacing, token: 'tracking' },
        line_height: { values: ViewComponentUI.config.theme.line_height, token: 'leading' },
        list_style_image: { values: ViewComponentUI.config.theme.list_style_image, token: 'list-image' },
        list_style_position: { values: ViewComponentUI.config.theme.list_style_position, token: 'list' },
        list_style_type: { values: ViewComponentUI.config.theme.list_style_type, token: 'list' },
        margin_bottom: { values: ViewComponentUI.config.theme.spacing, token: 'mb', alias: :mb },
        margin_end: { values: ViewComponentUI.config.theme.spacing, token: 'me', alias: :me },
        margin_left: { values: ViewComponentUI.config.theme.spacing, token: 'ml', alias: :ml },
        margin_right: { values: ViewComponentUI.config.theme.spacing, token: 'mr', alias: :mr },
        margin_start: { values: ViewComponentUI.config.theme.spacing, token: 'ms', alias: :ms },
        margin_top: { values: ViewComponentUI.config.theme.spacing, token: 'mt', alias: :mt },
        margin_x: { values: ViewComponentUI.config.theme.spacing, token: 'mx', alias: :mx },
        margin_y: { values: ViewComponentUI.config.theme.spacing, token: 'my', alias: :my },
        margin: { values: ViewComponentUI.config.theme.spacing, token: 'm', alias: :m },
        max_height: { values: MAX_SIZE, token: 'max-h', alias: :max_h },
        max_width: { values: MAX_SIZE, token: 'max-w', alias: :max_w },
        min_height: { values: MIN_SIZE, token: 'min-h', alias: :min_h },
        min_width: { values: MIN_SIZE, token: 'min-w', alias: :min_w },
        mix_blend_mode: { values: ViewComponentUI.config.theme.mix_blend_mode, token: 'mix-blend' },
        object_fit: { values: ViewComponentUI.config.theme.object_fit, token: 'object' },
        object_position: { values: ViewComponentUI.config.theme.object_position, token: 'object' },
        opacity: { values: ViewComponentUI.config.theme.opacity, token: 'opacity' },
        order: { values: ViewComponentUI.config.theme.order, token: 'order' },
        outline_color: { values: COLOR_WITH_WEIGHTS, token: 'outline' },
        outline_style: { values: ViewComponentUI.config.theme.outline_style, token: 'outline', alias: :outline },
        outline_width: { values: ViewComponentUI.config.theme.outline_width, token: 'outline' },
        overflow: { values: ViewComponentUI.config.theme.overflow, token: 'overflow' },
        overflow_x: { values: ViewComponentUI.config.theme.overflow, token: 'overflow-x' },
        overflow_y: { values: ViewComponentUI.config.theme.overflow, token: 'overflow-y' },
        padding: { values: ViewComponentUI.config.theme.spacing, token: 'p', alias: :p },
        padding_bottom: { values: ViewComponentUI.config.theme.spacing, token: 'pb', alias: :pb },
        padding_left: { values: ViewComponentUI.config.theme.spacing, token: 'pl', alias: :pl },
        padding_right: { values: ViewComponentUI.config.theme.spacing, token: 'pr', alias: :pr },
        padding_top: { values: ViewComponentUI.config.theme.spacing, token: 'pt', alias: :pt },
        padding_x: { values: ViewComponentUI.config.theme.spacing, token: 'px', alias: :px },
        padding_y: { values: ViewComponentUI.config.theme.spacing, token: 'py', alias: :py },
        place_items: { values: ViewComponentUI.config.theme.place_items, token: 'place' },
        place_self: { values: ViewComponentUI.config.theme.place_self, token: 'place' },
        pointer_events: { values: ViewComponentUI.config.theme.pointer_events, token: 'pointer' },
        position: { values: ViewComponentUI.config.theme.position, token: nil },
        resize: { values: ViewComponentUI.config.theme.resize, token: 'resize' },
        right: { values: ViewComponentUI.config.theme.sizes, token: 'right' },
        rotate: { values: ViewComponentUI.config.theme.rotate, token: 'rotate' },
        row_gap: { values: ViewComponentUI.config.theme.spacing, token: 'gap' },
        row_span: { values: ViewComponentUI.config.theme.row_span, token: 'row-span' },
        row_start: { values: ViewComponentUI.config.theme.row_start, token: 'row-start' },
        row_end: { values: ViewComponentUI.config.theme.row_end, token: 'row-end' },
        scale: { values: ViewComponentUI.config.theme.scale, token: 'scale' },
        scale_x: { values: ViewComponentUI.config.theme.scale, token: 'scale-x' },
        scale_y: { values: ViewComponentUI.config.theme.scale, token: 'scale-y' },
        scroll_behavior: { values: ViewComponentUI.config.theme.scroll_behavior, token: 'scroll' },
        scroll_margin_bottom: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-mb' },
        scroll_margin_left: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-ml' },
        scroll_margin_right: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-mr' },
        scroll_margin_top: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-mt' },
        scroll_margin_x: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-mx' },
        scroll_margin_y: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-my' },
        scroll_margin_start: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-ms' },
        scroll_margin_end: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-me' },
        scroll_padding_bottom: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-pb' },
        scroll_padding_left: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-pl' },
        scroll_padding_right: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-pr' },
        scroll_padding_top: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-pt' },
        scroll_padding_x: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-px' },
        scroll_padding_y: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-py' },
        scroll_padding_start: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-ps' },
        scroll_padding_end: { values: ViewComponentUI.config.theme.spacing, token: 'scroll-pe' },
        scroll_snap_align: { values: ViewComponentUI.config.theme.scroll_snap_align, token: 'snap' },
        scroll_snap_stop: { values: ViewComponentUI.config.theme.scroll_snap_stop, token: 'snap' },
        scroll_snap_type: { values: ViewComponentUI.config.theme.scroll_snap_type, token: 'snap' },
        start: { values: ViewComponentUI.config.theme.sizes, token: 'start' },
        table_layout: { values: ViewComponentUI.config.theme.table_layout, token: 'table' },
        text_align: { values: ViewComponentUI.config.theme.text_align, token: 'text' },
        text_decoration_color: { values: COLOR_WITH_WEIGHTS, token: 'decoration' },
        text_decoration_style: { values: ViewComponentUI.config.theme.text_decoration_style, token: 'decoration' },
        text_decoration_thickness: { values: ViewComponentUI.config.theme.text_decoration_thickness, token: 'decoration' },
        text_decoration: { values: ViewComponentUI.config.theme.text_decoration, token: 'decoration' },
        text_indent: { values: ViewComponentUI.config.theme.spacing, token: 'indent' },
        text_overflow: { values: ViewComponentUI.config.theme.text_overflow, token: proc { |v| v == 'truncate' ? 'truncate' : "text-#{v}" } },
        text_transform: { values: ViewComponentUI.config.theme.text_transform, token: nil },
        text_underline_offset: { values: ViewComponentUI.config.theme.text_underline_offset, token: 'underline-offset' },
        top: { values: ViewComponentUI.config.theme.sizes, token: 'top' },
        transform_origin: { values: ViewComponentUI.config.theme.transform_origin, token: 'origin' },
        transition: { values: ViewComponentUI.config.theme.transition, token: 'transition' },
        user_select: { values: ViewComponentUI.config.theme.user_select, token: 'select' },
        vertical_align: { values: ViewComponentUI.config.theme.vertical_align, token: 'align' },
        visibility: { values: ViewComponentUI.config.theme.visibility, token: nil },
        whitespace: { values: ViewComponentUI.config.theme.whitespace, token: 'whitespace', alias: :white_space },
        width: { values: ViewComponentUI.config.theme.sizes, token: 'w', alias: :w },
        will_change: { values: ViewComponentUI.config.theme.will_change, token: 'will-change' },
        word_break: { values: ViewComponentUI.config.theme.word_break, token: 'break' },
        z_index: { values: ViewComponentUI.config.theme.z_index, token: 'z', alias: :z },
      }.freeze

      PropertySchema = Dry::Schema.Params do
        STYLE_PROPERTY_MAP.each do |name, options|
          optional(name).value(included_in?: options[:values])
          optional(options[:alias]).value(included_in?: options[:values]) if options[:alias]
        end
      end

      BreakpointSchema = Dry::Schema.Params do
        (ViewComponentUI.config.breakpoints + [:xs]).each do |bp|
          optional(bp.to_sym).hash(PropertySchema)
        end
      end

      PseudoElementSchema = Dry::Schema.Params do
        ViewComponentUI.config.pseudo_elements.each do |pc|
          optional(:"_#{pc}").hash(BreakpointSchema)
        end
      end

      PseudoClassSchema = Dry::Schema.Params do
        ViewComponentUI.config.pseudo_classes.each do |pc|
          optional(:"_#{pc}").hash(PropertySchema.merge(BreakpointSchema).merge(PseudoElementSchema))
        end
      end

      StylePropertySchema = [PropertySchema, BreakpointSchema, PseudoElementSchema, PseudoClassSchema].reduce(&:merge)
    end
  end
end
