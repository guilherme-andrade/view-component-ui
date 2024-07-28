require 'dry/configurable'
require 'deep_merge/rails_compat'
require 'tailwindcss/constants'
require 'tailwindcss/types'
require 'tailwindcss/compiler/runner'

module Tailwindcss
  extend Dry::Configurable
  include Constants
  extend self

  setting :output_path, default: proc { './tmp' }
  setting :content, default: proc { [] }

  setting :watch_content, default: false

  setting :breakpoints, default: BREAKPOINTS
  setting :pseudo_selectors, default: PSEUDO_SELECTORS
  setting :pseudo_elements, default: PSEUDO_ELEMENTS
  setting :theme, default: THEME

  setting :logger, default: proc { Logger.new(STDOUT) }

  module ExtendTheme
    def extend_theme(**overrides)
      self.theme = self.theme.deeper_merge(overrides)
    end
  end

  config.extend ExtendTheme

  def configure(&blk)
    super(&blk)
    init!
  end

  def init!
    require "tailwindcss/style"
    Compiler::Runner.new.call
  end
end
