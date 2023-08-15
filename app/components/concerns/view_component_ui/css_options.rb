module ViewComponentUI
  module CSSOptions # rubocop:disable Metrics/ModuleLength
    extend ActiveSupport::Concern

    include StyleOptions

    class_methods do
      def style_option(name, *args)
        options = args.extract_options!
        enum_options = options.delete(:options).map(&:to_sym)
        style_option_property = { options: enum_options, class: options.delete(:class) }
        style_option_properties[name] = style_option_property
        style_option_properties[options[:alias]] = style_option_property

        dasherize_symbol = proc { _1.to_s.dasherize.to_sym }
        type = Types::Coercible::Symbol.constructor(dasherize_symbol).enum(*enum_options).optional

        option name, type, **options.merge(optional: true)
      end

      def style_option_properties
        @style_option_properties ||= {}
      end

      def defaults(**values)
        @default_values = values
      end

      def default_values
        @default_values ||= {}
      end

      def inherited(base)
        super
        base.defaults(**default_values)
        base.style_option_properties.merge!(style_option_properties)
      end
    end

    def initialize(**options)
      options = self.class.default_values.merge(options)

      super(**options)
    end

    UTIL_PROC = proc do |prefix|
      proc do |v|
        if prefix.nil?
          v
        elsif [true, 'true'].include?(v)
          prefix
        elsif [false, 'false'].include?(v)
          nil
        else
          "#{prefix}-#{v.to_s.dasherize}"
        end
      end
    end

    COLOR_WITH_WEIGHTS = ViewComponentUI.config.theme.colors.map do |color|
      COLOR_WEIGHTS.map { |weight| [color, weight].compact.join('-') }
    end.flatten.freeze

    DEFINE_CSS_PROPERTIES = proc do # rubocop:disable Metrics/BlockLength
      style_option :align_content, options: ALIGN_CONTENT, class: UTIL_PROC.call('content')
      style_option :align_items, options: ALIGN_ITEMS, class: UTIL_PROC.call('items')
      style_option :backface_visibility, options: BACKFACE_VISIBILITY, class: UTIL_PROC.call('backface')
      style_option :background, alias: :bg, options: COLOR_WITH_WEIGHTS,
                                class: UTIL_PROC.call('bg')
      style_option :background_attachment, options: BACKGROUND_ATTACHMENT, class: UTIL_PROC.call('bg')
      style_option :background_blend_mode, options: BACKGROUND_BLEND_MODE, class: UTIL_PROC.call('bg')
      style_option :background_clip, options: BACKGROUND_CLIP, class: UTIL_PROC.call('bg')
      style_option :background_color, options: COLOR_WITH_WEIGHTS, class: UTIL_PROC.call('bg')
      style_option :background_image, options: BACKGROUND_IMAGE, class: UTIL_PROC.call('bg')
      style_option :background_origin, options: BACKGROUND_ORIGIN, class: UTIL_PROC.call('bg')
      style_option :background_position, options: BACKGROUND_POSITION, class: UTIL_PROC.call('bg')
      style_option :background_repeat, options: BACKGROUND_REPEAT, class: UTIL_PROC.call('bg')
      style_option :background_size, options: ViewComponentUI.config.theme.background_size, class: UTIL_PROC.call('bg')
      style_option :border_bottom_left_radius, options: ViewComponentUI.config.theme.border_radius,
                                               class: UTIL_PROC.call('rounded-bl')
      style_option :border_bottom_right_radius, options: ViewComponentUI.config.theme.border_radius,
                                                class: UTIL_PROC.call('rounded-br')
      style_option :border_top_left_radius, options: ViewComponentUI.config.theme.border_radius,
                                            class: UTIL_PROC.call('rounded-tl')
      style_option :border_top_right_radius, options: ViewComponentUI.config.theme.border_radius,
                                             class: UTIL_PROC.call('rounded-tr')
      style_option :border_top_radius, options: ViewComponentUI.config.theme.border_radius,
                                       class: UTIL_PROC.call('rounded-t')
      style_option :border_bottom_radius, options: ViewComponentUI.config.theme.border_radius,
                                          class: UTIL_PROC.call('rounded-b')
      style_option :border_left_radius, options: ViewComponentUI.config.theme.border_radius,
                                        class: UTIL_PROC.call('rounded-l')
      style_option :border_right_radius, options: ViewComponentUI.config.theme.border_radius,
                                         class: UTIL_PROC.call('rounded-r')
      style_option :border_collapse, options: BORDER_COLLAPSE, class: UTIL_PROC.call('border')
      style_option :border_color, options: COLOR_WITH_WEIGHTS, class: UTIL_PROC.call('border')
      style_option :border_radius, options: ViewComponentUI.config.theme.border_radius, class: UTIL_PROC.call('rounded')
      style_option :border_spacing, options: ViewComponentUI.config.theme.spacing,
                                    class: UTIL_PROC.call('border-spacing')
      style_option :border_spacing_x, options: ViewComponentUI.config.theme.spacing,
                                      class: UTIL_PROC.call('border-spacing-x')
      style_option :border_spacing_y, options: ViewComponentUI.config.theme.spacing,
                                      class: UTIL_PROC.call('border-spacing-y')
      style_option :border_style, options: BORDER_STYLE, class: UTIL_PROC.call('border')
      style_option :border, options: BORDER, class: UTIL_PROC.call('border')
      style_option :border_width, options: ViewComponentUI.config.theme.border_width, class: UTIL_PROC.call('border')
      style_option :bottom, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('bottom')
      style_option :box_decoration_break, options: BOX_DECORATION_BREAK, class: UTIL_PROC.call('box-decoration-break')
      style_option :box_shadow, options: ViewComponentUI.config.theme.box_shadow, class: UTIL_PROC.call('shadow')
      style_option :box_sizing, options: ViewComponentUI.config.theme.box_sizing, class: UTIL_PROC.call('box')
      style_option :caption_side, options: ViewComponentUI.config.theme.caption_side, class: UTIL_PROC.call('caption')
      style_option :clear, options: ViewComponentUI.config.theme.clear, class: UTIL_PROC.call('clear')
      style_option :color, options: COLOR_WITH_WEIGHTS, class: UTIL_PROC.call('text')
      style_option :column_gap, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('gap')
      style_option :column_span, alias: :col_span, options: ViewComponentUI.config.theme.column_span,
                                 class: UTIL_PROC.call('col-span')
      style_option :column_start, alias: :col_start, options: ViewComponentUI.config.theme.column_start,
                                  class: UTIL_PROC.call('col-start')
      style_option :column_end, alias: :col_end, options: ViewComponentUI.config.theme.column_end,
                                class: UTIL_PROC.call('col-end')
      style_option :columns, options: ViewComponentUI.config.theme.columns, class: UTIL_PROC.call('col')
      style_option :_content, options: ViewComponentUI.config.theme.content, class: UTIL_PROC.call('content')
      style_option :cursor, options: ViewComponentUI.config.theme.cursor, class: UTIL_PROC.call('cursor')
      style_option :display, options: DISPLAY, class: UTIL_PROC.call
      style_option :empty_cells, options: ViewComponentUI.config.theme.empty_cells, class: UTIL_PROC.call('empty')
      style_option :end, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('end')
      style_option :fill, options: COLOR_WITH_WEIGHTS, class: UTIL_PROC.call('fill')
      style_option :flex_basis, options: ViewComponentUI.config.theme.flex_basis, class: UTIL_PROC.call('flex')
      style_option :flex_direction, options: ViewComponentUI.config.theme.flex_direction, class: UTIL_PROC.call('flex')
      style_option :flex_grow, options: ViewComponentUI.config.theme.flex_grow, class: UTIL_PROC.call('flex')
      style_option :flex_shrink, options: ViewComponentUI.config.theme.flex_shrink, class: UTIL_PROC.call('flex')
      style_option :flex_wrap, options: ViewComponentUI.config.theme.flex_wrap, class: UTIL_PROC.call('flex')
      style_option :flex, options: ViewComponentUI.config.theme.flex, class: UTIL_PROC.call('flex')
      style_option :font_family, options: ViewComponentUI.config.theme.font_family, class: UTIL_PROC.call('font')
      style_option :font_size, options: ViewComponentUI.config.theme.font_size, class: UTIL_PROC.call('text')
      style_option :font_style, options: ViewComponentUI.config.theme.font_style, class: UTIL_PROC.call
      style_option :font_variant_numeric, options: ViewComponentUI.config.theme.font_variant_numeric,
                                          class: UTIL_PROC.call
      style_option :font_weight, options: ViewComponentUI.config.theme.font_weight, class: UTIL_PROC.call('font')
      style_option :grid_auto_columns, options: ViewComponentUI.config.theme.grid_auto_columns,
                                       class: UTIL_PROC.call('auto-cols')
      style_option :grid_auto_flow, options: ViewComponentUI.config.theme.grid_auto_flow,
                                    class: UTIL_PROC.call('grid-flow')
      style_option :grid_auto_rows, options: ViewComponentUI.config.theme.grid_auto_rows,
                                    class: UTIL_PROC.call('auto-rows')
      style_option :grid_gap, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('gap')
      style_option :grid_gap_x, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('gap-x')
      style_option :grid_gap_y, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('gap-y')
      style_option :grid_template_columns, options: ViewComponentUI.config.theme.grid_template_columns,
                                           class: UTIL_PROC.call('grid-cols')
      style_option :grid_template_rows, options: ViewComponentUI.config.theme.grid_template_rows,
                                        class: UTIL_PROC.call('grid-rows')
      style_option :height, alias: :h, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('h')
      style_option :hyphens, options: ViewComponentUI.config.theme.hyphens, class: UTIL_PROC.call('hyphens')
      style_option :inset, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('inset')
      style_option :inset_x, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('inset-x')
      style_option :inset_y, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('inset-y')
      style_option :isolation, options: ViewComponentUI.config.theme.isolation, class: UTIL_PROC.call('isolation')
      style_option :justify_content, options: ViewComponentUI.config.theme.justify_content,
                                     class: UTIL_PROC.call('justify')
      style_option :justify_items, options: ViewComponentUI.config.theme.justify_items, class: UTIL_PROC.call('justify')
      style_option :justify_self, options: ViewComponentUI.config.theme.justify_self, class: UTIL_PROC.call('justify')
      style_option :left, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('left')
      style_option :letter_spacing, options: ViewComponentUI.config.theme.letter_spacing,
                                    class: UTIL_PROC.call('tracking')
      style_option :line_height, options: ViewComponentUI.config.theme.line_height, class: UTIL_PROC.call('leading')
      style_option :list_style_image, options: ViewComponentUI.config.theme.list_style_image,
                                      class: UTIL_PROC.call('list-image')
      style_option :list_style_position, options: ViewComponentUI.config.theme.list_style_position,
                                         class: UTIL_PROC.call('list')
      style_option :list_style_type, options: ViewComponentUI.config.theme.list_style_type,
                                     class: UTIL_PROC.call('list')
      style_option :margin_bottom, alias: :mb, options: ViewComponentUI.config.theme.spacing,
                                   class: UTIL_PROC.call('mb')
      style_option :margin_end, alias: :me, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('me')
      style_option :margin_left, alias: :ml, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('ml')
      style_option :margin_right, alias: :mr, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('mr')
      style_option :margin_start, alias: :ms, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('ms')
      style_option :margin_top, alias: :mt, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('mt')
      style_option :margin_x, alias: :mx, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('mx')
      style_option :margin_y, alias: :my, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('my')
      style_option :margin, alias: :m, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('m')
      style_option :max_height, alias: :max_h, options: ViewComponentUI.config.theme.sizes,
                                class: UTIL_PROC.call('max-h')
      style_option :max_width, alias: :max_w, options: ViewComponentUI.config.theme.sizes,
                               class: UTIL_PROC.call('max-w')
      style_option :min_height, alias: :min_h, options: ViewComponentUI.config.theme.sizes,
                                class: UTIL_PROC.call('min-h')
      style_option :min_width, alias: :min_w, options: ViewComponentUI.config.theme.sizes,
                               class: UTIL_PROC.call('min-w')
      style_option :mix_blend_mode, options: ViewComponentUI.config.theme.mix_blend_mode,
                                    class: UTIL_PROC.call('mix-blend')
      style_option :object_fit, options: ViewComponentUI.config.theme.object_fit, class: UTIL_PROC.call('object')
      style_option :object_position, options: ViewComponentUI.config.theme.object_position,
                                     class: UTIL_PROC.call('object')
      style_option :opacity, options: ViewComponentUI.config.theme.opacity, class: UTIL_PROC.call('opacity')
      style_option :order, options: ViewComponentUI.config.theme.order, class: UTIL_PROC.call('order')
      style_option :outline_color, options: COLOR_WITH_WEIGHTS, class: UTIL_PROC.call('outline')
      style_option :outline_style, alias: :outline, options: ViewComponentUI.config.theme.outline_style,
                                   class: UTIL_PROC.call('outline')
      style_option :outline_width, options: ViewComponentUI.config.theme.outline_width, class: UTIL_PROC.call('outline')
      style_option :overflow, options: ViewComponentUI.config.theme.overflow, class: UTIL_PROC.call('overflow')
      style_option :overflow_x, options: ViewComponentUI.config.theme.overflow, class: UTIL_PROC.call('overflow-x')
      style_option :overflow_y, options: ViewComponentUI.config.theme.overflow, class: UTIL_PROC.call('overflow-y')
      style_option :padding, alias: :p, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('p')
      style_option :padding_bottom, alias: :pb,  options: ViewComponentUI.config.theme.spacing,
                                    class: UTIL_PROC.call('pb')
      style_option :padding_left, alias: :pl, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('pl')
      style_option :padding_right, alias: :pr, options: ViewComponentUI.config.theme.spacing,
                                   class: UTIL_PROC.call('pr')
      style_option :padding_top, alias: :pt, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('pt')
      style_option :padding_x, alias: :px,  options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('px')
      style_option :padding_y, alias: :py,  options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('py')
      style_option :place_items, options: ViewComponentUI.config.theme.place_items, class: UTIL_PROC.call('place')
      style_option :place_self, options: ViewComponentUI.config.theme.place_self, class: UTIL_PROC.call('place')
      style_option :pointer_events, options: ViewComponentUI.config.theme.pointer_events,
                                    class: UTIL_PROC.call('pointer')
      style_option :position, options: ViewComponentUI.config.theme.position, class: UTIL_PROC.call
      style_option :resize, options: ViewComponentUI.config.theme.resize, class: UTIL_PROC.call('resize')
      style_option :right, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('right')
      style_option :rotate, options: ViewComponentUI.config.theme.rotate, class: UTIL_PROC.call('rotate')
      style_option :row_gap, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('gap')
      style_option :row_span, options: ViewComponentUI.config.theme.row_span, class: UTIL_PROC.call('row-span')
      style_option :row_start, options: ViewComponentUI.config.theme.row_start, class: UTIL_PROC.call('row-start')
      style_option :row_end, options: ViewComponentUI.config.theme.row_end, class: UTIL_PROC.call('row-end')
      style_option :scale, options: ViewComponentUI.config.theme.scale, class: UTIL_PROC.call('scale')
      style_option :scale_x, options: ViewComponentUI.config.theme.scale, class: UTIL_PROC.call('scale-x')
      style_option :scale_y, options: ViewComponentUI.config.theme.scale, class: UTIL_PROC.call('scale-y')
      style_option :scroll_behavior, options: ViewComponentUI.config.theme.scroll_behavior,
                                     class: UTIL_PROC.call('scroll')
      style_option :scroll_margin_bottom, options: ViewComponentUI.config.theme.spacing,
                                          class: UTIL_PROC.call('scroll-mb')
      style_option :scroll_margin_left, options: ViewComponentUI.config.theme.spacing,
                                        class: UTIL_PROC.call('scroll-ml')
      style_option :scroll_margin_right, options: ViewComponentUI.config.theme.spacing,
                                         class: UTIL_PROC.call('scroll-mr')
      style_option :scroll_margin_top, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('scroll-mt')
      style_option :scroll_margin_x, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('scroll-mx')
      style_option :scroll_margin_y, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('scroll-my')
      style_option :scroll_margin_start, options: ViewComponentUI.config.theme.spacing,
                                         class: UTIL_PROC.call('scroll-ms')
      style_option :scroll_margin_end, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('scroll-me')
      style_option :scroll_padding_bottom, options: ViewComponentUI.config.theme.spacing,
                                           class: UTIL_PROC.call('scroll-pb')
      style_option :scroll_padding_left, options: ViewComponentUI.config.theme.spacing,
                                         class: UTIL_PROC.call('scroll-pl')
      style_option :scroll_padding_right, options: ViewComponentUI.config.theme.spacing,
                                          class: UTIL_PROC.call('scroll-pr')
      style_option :scroll_padding_top, options: ViewComponentUI.config.theme.spacing,
                                        class: UTIL_PROC.call('scroll-pt')
      style_option :scroll_padding_x, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('scroll-px')
      style_option :scroll_padding_y, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('scroll-py')
      style_option :scroll_padding_start, options: ViewComponentUI.config.theme.spacing,
                                          class: UTIL_PROC.call('scroll-ps')
      style_option :scroll_padding_end, options: ViewComponentUI.config.theme.spacing,
                                        class: UTIL_PROC.call('scroll-pe')
      style_option :scroll_snap_align, options: ViewComponentUI.config.theme.scroll_snap_align,
                                       class: UTIL_PROC.call('snap')
      style_option :scroll_snap_stop, options: ViewComponentUI.config.theme.scroll_snap_stop,
                                      class: UTIL_PROC.call('snap')
      style_option :scroll_snap_type, options: ViewComponentUI.config.theme.scroll_snap_type,
                                      class: UTIL_PROC.call('snap')
      style_option :start, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('start')
      style_option :table_layout, options: ViewComponentUI.config.theme.table_layout, class: UTIL_PROC.call('table')
      style_option :text_align, options: ViewComponentUI.config.theme.text_align, class: UTIL_PROC.call('text')
      style_option :text_decoration_color, options: COLOR_WITH_WEIGHTS,
                                           class: UTIL_PROC.call('decoration')
      style_option :text_decoration_style, options: ViewComponentUI.config.theme.text_decoration_style,
                                           class: UTIL_PROC.call('decoration')
      style_option :text_decoration_thickness, options: ViewComponentUI.config.theme.text_decoration_thickness,
                                               class: UTIL_PROC.call('decoration')
      style_option :text_decoration, options: ViewComponentUI.config.theme.text_decoration,
                                     class: UTIL_PROC.call('decoration')
      style_option :text_indent, options: ViewComponentUI.config.theme.spacing, class: UTIL_PROC.call('indent')
      style_option :text_overflow, options: ViewComponentUI.config.theme.text_overflow, class: proc { |v|
                                                                                                 v == 'truncate' ? 'truncate' : "text-#{v}"
                                                                                               }
      style_option :text_transform, options: ViewComponentUI.config.theme.text_transform, class: UTIL_PROC.call
      style_option :text_underline_offset, options: ViewComponentUI.config.theme.text_underline_offset,
                                           class: UTIL_PROC.call('underline-offset')
      style_option :top, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('top')
      style_option :transform_origin, options: ViewComponentUI.config.theme.transform_origin,
                                      class: UTIL_PROC.call('origin')
      style_option :transition, options: ViewComponentUI.config.theme.transition, class: UTIL_PROC.call('transition')
      style_option :user_select, options: ViewComponentUI.config.theme.user_select, class: UTIL_PROC.call('select')
      style_option :vertical_align, options: ViewComponentUI.config.theme.vertical_align, class: UTIL_PROC.call('align')
      style_option :visibility, options: ViewComponentUI.config.theme.visibility, class: UTIL_PROC.call
      style_option :whitespace, options: ViewComponentUI.config.theme.whitespace, alias: :white_space,
                                class: UTIL_PROC.call('whitespace')
      style_option :width, alias: :w, options: ViewComponentUI.config.theme.sizes, class: UTIL_PROC.call('w')
      style_option :will_change, options: ViewComponentUI.config.theme.will_change, class: UTIL_PROC.call('will-change')
      style_option :word_break, options: ViewComponentUI.config.theme.word_break, class: UTIL_PROC.call('break')
      style_option :z_index, alias: :z, options: ViewComponentUI.config.theme.z_index, class: UTIL_PROC.call('z')
    end

    included(&DEFINE_CSS_PROPERTIES)

    def _class
      super.to_s.split(/\s+/).concat(build_style_classes(**style_options)).compact
    end

    def style_options
      options.slice(*self.class.style_option_properties.keys).compact
    end

    def build_style_classes(**opts)
      class_builder = ClassListBuilder.new
      class_builder.call(**opts)
    end
  end
end
