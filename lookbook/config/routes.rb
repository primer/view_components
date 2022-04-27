Rails.application.routes.draw do
  mount Lookbook::Engine, at: "/lookbook"
  get "/", to: redirect("/lookbook")
  get "/auto_complete", to: "auto_complete_test#index"
end
