module ViewComponentUI
  class LinkComponent < BoxComponent
    default_props as: :a, display: :inline_block, cursor: :pointer, color: 'blue-600', _hover: { color: 'blue-900' }

    prop :to, default: nil, optional: true

    def html_attributes
      super.merge(href: to)
    end
  end
end
