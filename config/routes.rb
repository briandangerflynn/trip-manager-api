Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

    resources :sessions, only: [:show, :create, :destroy]
    resources :users, only: [:index] do
      resources :trips
    end
end