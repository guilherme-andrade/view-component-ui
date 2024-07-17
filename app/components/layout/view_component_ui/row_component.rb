module ViewComponentUI
  class RowComponent < BoxComponent
    default_props gap: 3, as: :div

    renders_many :cols, ViewComponentUI::ColComponent
  end
end
