ViewComponentUI.configure do |config|
  config.content = [
    ViewComponentUI::Engine.root.join('app/components/**/*component.rb'),
    ViewComponentUI::Engine.root.join('app/components/**/*component.html.erb')
  ]

  config.pseudo_elements = %i[before after]
  config.pseudo_classes = %i[hover focus active visited]
  config.breakpoints = %i[sm md lg xl]

  config.theme do |theme|
    theme.colors = %i[indigo purple stone blue red yellow emerald]
    config.sizes = %i[0 px 1 2 4 6 8 10 12 14 16 20 24 28 32 36 40 48 56 64 72 80 96 auto
                      1/2 1/3 2/3 1/4 2/4 3/4 1/5 2/5 3/5 4/5 1/6 2/6 3/6 4/6 5/6 full screen min max fit].freeze
    config.spacing = %i[0 px 2 4 6 8 10 12 14 16 20 24 28 32 36 40 44 48 52 56 60 64 72 80 96].freeze
  end
end
