module ViewComponentUI
  module CSSOptions # rubocop:disable Metrics/ModuleLength
    extend ActiveSupport::Concern

    included do
      option :align_content, default: proc {}, required: false
      option :align_items, default: proc {}, required: false
      option :backface_visibility, default: proc {}, required: false
      option :background_attachment, default: proc {}, required: false
      option :background_blend_mode, default: proc {}, required: false
      option :background_clip, default: proc {}, required: false
      option :background_color, default: proc {}, required: false
      option :background_image, default: proc {}, required: false
      option :background_origin, default: proc {}, required: false
      option :background_position, default: proc {}, required: false
      option :background_repeat, default: proc {}, required: false
      option :background_size, default: proc {}, required: false
      option :bg, default: proc {}, required: false
      option :border_bottom_left_radius, default: proc {}, required: false
      option :border_bottom_right_radius, default: proc {}, required: false
      option :border_bottom, default: proc {}, required: false
      option :border_collapse, default: proc {}, required: false
      option :border_color, default: proc {}, required: false
      option :border_image_outset, default: proc {}, required: false
      option :border_image_repeat, default: proc {}, required: false
      option :border_image_slice, default: proc {}, required: false
      option :border_image_source, default: proc {}, required: false
      option :border_image_width, default: proc {}, required: false
      option :border_image, default: proc {}, required: false
      option :border_left, default: proc {}, required: false
      option :border_radius, default: proc {}, required: false
      option :border_right, default: proc {}, required: false
      option :border_spacing, default: proc {}, required: false
      option :border_style, default: proc {}, required: false
      option :border_top_left_radius, default: proc {}, required: false
      option :border_top_right_radius, default: proc {}, required: false
      option :border_top, default: proc {}, required: false
      option :border_width, default: proc {}, required: false
      option :border, default: proc {}, required: false
      option :bottom, default: proc {}, required: false
      option :box_decoration_break, default: proc {}, required: false
      option :box_shadow, default: proc {}, required: false
      option :box_sizing, default: proc {}, required: false
      option :caption_side, default: proc {}, required: false
      option :clear, default: proc {}, required: false
      option :clip_path, default: proc {}, required: false
      option :clip, default: proc {}, required: false
      option :color_adjust, default: proc {}, required: false
      option :color, default: proc {}, required: false
      option :column_count, default: proc {}, required: false
      option :column_fill, default: proc {}, required: false
      option :column_gap, default: proc {}, required: false
      option :column_rule_color, default: proc {}, required: false
      option :column_rule_style, default: proc {}, required: false
      option :column_rule_width, default: proc {}, required: false
      option :column_rule, default: proc {}, required: false
      option :column_span, default: proc {}, required: false
      option :column_width, default: proc {}, required: false
      option :columns, default: proc {}, required: false
      option :contain, default: proc {}, required: false
      option :_content, default: proc {}, required: false
      option :counter_increment, default: proc {}, required: false
      option :counter_reset, default: proc {}, required: false
      option :cursor, default: proc {}, required: false
      option :direction, default: proc {}, required: false
      option :display, default: proc {}, required: false
      option :empty_cells, default: proc {}, required: false
      option :fill, default: proc {}, required: false
      option :filter, default: proc {}, required: false
      option :flex_basis, default: proc {}, required: false
      option :flex_direction, default: proc {}, required: false
      option :flex_direction, default: proc {}, required: false
      option :flex_grow, default: proc {}, required: false
      option :flex_shrink, default: proc {}, required: false
      option :flex_wrap, default: proc {}, required: false
      option :flex, default: proc {}, required: false
      option :font_family, default: proc {}, required: false
      option :font_feature_settings, default: proc {}, required: false
      option :font_kerning, default: proc {}, required: false
      option :font_language_override, default: proc {}, required: false
      option :font_size, default: proc {}, required: false
      option :font_stretch, default: proc {}, required: false
      option :font_style, default: proc {}, required: false
      option :font_variant_caps, default: proc {}, required: false
      option :font_variant_east_asian, default: proc {}, required: false
      option :font_variant_ligatures, default: proc {}, required: false
      option :font_variant_numeric, default: proc {}, required: false
      option :font_variant_position, default: proc {}, required: false
      option :font_variant, default: proc {}, required: false
      option :font_weight, default: proc {}, required: false
      option :grid_area, default: proc {}, required: false
      option :grid_auto_columns, default: proc {}, required: false
      option :grid_auto_flow, default: proc {}, required: false
      option :grid_auto_rows, default: proc {}, required: false
      option :grid_column, default: proc {}, required: false
      option :grid_gap, default: proc {}, required: false
      option :grid_row, default: proc {}, required: false
      option :grid_template_columns, default: proc {}, required: false
      option :grid_template_rows, default: proc {}, required: false
      option :grid, default: proc {}, required: false
      option :hanging_punctuation, default: proc {}, required: false
      option :height, default: proc {}, required: false
      option :h, default: proc { height }
      option :hyphens, default: proc {}, required: false
      option :isolation, default: proc {}, required: false
      option :justify_content, default: proc {}, required: false
      option :justify_items, default: proc {}, required: false
      option :justify_self, default: proc {}, required: false
      option :left, default: proc {}, required: false
      option :letter_spacing, default: proc {}, required: false
      option :line_height, default: proc {}, required: false
      option :list_style_image, default: proc {}, required: false
      option :list_style_position, default: proc {}, required: false
      option :list_style_type, default: proc {}, required: false
      option :margin_bottom, default: proc {}, required: false
      option :margin_left, default: proc {}, required: false
      option :margin_right, default: proc {}, required: false
      option :margin_top, default: proc {}, required: false
      option :margin_x, default: proc {}, required: false
      option :margin_y, default: proc {}, required: false
      option :margin, default: proc {}, required: false
      option :m, default: proc { margin }
      option :mask_type, default: proc {}, required: false
      option :mask, default: proc {}, required: false
      option :max_h, default: proc { max_height }
      option :max_height, default: proc {}, required: false
      option :max_w, default: proc { max_width }
      option :max_width, default: proc {}, required: false
      option :mb, default: proc { margin_bottom }
      option :min_h, default: proc {}, required: false
      option :min_w, default: proc {}, required: false
      option :mix_blend_mode, default: proc {}, required: false
      option :ml, default: proc { margin_left }
      option :mr, default: proc { margin_right }
      option :mt, default: proc { margin_top }
      option :mx, default: proc { margin_x }
      option :my, default: proc { margin_y }
      option :object_fit, default: proc {}, required: false
      option :object_position, default: proc {}, required: false
      option :object_position, default: proc {}, required: false
      option :opacity, default: proc {}, required: false
      option :order, default: proc {}, required: false
      option :orphans, default: proc {}, required: false
      option :outline_color, default: proc {}, required: false
      option :outline_style, default: proc {}, required: false
      option :outline_width, default: proc {}, required: false
      option :outline, default: proc {}, required: false
      option :overflow, default: proc {}, required: false
      option :p, default: proc { padding }
      option :padding_bottom, default: proc {}, required: false
      option :padding_left, default: proc {}, required: false
      option :padding_right, default: proc {}, required: false
      option :padding_top, default: proc {}, required: false
      option :padding_x, default: proc {}, required: false
      option :padding_y, default: proc {}, required: false
      option :padding, default: proc {}, required: false
      option :pb, default: proc { padding_bottom }
      option :perspective_origin, default: proc {}, required: false
      option :perspective, default: proc {}, required: false
      option :pl, default: proc { padding_left }
      option :place_items, default: proc {}, required: false
      option :place_self, default: proc {}, required: false
      option :pointer_events, default: proc {}, required: false
      option :position, default: proc {}, required: false
      option :pr, default: proc { padding_right }
      option :pt, default: proc { padding_top }
      option :px, default: proc { padding_x }
      option :py, default: proc { padding_y }
      option :quotes, default: proc {}, required: false
      option :resize, default: proc {}, required: false
      option :right, default: proc {}, required: false
      option :rotate, default: proc {}, required: false
      option :row_gap, default: proc {}, required: false
      option :scale, default: proc {}, required: false
      option :scroll_behavior, default: proc {}, required: false
      option :scroll_margin_bottom, default: proc {}, required: false
      option :scroll_margin_left, default: proc {}, required: false
      option :scroll_margin_right, default: proc {}, required: false
      option :scroll_margin_top, default: proc {}, required: false
      option :scroll_padding_bottom, default: proc {}, required: false
      option :scroll_padding_left, default: proc {}, required: false
      option :scroll_padding_right, default: proc {}, required: false
      option :scroll_padding_top, default: proc {}, required: false
      option :scroll_snap_align, default: proc {}, required: false
      option :scroll_snap_stop, default: proc {}, required: false
      option :scroll_snap_type, default: proc {}, required: false
      option :shape_image_threshold, default: proc {}, required: false
      option :shape_margin, default: proc {}, required: false
      option :shape_outside, default: proc {}, required: false
      option :stroke, default: proc {}, required: false
      option :tab_size, default: proc {}, required: false
      option :table_layout, default: proc {}, required: false
      option :text_align_last, default: proc {}, required: false
      option :text_align, default: proc {}, required: false
      option :text_combine_upright, default: proc {}, required: false
      option :text_decoration_color, default: proc {}, required: false
      option :text_decoration_line, default: proc {}, required: false
      option :text_decoration_style, default: proc {}, required: false
      option :text_decoration_thickness, default: proc {}, required: false
      option :text_decoration, default: proc {}, required: false
      option :text_indent, default: proc {}, required: false
      option :text_justify, default: proc {}, required: false
      option :text_orientation, default: proc {}, required: false
      option :text_overflow, default: proc {}, required: false
      option :text_shadow, default: proc {}, required: false
      option :text_transform, default: proc {}, required: false
      option :text_underline_position, default: proc {}, required: false
      option :text_underline_offset, default: proc {}, required: false
      option :top, default: proc {}, required: false
      option :transform_box, default: proc {}, required: false
      option :transform_origin, default: proc {}, required: false
      option :transform_style, default: proc {}, required: false
      option :transform, default: proc {}, required: false
      option :transition_delay, default: proc {}, required: false
      option :transition_duration, default: proc {}, required: false
      option :transition_property, default: proc {}, required: false
      option :transition_timing_function, default: proc {}, required: false
      option :transition, default: proc {}, required: false
      option :unicode_bidi, default: proc {}, required: false
      option :user_select, default: proc {}, required: false
      option :vertical_align, default: proc {}, required: false
      option :visibility, default: proc {}, required: false
      option :w, default: proc { width }
      option :white_space, default: proc {}, required: false
      option :whitespace, default: proc {}, required: false
      option :widows, default: proc {}, required: false
      option :width, default: proc {}, required: false
      option :will_change, default: proc {}, required: false
      option :word_break, default: proc {}, required: false
      option :word_spacing, default: proc {}, required: false
      option :word_wrap, default: proc {}, required: false
      option :writing_mode, default: proc {}, required: false
      option :z_index, default: proc {}, required: false
      option :zoom, default: proc {}, required: false
    end

    STYLE_ATTRIBUTE_TAILWIND_CLASS_TRANSFORMERS = {
      align_content: proc { |v| "content-#{v.gsub('space-', '')}" },
      align_items: proc { |v| "items-#{v}" },
      backface_visibility: proc { |v| v == 'visible' ? 'backface-visible' : 'backface-hidden' },
      background_attachment: proc { |v| v },
      background_blend_mode: proc { |v| v },
      background_clip: proc { |v| v },
      background_color: proc { |v| "bg-#{v}" },
      background_image: proc { |v| v },
      background_origin: proc { |v| v },
      background_position: proc { |v| v.tr(' ', '-') },
      background_repeat: proc { |v| v == 'no-repeat' ? 'bg-no-repeat' : 'bg-repeat' },
      background_size: proc { |v| v },
      bg: proc { |v| "bg-#{v}" }, # This seems redundant with background_color
      border_bottom_left_radius: proc { |v| "rounded-bl-#{v}" },
      border_bottom_right_radius: proc { |v| "rounded-br-#{v}" },
      border_bottom: proc { |v| "border-b-#{v}" },
      border_collapse: proc { |v| v },
      border_color: proc { |v| "border-#{v}" },
      border_image_outset: proc { |v| v },
      border_image_repeat: proc { |v| v },
      border_image_slice: proc { |v| v },
      border_image_source: proc { |v| v },
      border_image_width: proc { |v| v },
      border_image: proc { |v| v },
      border_left: proc { |v| "border-l-#{v}" },
      border_radius: proc { |v| "rounded-#{v}" },
      border_right: proc { |v| "border-r-#{v}" },
      border_spacing: proc { |v| v },
      border_style: proc { |v| "border-#{v}" },
      border_top_left_radius: proc { |v| "rounded-tl-#{v}" },
      border_top_right_radius: proc { |v| "rounded-tr-#{v}" },
      border_top: proc { |v| "border-t-#{v}" },
      border_width: proc { |v| "border-#{v}" },
      border: proc { |v| "border-#{v}" },
      bottom: proc { |v| "bottom-#{v}" },
      box_decoration_break: proc { |v| v },
      box_shadow: proc { |v| v == 'none' ? 'shadow-none' : "shadow-#{v}" },
      box_sizing: proc { |v| v },
      caption_side: proc { |v| v },
      clear: proc { |v| v },
      clip_path: proc { |v| v },
      clip: proc { |v| v },
      color_adjust: proc { |v| v },
      color: proc { |v| "text-#{v}" },
      column_count: proc { |v| v },
      column_fill: proc { |v| v },
      column_gap: proc { |v| "gap-x-#{v}" },
      column_rule_color: proc { |v| v },
      column_rule_style: proc { |v| v },
      column_rule_width: proc { |v| v },
      column_rule: proc { |v| v },
      column_span: proc { |v| v },
      column_width: proc { |v| v },
      columns: proc { |v| v },
      contain: proc { |v| v },
      _content: proc { |v| v },
      counter_increment: proc { |v| v },
      counter_reset: proc { |v| v },
      cursor: proc { |v| "cursor-#{v}" },
      direction: proc { |v| v },
      display: proc { |v| v },
      empty_cells: proc { |v| v },
      fill: proc { |v| v },
      filter: proc { |v| v },
      flex_basis: proc { |v| "flex-basis-#{v}" },
      flex_direction: proc { |v| "flex-#{v}" },
      flex_grow: proc { |v| "flex-grow-#{v}" },
      flex_shrink: proc { |v| "flex-shrink-#{v}" },
      flex_wrap: proc { |v| "flex-#{v}" },
      flex: proc { |v| v },
      font_family: proc { |v| "font-#{v}" },
      font_feature_settings: proc { |v| v },
      font_kerning: proc { |v| v },
      font_language_override: proc { |v| v },
      font_size: proc { |v| "text-#{v}" },
      font_stretch: proc { |v| v },
      font_style: proc { |v| v == 'italic' ? 'italic' : 'not-italic' },
      font_variant_caps: proc { |v| v },
      font_variant_east_asian: proc { |v| v },
      font_variant_ligatures: proc { |v| v },
      font_variant_numeric: proc { |v| v },
      font_variant_position: proc { |v| v },
      font_variant: proc { |v| v },
      font_weight: proc { |v| "font-#{v}" },
      grid_area: proc { |v| v },
      grid_auto_columns: proc { |v| v },
      grid_auto_flow: proc { |v| v },
      grid_auto_rows: proc { |v| v },
      grid_column: proc { |v| v },
      grid_gap: proc { |v| "gap-#{v}" },
      grid_row: proc { |v| v },
      grid_template_columns: proc { |v| v },
      grid_template_rows: proc { |v| v },
      grid: proc { |v| v },
      h: proc { |v| "h-#{v}" },
      hanging_punctuation: proc { |v| v },
      hyphens: proc { |v| v },
      isolation: proc { |v| v },
      justify_content: proc { |v| "justify-#{v}" },
      justify_items: proc { |v| "justify-items-#{v}" },
      justify_self: proc { |v| "justify-self-#{v}" },
      left: proc { |v| "left-#{v}" },
      letter_spacing: proc { |v| "tracking-#{v}" },
      line_height: proc { |v| "leading-#{v}" },
      list_style_image: proc { |v| v },
      list_style_position: proc { |v| v == 'inside' ? 'list-inside' : 'list-outside' },
      list_style_type: proc { |v| v },
      m: proc { |v| "m-#{v}" },
      mask_type: proc { |v| v },
      mask: proc { |v| v },
      max_h: proc { |v| "max-h-#{v}" },
      max_w: proc { |v| "max-w-#{v}" },
      mb: proc { |v| "mb-#{v}" },
      min_h: proc { |v| "min-h-#{v}" },
      min_w: proc { |v| "min-w-#{v}" },
      mix_blend_mode: proc { |v| v },
      ml: proc { |v| "ml-#{v}" },
      mr: proc { |v| "mr-#{v}" },
      mt: proc { |v| "mt-#{v}" },
      mx: proc { |v| "mx-#{v}" },
      my: proc { |v| "my-#{v}" },
      object_fit: proc { |v| v },
      object_position: proc { |v| v.tr(' ', '-') },
      opacity: proc { |v| "opacity-#{v}" },
      order: proc { |v| "order-#{v}" },
      orphans: proc { |v| v },
      outline_color: proc { |v| "outline-#{v}" },
      outline_style: proc { |v| v },
      outline_width: proc { |v| v },
      outline: proc { |v| v },
      overflow: proc { |v| "overflow-#{v}" },
      p: proc { |v| "p-#{v}" },
      pb: proc { |v| "pb-#{v}" },
      perspective_origin: proc { |v| v },
      perspective: proc { |v| v },
      pl: proc { |v| "pl-#{v}" },
      place_items: proc { |v| v },
      place_self: proc { |v| v },
      pointer_events: proc { |v| "pointer-events-#{v}" },
      position: proc { |v| v },
      pr: proc { |v| "pr-#{v}" },
      pt: proc { |v| "pt-#{v}" },
      px: proc { |v| "px-#{v}" },
      py: proc { |v| "py-#{v}" },
      quotes: proc { |v| v },
      resize: proc { |v| "resize-#{v}" },
      right: proc { |v| "right-#{v}" },
      rotate: proc { |v| v },
      row_gap: proc { |v| "gap-y-#{v}" },
      scale: proc { |v| "scale-#{v}" },
      scroll_behavior: proc { |v| v == 'smooth' ? 'scroll-smooth' : 'scroll-auto' },
      scroll_margin_bottom: proc { |v| v },
      scroll_margin_left: proc { |v| v },
      scroll_margin_right: proc { |v| v },
      scroll_margin_top: proc { |v| v },
      scroll_padding_bottom: proc { |v| v },
      scroll_padding_left: proc { |v| v },
      scroll_padding_right: proc { |v| v },
      scroll_padding_top: proc { |v| v },
      scroll_snap_align: proc { |v| v },
      scroll_snap_stop: proc { |v| v },
      scroll_snap_type: proc { |v| v },
      shape_image_threshold: proc { |v| v },
      shape_margin: proc { |v| v },
      shape_outside: proc { |v| v },
      tab_size: proc { |v| v },
      table_layout: proc { |v| v == 'auto' ? 'table-auto' : 'table-fixed' },
      text_align: proc { |v| "text-#{v}" },
      text_combine_upright: proc { |v| v },
      text_decoration_color: proc { |v| "underline-#{v}" },
      text_decoration_line: proc { |v| "line-#{v}" },
      text_decoration_style: proc { |v| "style-#{v}" },
      text_decoration_thickness: proc { |v| "thickness-#{v}" },
      text_decoration: proc { |v| v == 'none' ? 'no-underline' : 'underline' },
      text_indent: proc { |v| "indent-#{v}" },
      text_justify: proc { |v| "justify-#{v}" },
      text_overflow: proc { |v| v },
      text_shadow: proc { |v| v == 'none' ? 'text-shadow-none' : 'text-shadow' },
      text_transform: proc { |v| "text-#{v}" },
      text_underline_offset: proc { |v| v },
      text_underline_position: proc { |v| v },
      top: proc { |v| "top-#{v}" },
      transform: proc { |v| v },
      transition_delay: proc { |v| v },
      transition_duration: proc { |v| "duration-#{v}" },
      transition_property: proc { |v| "transition-#{v}" },
      transition_timing_function: proc { |v| "ease-#{v}" },
      transition: proc { |v| v },
      unicode_bidi: proc { |v| v },
      user_select: proc { |v| "select-#{v}" },
      vertical_align: proc { |v| "align-#{v}" },
      visibility: proc { |v| v == 'visible' ? 'visible' : 'invisible' },
      white_space: proc { |v| "whitespace-#{v}" },
      widows: proc { |v| v },
      w: proc { |v| "w-#{v}" },
      word_break: proc { |v| "break-#{v}" },
      word_spacing: proc { |v| "spacing-#{v}" },
      writing_mode: proc { |v| v },
      z_index: proc { |v| "z-#{v}" },
      zoom: proc { |v| v }
    }.freeze

    def class_name
      super.to_s.split(/\s+/).concat(style_classes).join(' ').presence
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
