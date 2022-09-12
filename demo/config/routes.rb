# frozen_string_literal: true

Rails.application.routes.draw do
  resources :toggle_switch, only: [:create]
  if Rails.env.production?
    mount Lookbook::Engine, at: "/view-components/lookbook"
    get '/view-components', to: redirect('/view-components/lookbook/')
    get '/', to: redirect('/view-components/lookbook/')

    get '/view-components/auto_complete', to: 'auto_complete_test#index'
  else
    mount Lookbook::Engine, at: "/"

    get '/auto_complete', to: 'auto_complete_test#index'
  end
end
