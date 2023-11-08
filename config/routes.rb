Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Routes for user sign up and login
  post 'sign_up', to: 'api/v1/users#sign_up'
  post 'login', to: 'api/v1/users#login'

  namespace :api do
    namespace :v1 do
      resources :users do
        resources :reservations
      end
      resources :doctors
      
    end
  end
end
