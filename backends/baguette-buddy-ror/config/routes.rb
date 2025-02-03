Rails.application.routes.draw do
  root 'home#welcome'

  scope constraints: {format: :html} do
    get 'sign_up', to: 'users#new', as: :sign_up
    post 'sign_up', to: 'users#create'
  
    get "login", to: "sessions#new", as: :login
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy", as: :logout
    resources :receipes
  end


  namespace :api, constraints: {format: :json} do
    resources :receipes
    resources :ingredients
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
