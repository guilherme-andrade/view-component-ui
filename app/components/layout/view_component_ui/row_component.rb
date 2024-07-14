module ViewComponentUI
  class RowComponent < BoxComponent
    defaults grid_gap: 3, as: :div

    renders_many :cols, ViewComponentUI::ColComponent
  end
end
