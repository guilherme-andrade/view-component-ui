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

    delegate :[], :fetch, :key?, :keys, :values, :map, :each, :each_with_object, to: :to_h

    def to_h
      @props.deep_dup
    end

    def bind(context)
      new_props = to_h.deep_transform_values do |value|
        final_value = value
        final_value = context.instance_eval(&final_value) while final_value.respond_to?(:call)
        final_value
      end
      Props.new(new_props)
    end

    def slice(*keys)
      Props.new(to_h.slice(*keys))
    end

    def compact
      Props.new(to_h.compact)
    end

    def merge(other)
      Props.new(other.to_h.deeper_merge(to_h))
    end

    def transform_values(&block)
      Props.new(to_h.deep_transform_values(&block))
    end

    def inspect
      "#<#{self.class.name} #{to_h}>"
    end
  end
end
