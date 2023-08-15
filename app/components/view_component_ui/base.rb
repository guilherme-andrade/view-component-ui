module ViewComponentUI
  class Base < ViewComponent::Base
    extend Dry::Initializer
    include HTMLTag

    class << self
      def option(name, *args)
        options = args.extract_options!
        alias_name = options.delete(:alias)

        if alias_name
          default_proc = proc { |default_method| proc { send(default_method) } }
          base_options = { default: default_proc.call(alias_name) }
          super(name, *args, **base_options.merge(options))
          super(alias_name, *args, **base_options.merge(options))
        else
          super(name, *args, **options)
        end
      end
    end
  end
end
