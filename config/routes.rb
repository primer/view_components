# frozen_string_literal: true

Primer::ViewComponents::Engine.routes.draw do
  get "/auto_complete", to: "auto_complete_test#index", as: :autocomplete_index
  get "/auto_complete_no_results", to: "auto_complete_test#no_results", as: :autocomplete_no_results

  resources :toggle_switch, only: [:create]
  resources :nav_list_items, only: [:index]
  resources :multi, only: [:create]
  resources :select_panel_items, only: [:index]

  resources :tree_view_items, only: [:index]
  get "/tree_view_items/async_alpha", to: "tree_view_items#async_alpha", as: :tree_view_items_async_alpha

  # generic form submission path
  post "/form_handler", to: "form_handler#form_action", as: :generic_form_submission

  post "/example_check/accepted", to: "auto_check#accepted", as: :example_check_accepted
  post "/example_check/ok", to: "auto_check#ok", as: :example_check_ok
  post "/example_check/error", to: "auto_check#error", as: :example_check_error
  post "/example_check/random", to: "auto_check#random", as: :example_check_random

  get "/action_menu/landing_page", to: "action_menu#landing", as: :action_menu_landing
  post "/action_menu/form_action", to: "action_menu#form_action", as: :action_menu_form_action
  get "/action_menu/deferred", to: "action_menu#deferred", as: :action_menu_deferred
  get "/action_menu/deferred_preload", to: "action_menu#deferred_preload", as: :action_menu_deferred_preload

  get "/include_fragment/deferred", to: "include_fragment#deferred", as: :include_fragment_deferred
end
