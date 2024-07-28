module ViewComponentUI
  module Constants
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

    JS_PROPS = %i[x_data x_init x_show x_bind x_on x_text x_html x_model x_modelable x_for x_transition
                       x_effect x_ignore x_ref x_cloak x_teleport x_if x_id on_click on_focus].freeze                       
  end
end
