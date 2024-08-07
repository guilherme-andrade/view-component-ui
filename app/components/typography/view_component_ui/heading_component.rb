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

    default_props level: 2, font_weight: 'bold'

    prop :level, Types::Coercible::Integer.default(2).enum(1, 2, 3, 4, 5, 6).optional

    def font_size
      initial_props&.dig(:font_size) || FONT_SIZES[initial_props[:level] || default_props[:level]]
    end

    def as
      initial_props&.dig(:as) || "h#{initial_props[:level] || default_props[:level]}"
    end
  end
end
