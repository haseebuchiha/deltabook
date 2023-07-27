Rails.application.routes.draw do

  get 'friends/new'
  post 'friends/create'
  get 'friends/show'
  root 'pages#home'
  resources :games, only: [:show]
  resources :users, only: [:show]
  resources :users, except: [:show]

  namespace :api do
    namespace :v1 do
      resources :feeds
    end
  end

  get 'feeds', to: 'pages#feeds'
  
  get 'towerofhonoi', to: 'games#towerofhonoi'
  get 'tictactoe', to: 'games#tictactoe'
  get 'rockpaperscissor', to: 'games#rockpaper'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'  

  
  resources :messages
  mount ActionCable.server, at: '/cable'
  match "*path" => "pages#feeds", via: [:get, :post]
end
