module ViewComponentUI
  class Base < ViewComponent::Base
    extend Dry::Initializer
    include HTMLTag

    class << self
      def option(name, *args)
        options = args.extract_options!
        alias_name = options.delete(:alias)

        if alias_name
          super name, *args, **{ default: proc { send(alias_name) } }.merge(options)
          super alias_name, *args, **{ default: proc { send(name) } }.merge(options)
        else
          super
        end
      end
    end
  end
end
