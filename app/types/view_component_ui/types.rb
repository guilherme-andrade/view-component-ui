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
  end
end
