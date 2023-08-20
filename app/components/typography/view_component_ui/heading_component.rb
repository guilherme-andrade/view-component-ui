module ViewComponentUI
  class HeadingComponent < BoxComponent
    FONT_SIZES = {
      1 => '4xl',
      2 => '3xl',
      3 => '2xl',
      4 => 'xl',
      5 => 'lg',
      6 => 'base'
    }.freeze

    option :level, default: proc { 2 }
    option :as, default: proc {}
    option :font_weight, default: proc { 'bold' }

    def font_size
      super || FONT_SIZES[level]
    end

    def as
      super || "h#{level}"
    end
  end
end
