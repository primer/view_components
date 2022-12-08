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
    get "/auto_complete", to: "auto_complete_test#index", as: :autocomplete_index
    resources :toggle_switch, only: [:create]
    resources :nav_list_items, only: [:index]

    mount Lookbook::Engine, at: "/lookbook" if defined?(Lookbook)
  end
end
