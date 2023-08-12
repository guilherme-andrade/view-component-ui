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
      option :stroke, default: proc {}, required: false
      option :tab_size, default: proc {}, required: false
      option :table_layout, default: proc {}, required: false
      option :text_align_last, default: proc {}, required: false
      option :text_align, default: proc {}, required: false
      option :text_combine_upright, default: proc {}, required: false
      option :text_decoration_color, default: proc {}, required: false
      option :text_decoration_line, default: proc {}, required: false
      option :text_decoration_style, default: proc {}, required: false
      option :text_decoration, default: proc {}, required: false
      option :text_justify, default: proc {}, required: false
      option :text_orientation, default: proc {}, required: false
      option :text_overflow, default: proc {}, required: false
      option :text_shadow, default: proc {}, required: false
      option :text_transform, default: proc {}, required: false
      option :text_underline_position, default: proc {}, required: false
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
    end

    STYLE_ATTRIBUTES = %i[
      align_content
      align_items
      backface_visibility
      background_attachment
      background_blend_mode
      background_clip
      background_color
      background_image
      background_origin
      background_position
      background_repeat
      background_size
      bg
      border_bottom_left_radius
      border_bottom_right_radius
      border_bottom
      border_collapse
      border_color
      border_image_outset
      border_image_repeat
      border_image_slice
      border_image_source
      border_image_width
      border_image
      border_left
      border_radius
      border_right
      border_spacing
      border_style
      border_top_left_radius
      border_top_right_radius
      border_top
      border_width
      border
      bottom
      box_decoration_break
      box_shadow
      box_sizing
      caption_side
      clear
      clip_path
      clip
      color_adjust
      color
      column_count
      column_fill
      column_gap
      column_rule_color
      column_rule_style
      column_rule_width
      column_rule
      column_span
      column_width
      columns
      contain
      _content
      counter_increment
      counter_reset
      cursor
      direction
      display
      empty_cells
      fill
      filter
      flex_basis
      flex_direction
      flex_direction
      flex_grow
      flex_shrink
      flex_wrap
      flex
      font_family
      font_feature_settings
      font_kerning
      font_language_override
      font_size
      font_stretch
      font_style
      font_variant_caps
      font_variant_east_asian
      font_variant_ligatures
      font_variant_numeric
      font_variant_position
      font_variant
      font_weight
      grid_area
      grid_auto_columns
      grid_auto_flow
      grid_auto_rows
      grid_column
      grid_gap
      grid_row
      grid_template_columns
      grid_template_rows
      grid
      h
      hanging_punctuation
      hyphens
      isolation
      justify_content
      justify_items
      justify_self
      left
      letter_spacing
      line_height
      list_style_image
      list_style_position
      list_style_type
      m
      mask_type
      mask
      max_h
      max_w
      mb
      min_h
      min_w
      mix_blend_mode
      ml
      mr
      mt
      mx
      my
      object_fit
      object_position
      object_position
      opacity
      order
      orphans
      outline_color
      outline_style
      outline_width
      outline
      overflow
      p
      pb
      perspective_origin
      perspective
      pl
      place_items
      place_self
      pointer_events
      position
      pr
      pt
      px
      py
      quotes
      resize
      right
      rotate
      row_gap
      scale
      scroll_behavior
      stroke
      tab_size
      table_layout
      text_align_last
      text_align
      text_combine_upright
      text_decoration_color
      text_decoration_line
      text_decoration_style
      text_decoration
      text_justify
      text_orientation
      text_overflow
      text_shadow
      text_transform
      text_underline_position
      top
      transform_box
      transform_origin
      transform_style
      transform
      transition_delay
      transition_duration
      transition_property
      transition_timing_function
      transition
      unicode_bidi
      user_select
      vertical_align
      visibility
      w
      white_space
      whitespace
      widows
      will_change
      word_break
      word_spacing
      word_wrap
      writing_mode
      z_index
    ].freeze

    def class_name
      super.to_s.split(/\s+/).concat(style_classes).join(' ').presence
    end

    def style_classes
      STYLE_ATTRIBUTES.filter_map do |attribute|
        value = send(attribute)
        next if value.nil?

        "#{attribute}-#{value}"
      end
    end
  end
end
