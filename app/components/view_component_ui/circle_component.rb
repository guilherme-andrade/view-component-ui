module ViewComponentUI
  class CircleComponent < CenterComponent
    option :tag, default: proc { :div }
    option :border_radius, default: proc { :circle }
  end
end
