Rails.application.routes.draw do

  # You can have the root of your site routed with "root"
  root "static_pages#home"
  get    "help"    =>  "static_pages#help"
  get    "about"   =>  "static_pages#about"
  get    "contact" =>  "static_pages#contact"
  get    "signup"  =>  "users#new"
  get    "login"   =>  "sessions#new"
  post   "login"   =>  "sessions#create"
  delete "logout"  =>  "sessions#destroy"
  get "password_resets/new"
  get "password_resets/edit"
  resources :users
  resources :products
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :line_items,          only: [:create, :update, :destroy]
  resource  :cart,                only: [:show, :destroy]
  resources :orders
end
