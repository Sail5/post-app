Rails.application.routes.draw do
  get 'sessions/new'

  root 'homes#top'
  resource :user, only: [:new, :create, :show]
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"  
  get 'logout', to: "sessions#destroy"
  resources :posts, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :posts do
    member do
      get 'image'
    end
  end
end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  #get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  #localhost:3000/posts