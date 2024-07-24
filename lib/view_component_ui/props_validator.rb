module ViewComponentUI
  class PropsValidator
    extend Dry::Initializer

    option :schema_type, default: -> { PropsType }

    def call(props)
      schema_type[props.to_h]
    end
  end
end
