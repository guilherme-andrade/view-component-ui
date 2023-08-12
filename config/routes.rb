# frozen_string_literal: true

ViewComponentUI::Engine.routes.draw do
  mount Lookbook::Engine, at: '/lookbook' if Rails.env.development?
end
