# frozen_string_literal: true

Rails.application.routes.draw do
  if Rails.env.production?
    get '/view-components', to: redirect('/view-components/stories/')
    get '/', to: redirect('/view-components/stories/')
  else
    get '/', to: redirect('/lookbook/')
  end

  scope path: Rails.env.production? ? "/view-components" : "/" do
    get '/auto_complete', to: 'auto_complete_test#index'
    resources :toggle_switch, only: [:create]

    unless Rails.version.to_i >= 7
      mount Lookbook::Engine, at: "/lookbook"
    end
  end
end
