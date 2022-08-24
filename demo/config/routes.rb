# frozen_string_literal: true

Rails.application.routes.draw do
  get '/view-components', to: redirect('/view-components/stories/')
  get '/', to: redirect('/view-components/stories/')

  get '/auto_complete', to: 'auto_complete_test#index'
  resources :toggle_switch, only: [:create]
end
