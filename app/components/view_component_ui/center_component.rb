module ViewComponentUI
  class CenterComponent < FlexComponent
    option :tag, default: proc { :div }
    option :align_items, default: proc { :center }
    option :justify_content, default: proc { :center }
  end
end
