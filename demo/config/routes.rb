# frozen_string_literal: true

Rails.application.routes.draw do
  mount Lookbook::Engine, at: "/lookbook"
  get "/", to: redirect("/lookbook")
  get "/auto_complete", to: "auto_complete_test#index"
  resources :toggle_switch, only: [:create]
end
