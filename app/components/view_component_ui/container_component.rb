module ViewComponentUI
  class ContainerComponent < BoxComponent
    option :tag, default: proc { :div }
    option :max_width, default: proc { :screen_xl }
    option :width, default: proc { :full }
    option :mx, default: proc { :auto }
    option :px, default: proc { 4 }
  end
end
