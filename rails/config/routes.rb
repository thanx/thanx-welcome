Rails.application.routes.draw do
  root 'users#index'

  resources :users do
    resources :songs, only: [:index, :create, :update, :show]
  end

  mount API => '/api'
end
