Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
    put '/users/:user_id/trips/check_overdue', to: 'trips#check_overdue'
    put '/users/:user_id/trips/:id/update_status', to: 'trips#update_status'

    resources :sessions, only: [:show, :create, :destroy]
    resources :users, only: [:index] do
      resources :trips
    end
end
