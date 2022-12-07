Rails.application.routes.draw do
  resources :reviews, only: [:create, :destroy,:update]
  resources :profiles, only: [:create, :index]
  resources :cart
  resources :orders
  resources :products
  resources :users, only: [:index, :show, :update, :destroy]
  post "/register", to: "auth#register"
  post "/login", to: "auth#login"
  
end
