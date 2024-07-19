module ViewComponentUI
  class Props < Hash
    def self.defined_in(instance)
      raise ArgumentError, "class must respond to #props" unless instance.class.respond_to?(:props)

      values = instance.class.props.each_with_object({}) do |prop, hash|
        next unless instance.class.instance_methods(false).include?(prop)

        value = send(prop)
        hash[prop] = value unless value.nil?
      end
      new(values)
    end

    def initialize(props = {})
      super(props)
    end
  end
end
