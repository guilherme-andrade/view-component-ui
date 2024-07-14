module ViewComponentUI
  class GridComponent < BoxComponent
    defaults tag: :div, display: :grid

    renders_many :cols, ViewComponentUI::ColComponent

    def call
      as_tag do
        cols
      end
    end
  end
end
