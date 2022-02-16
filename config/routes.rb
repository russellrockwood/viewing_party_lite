Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'
  get '/register', to: 'landing#register'
  get '/users/:user_id/discover', to: 'movies#discover'
  get '/users/:user_id/results', to: 'movies#results'

  resources :users, only: %i[new create show] do
    resources :movies, only: [:show] do
      resources :parties, only: %i[new create]
    end
  end
end
