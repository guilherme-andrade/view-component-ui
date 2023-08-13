module ViewComponentUI
  class FlexComponent < BoxComponent
    option :tag, default: proc { :div }
    option :display, default: proc { :flex }
  end
end
