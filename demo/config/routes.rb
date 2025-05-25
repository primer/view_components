# frozen_string_literal: true

# :nocov:
Rails.application.routes.draw do
  if Rails.env.production?
    get "/view-components", to: redirect("/view-components/lookbook/")
    get "/", to: redirect("/view-components/lookbook/")
  else
    get "/", to: redirect("/lookbook/")
  end

  scope path: Rails.env.production? ? "/view-components/rails-app/" : "/" do
    # Lookbook requires that a root route be defined for the host app, so we define
    # one here and point it at a dummy controller. Please don't remove this, it will
    # break production.
    root "home#index"

    get "/healthz", to: "health#index"

    mount Primer::ViewComponents::Engine, at: "/"
  end

  scope path: Rails.env.production? ? "/view-components/lookbook/" : "/lookbook" do
    mount Lookbook::Engine, at: "/" if defined?(Lookbook)
  end
end
