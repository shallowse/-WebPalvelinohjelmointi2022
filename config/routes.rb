Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root 'breweries#index'

  resources :beers

  resources :breweries do
    post "toggle_activity", on: :member
  end

  resources :users do
    post "toggle_status", on: :member
  end

  resources :ratings, only: [:index, :new, :create, :destroy]

  resource :session, only: [:new, :create, :destroy]

  resources :beer_clubs, path: :beerclubs

  get 'joinclub', to: 'joinclubs#new'
  post 'joinclub', to: 'joinclubs#create'
  delete 'leaveclub', to: 'joinclubs#leave'

  get 'signup', to: 'users#new'

  get 'signin', to: 'sessions#new'

  delete 'signout', to: 'sessions#destroy'

  # get "kaikki_bisset", to: "beers#index"

  resources :places, only: %i[index show]
  post 'places', to: 'places#search'

  resources :styles

  get 'beerlist', to: 'beers#list'

  get 'brewerylist', to: 'breweries#list'
end
