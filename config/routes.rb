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

  get 'towerofhonoi', to: 'games#towerofhonoi'
  get 'tictactoe', to: 'games#tictactoe'
  get 'rockpaperscissor', to: 'games#rockpaper'
  
  resources :messages
  mount ActionCable.server, at: '/cable'
end
