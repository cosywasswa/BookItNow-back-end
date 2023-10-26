Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Define custom routes for user authentication
  post 'sign_up', to: 'api/v1/users#sign_up'
  post 'login', to: 'api/v1/users#login'

  namespace :api do
    namespace :v1 do
      # Nested resources for users and their reservations
      resources :users, only: [] do
        resources :reservations
      end
      # Additional resources, like doctors, can be added here if needed
      resources :doctors
    end
  end
end
