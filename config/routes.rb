Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  resources :posts
  root 'posts#home'
  get '/index', to: 'posts#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :index]
  resources :comments
  resources :likes
  resources :friendships
  delete '/delete', to: 'friendships#destroy' 
  post '/invite',  to: 'friendships#create'
  put '/accept',  to: 'friendships#update'
  post '/confirm',  to: 'friendships#confirm'
  get 'politics', to: 'services#politics'
  get '/conditions', to: 'services#conditions'
end