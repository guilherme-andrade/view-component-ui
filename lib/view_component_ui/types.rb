require 'dry-types'

module ViewComponentUI
  module Types
    include Dry.Types()

    HTML_TAGS = %i[
      a abbr address area article aside audio b base bdi bdo blockquote body br
      button canvas caption cite code col colgroup data datalist dd del details
      dfn dialog div dl dt em embed fieldset figcaption figure footer form h1 h2
      h3 h4 h5 h6 head header hr html i iframe img input ins kbd label legend li
      link main map mark meta meter nav noframes noscript object ol optgroup option
      output p param picture pre progress q rp rt ruby s samp script section select
      small source span strong style sub summary sup svg table tbody td template
      textarea tfoot th thead time title tr track u ul var video wbr
    ].freeze

    StringOrNil = Coercible::String.optional
    IntOrNil = Coercible::Integer.optional
    BoolOrNil = Strict::Bool.optional
    HashOrNil = Strict::Hash.optional

    Tag = Coercible::Symbol.default(:div).enum(*HTML_TAGS)

    Component = Instance(ViewComponent::Base)

    PropValue = Types::Interface(:call) | Types::Any
    PropValue = PropValue.dup

    module OneOf
      def one_of(values, meta: {})
        constructor do |value|
          next value if value.nil? || value.respond_to?(:call) || values.any? { _1.to_s.dasherize == value.to_s.dasherize }

          if meta&.dig(:message).respond_to?(:call)
            raise ArgumentError, meta[:message].call(value, values)
          else
            raise ArgumentError, "#{value.inspect} must be one of #{values.join(', ')}"
          end
        rescue ArgumentError => e
          backtrace = e.backtrace
          filter_index = backtrace.index { !(_1.include?("lib") || _1.include?("concerns") || _1.include?("gems") || _1.include?("eval")) }
        
          if filter_index
            filtered_backtrace = backtrace[filter_index..-1]
            e.set_backtrace(filtered_backtrace)
          end
        
          raise e                  
        end  
      end
    end

    PropValue.extend(OneOf)
    PropValue.freeze
  end
end
