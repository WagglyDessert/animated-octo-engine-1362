Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/studios", to: "studios#index"
  #resources :studios, only: :index
  get "/movies/:id", to: "movies#show"
  #resources :movies, only: :show do
  #resources :actors, only: :create
  post "/movies/:id/actors", to: "movie_actors#create"
end
