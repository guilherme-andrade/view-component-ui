module ViewComponentUI
  class ClassListBuilder
    extend Dry::Initializer

    option :include_breakpoints, default: proc { true }, reader: true
    option :include_pseudo_classes, default: proc { true }, reader: true
    option :include_pseudo_elements, default: proc { true }, reader: true

    delegate :pseudo_classes, :pseudo_elements, :breakpoints, to: :config, prefix: :config
    delegate :style_option_properties, to: StyledComponent, prefix: :config

    def call(**options)
      classes = []
      classes << build_style_option_classes(options)

      classes << build_breakpoint_classes(options) if include_breakpoints
      classes << build_pseudo_classes_classes(options) if include_pseudo_classes
      classes << build_pseudo_elements_classes(options) if include_pseudo_elements

      classes.flatten
    end

    private

    def build_style_option_classes(options)
      style_option_options(options).each_with_object([]) do |(style_option, value), memo|
        classes = config_style_option_properties[style_option][:class].call(value)

        memo << classes
      end
    end

    def build_breakpoint_classes(options)
      builder = ClassListBuilder.new(include_breakpoints: false)

      breakpoint_options(options).each_with_object([]) do |(bp, bp_options), memo|
        classes = builder.call(**bp_options)

        memo << classes.map { |klass| "#{bp}:#{klass}" }
      end
    end

    def build_pseudo_classes_classes(options)
      builder = ClassListBuilder.new(include_pseudo_classes: false, include_breakpoints: false)

      pseudo_classes_options(options).each_with_object([]) do |(pc, pc_options), memo|
        classes = builder.call(**pc_options.to_h.symbolize_keys)

        memo << classes.map { |klass| "#{pc[1..]}:#{klass}" }
      end
    end

    def build_pseudo_elements_classes(options)
      builder = ClassListBuilder.new(include_pseudo_classes: false, include_pseudo_elements: false,
                                     include_breakpoints: false)

      pseudo_elements_options(options).each_with_object([]) do |(pe, pe_options), memo|
        classes = builder.call(**pe_options.to_h.symbolize_keys)

        memo << classes.map { |klass| "#{pe[1..]}:#{klass}" }
      end
    end

    def pseudo_classes_options(options)
      pseudo_class_utilities = config_pseudo_classes.map { :"_#{_1}" }
      options.slice(*pseudo_class_utilities)
    end

    def pseudo_elements_options(options)
      pseudo_element_utilities = config_pseudo_elements.map { :"_#{_1}" }
      options.slice(*pseudo_element_utilities)
    end

    def breakpoint_options(options)
      options.slice(*config_breakpoints)
    end

    def style_option_options(options)
      all_keys = config_style_option_properties.keys.map do
        [_1, config_style_option_properties[_1][:alias]].compact
      end.flatten

      options.slice(*all_keys)
    end

    def config
      ViewComponentUI.config
    end
  end
end
