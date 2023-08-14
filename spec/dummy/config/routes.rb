Rails.application.routes.draw do
  mount ViewComponentUI::Engine => '/'
  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
