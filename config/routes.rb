Rails.application.routes.draw do
  get 'users/show'
  get 'users/index'
  resources :posts
  root 'posts#home'
  get '/index', to: 'posts#index'  
  resources :users, only: [:show, :index]
  resources :comments
  resources :likes
  resources :friendships
  delete '/delete', to: 'friendships#destroy' 
  post '/invite',  to: 'friendships#create'
  put '/accept',  to: 'friendships#update'
  post '/confirm',  to: 'friendships#confirm'
  devise_for :users,  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
