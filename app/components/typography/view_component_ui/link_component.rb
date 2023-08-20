module ViewComponentUI
  class LinkComponent < BoxComponent
    defaults as: :a, display: :inline_block, cursor: :pointer, color: 'blue-600', _hover: { color: 'blue-900' }
  end
end
