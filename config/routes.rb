Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  resources :posts
  root 'posts#index'
  devise_for :users
  resources :comments
  resources :likes
  resources :friendships#, only: %i[index edit update create destroy] 
  post '/invite',  to: 'friendships#create'
  put '/accept',  to: 'friendships#update'
end
