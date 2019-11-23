Rails.application.routes.draw do
  resources :posts
  get 'homes/index'
  root to: "homes#index"
  devise_for :users
end
