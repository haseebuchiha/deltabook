Rails.application.routes.draw do
    
   # API routes
  namespace :api, defaults: { format: :json } do
    devise_scope :user do
      namespace :v1 do
        post '/auth', to: 'users/registrations#create'
        post 'auth/sign_in', to: 'users/sessions#create'
        delete 'auth/sign_out', to: 'users/sessions#destroy'
      end
    end
  end

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
