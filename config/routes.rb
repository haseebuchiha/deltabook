Rails.application.routes.draw do
  root 'pages#home'
  resources :games, only: [:show]
  resources :users, only: [:show]
  resources :users, except: [:show]

  namespace :api do
    namespace :v1 do
      resources :feeds
    end
  end
  
  resources :feeds

  get 'towerofhonoi', to: 'games#towerofhonoi'
  get 'tictactoe', to: 'games#tictactoe'
  get 'rockpaperscissor', to: 'games#rockpaper'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'  

  # match "*path" => "pages#feeds", via: [:get, :post] // Wont show media files if this is uncommented
end
