Rails.application.routes.draw do
  resources :posts
  root 'posts#index'
  devise_for :users
  resources :comments
  resources :likes
  resources :friendship 
end
