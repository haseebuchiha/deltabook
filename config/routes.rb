Rails.application.routes.draw do
  
  devise_for :users, 
              controllers: { 
                registrations: 'users/registrations' }
  root to: 'pages#home'
  resources :games, only: [:show]

  resources :projects do
    get 'iframe', on: :member
  end
  get 'friends/new'
  post 'friends/create'
  get 'friends/show'
  resources :users, only: [:show]

  resources :feeds

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :feeds
      delete 'feed_media/:id/purge_later', to: 'feeds#media_purge_later'
      devise_scope :user do
        post '/auth', to: 'users/registrations#create'
        post 'auth/sign_in', to: 'users/sessions#create'
        delete 'auth/sign_out', to: 'users/sessions#destroy'
      end
    end
  end
  
  resources :feeds

  delete 'feed_media/:id/purge_later', to: 'feeds#media_purge_later', as: 'feedmedia_purgelater'

  get 'towerofhonoi', to: 'games#towerofhonoi'
  get 'tictactoe', to: 'games#tictactoe'
  get 'rockpaperscissor', to: 'games#rockpaper'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'signup', to: 'users#new'
  post 'users', to: 'users#create'  

  # get '*all', to: 'application#index', constraints: lambda { |req|
  #   req.path.exclude? 'rails/active_storage'
  # }

  
  # match "*path" => "pages#feeds", via: [:get, :post] // Wont show media files if this is uncommented
  
  resources :messages
  mount ActionCable.server, at: '/cable'
end
