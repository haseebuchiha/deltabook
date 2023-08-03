Rails.application.routes.draw do
  devise_for :users, 
              controllers: { 
                registrations: 'users/registrations' }
  root to: 'pages#home'
  resources :games, only: [:show]

  get 'friends/new'
  post 'friends/create'
  get 'friends/show'
  resources :users, only: [:show]

  resources :feeds

  namespace :api do
    namespace :v1 do
      resources :feeds
    end
  end
  
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
end
