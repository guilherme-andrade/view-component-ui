module ViewComponentUI
  class HeadingComponent < BoxComponent
    FONT_SIZES = {
      1 => '4xl', # tw-text-4xl
      2 => '3xl', # tw-text-3xl
      3 => '2xl', # tw-text-2xl
      4 => 'xl', # tw-text-xl
      5 => 'lg', # tw-text-lg
      6 => 'base' # tw-text-base
    }.freeze

    defaults level: 2, font_weight: 'bold'

    option :level, default: proc { 2 }

    def font_size
      initial_props[:font_size] || FONT_SIZES[level]
    end

    def as
      initial_props[:as] || "h#{level}"
    end
  end
end
