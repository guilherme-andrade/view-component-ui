module ViewComponentUI
  class Props
    def self.overriden_in(instance)
      raise ArgumentError, "class must respond to #props" unless instance.class.respond_to?(:props)

      values = instance.class.props.each_with_object({}) do |prop, hash|
        next unless instance.class.instance_methods(false).include?(prop)

        value = instance.send(prop)
        hash[prop] = value unless value.nil?
      end
      new(values)
    end

    def initialize(props = {})
      @props = props
    end

    delegate :[], :fetch, :key?, :keys, :values, :map, :each, :each_with_object, to: :props

    def to_h
      @props
    end

    def bind(context)
      @props.deep_transform_values! do |value|
        final_value = value
        final_value = context.instance_eval(&final_value) while final_value.respond_to?(:call)
        final_value
      end
      self
    end

    def slice(*keys)
      Props.new(@props.slice(*keys))
    end

    def compact
      Props.new(@props.compact)
    end

    def merge(other)
      Props.new(other.to_h.deeper_merge(@props))
    end

    def transform_values(&block)
      Props.new(@props.deep_transform_values(&block))
    end

    def deconstruct_keys(keys)
      keys.each_with_object({}) do |key, hash|
        hash[key] = @props[key]
      end
    end

    def deconstruct
      @props
    end

    def inspect
      "#<#{self.class.name} #{@props}>"
    end

    private attr_reader :props
  end
end
