Rails.application.routes.draw do
  mount Lookbook::Engine, at: "/lookbook"
  # mount ActionCable.server => "/"

  get "/auto_complete", to: "auto_complete_test#index"
end
