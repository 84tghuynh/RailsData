Rails.application.routes.draw do
  get 'books/index'
  get 'books/show'
  # get "authors/index"
  # get "authors/show"
  get "authors",     to: "authors#index", as: "authors" # products_path
  get "authors/:id", to: "authors#show",  as: "author"
  # resources :authors, only: %i[index show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "home/about_data"
  root to: "home#index"
end
