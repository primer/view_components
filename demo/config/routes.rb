# frozen_string_literal: true

# :nocov:
Rails.application.routes.draw do
  if Rails.env.production?
    get "/view-components", to: redirect("/view-components/lookbook/")
    get "/", to: redirect("/view-components/lookbook/")
  else
    get "/", to: redirect("/lookbook/")
  end

  scope path: Rails.env.production? ? "/view-components" : "/" do
    get "/auto_complete", to: "auto_complete_test#index"
    resources :toggle_switch, only: [:create]
    resources :nav_list_items, only: [:index]
    post "/example_check/ok", to: "auto_check#ok"
    post "/example_check/error", to: "auto_check#error"
    post "/example_check/random", to: "auto_check#random"

    mount Lookbook::Engine, at: "/lookbook" if defined?(Lookbook)
  end
end
