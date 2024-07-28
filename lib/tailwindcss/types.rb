require 'dry-types'

module Tailwindcss
  module Types
    include Dry.Types()

    def self.Directive(name)
      (Types::Interface(:call) | Types::Any).constructor do |value|
        values = Tailwindcss.config.theme[name].fetch(:values, [])
        values = values.call if values.respond_to?(:call)
        next value if value.nil? || value.respond_to?(:call) || values.any? { _1.to_s.dasherize == value.to_s.dasherize }

        raise ArgumentError, "attribute #{name} has invalid value #{value.inspect}. must be one of #{values.join(', ')}"
      end
    end
  end
end
