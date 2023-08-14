module CSSOptions
  include Dry.Types()

  ALIGN_CONTENT = %w[flex-start flex-end center space-between space-around stretch].freeze
  ALIGN_ITEMS = %w[flex-start flex-end center baseline stretch].freeze
  BACKFACE_VISIBILITY = %w[visible hidden].freeze
  BACKGROUND_ATTACHMENT = %w[scroll fixed local].freeze
  BACKGROUND_BLEND_MODE = %w[normal multiply screen overlay darken lighten color-dodge saturation color
                             luminosity].freeze
  BACKGROUND_CLIP = %w[border-box padding-box content-box].freeze
  BACKGROUND_COLOR = nil
  BACKGROUND_IMAGE = nil
  BACKGROUND_ORIGIN = %w[border-box padding-box content-box].freeze
  BACKGROUND_REPEAT = %w[repeat repeat-x repeat-y no-repeat].freeze
  BACKGROUND_SIZE = %w[auto cover contain].freeze

  # You can now use these types to validate or coerce input values
end
