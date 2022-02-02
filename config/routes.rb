Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'
  get '/register', to: 'landing#register'
  get '/users/:user_id/discover', to: 'movies#discover'

  resources :users, only: [:new, :create, :show] do

  end
end
