module ViewComponentUI
  class PropDefinition
    def initialize(name, *args)
      @name = name
      @options = args.extract_options!
      @type = args.shift
    end

    attr_reader :name, :options
    
    def define_on(klass)
      klass.extend Dry::Initializer unless klass.is_a?(Dry::Initializer)
      klass.option(name, type_for(klass), **dry_initializer_options)
      klass.option(alias_name, type_for(klass), **dry_initializer_options) if alias_name
    end

    def dry_initializer_options
      options.except(:alias, :values)
    end

    def alias_name
      options[:alias]
    end

    def allowed_values
      options[:values]
    end

    def type_for(klass)
      return @type if @type.is_a?(Dry::Types::Nominal)

      build_not_allowed_message = ->(value, values) do
        "invalid value `#{value.inspect}`(#{value.class}) for `#{name}` in `#{klass}`. Must be one of #{values.join(', ')}"
      end

      if allowed_values.is_a?(Array)
        Types::PropValue.one_of(allowed_values, meta: { message: build_not_allowed_message })
      else
        Types::PropValue
      end
    end
  end
end
