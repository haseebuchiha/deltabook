Rails.application.routes.draw do
  root 'pages#home'
  resources :games, only: [:show]
  resources :users, only: [:show]
  resources :users, except: [:show]

  get 'chatapp', to: 'pages#index'
  get 'towerofhonoi', to: 'games#towerofhonoi'
  get 'tictactoe', to: 'games#tictactoe'
  get 'rockpaperscissor', to: 'games#rockpaper'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'  

  namespace :api do
    resources :messages, only: %i[index create show]
    get 'msg', to: 'messages#hello'
  end
  mount ActionCable.server => '/cable'
end
