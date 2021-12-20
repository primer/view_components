# frozen_string_literal: true

Rails.application.routes.draw do
  get '/view-components', to: redirect('/view-components/stories/')
  get '/', to: redirect('/view-components/stories/')

  get '/autocomplete', to: 'autocomplete_test#index'
end
