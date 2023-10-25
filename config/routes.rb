Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'sign_up', to: 'users#sign_up'
  post 'login', to: 'users#login'
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [] do
        resources :reservations
      end
      resources :doctors
    end
  end
end
