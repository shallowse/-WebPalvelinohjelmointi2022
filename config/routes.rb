Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'breweries#index'

  resources :beers
  resources :breweries
  resources :users
  resources :ratings, only: [:index, :new, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]

  # get "kaikki_bisset", to: "beers#index"

  get 'signup', to: 'users#new'

  get 'signin', to: 'sessions#new'

  delete 'signout', to: 'sessions#destroy'

end
