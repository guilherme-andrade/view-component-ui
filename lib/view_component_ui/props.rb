require 'dry-struct'

module ViewComponentUI
  class Props
    def self.overriden_in(instance)
      values = Types::PROPS.each_with_object({}) do |(prop), hash|
        next unless instance.class.instance_methods(false).include?(prop)

        value = instance.send(prop)
        hash[prop] = value unless value.nil?
      end
      new(values)
    end

    delegate :[], :fetch, :key?, :keys, :values, :map, :each, :each_with_object, :dig, to: :to_h

    def initialize(attributes = {})
      @attributes = attributes
    end

    def to_h
      @attributes.dup
    end

    def bind(context)
      new_props = to_h.deep_transform_values do |value|
        final_value = value
        final_value = context.instance_eval(&final_value) while final_value.respond_to?(:call)
        final_value
      end
      new(new_props)
    end

    def slice(*keys)
      self.class.new(to_h.slice(*keys))
    end

    def except(*keys)
      self.class.new(to_h.except(*keys))
    end

    def compact
      self.class.new(to_h.compact)
    end

    def merge(other)
      new(other.to_h)
    end

    def transform_values(&block)
      new(to_h.deep_transform_values(&block))
    end

    def new(attributes = @attributes)
      self.class.new(to_h.merge(attributes))
    end

    def inspect
      "#<#{self.class.name} #{to_h}>"
    end
  end
end
