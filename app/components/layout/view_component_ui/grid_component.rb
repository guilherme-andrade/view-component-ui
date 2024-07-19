module ViewComponentUI
  class GridComponent < BoxComponent
    default_props as: :div, display: :grid, grid_cols: 12, gap: 4

    renders_many :cols, ViewComponentUI::ColComponent
  end
end
