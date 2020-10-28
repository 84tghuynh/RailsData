Rails.application.routes.draw do
  # get 'categories/index'
  # get 'categories/show'
  resources :categories, only: %i[index show]

  # get 'customers/index'
  # get 'customers/show'
  # resources :customers, only: %i[index show]
  # OR
  get "customers",     to: "customers#index", as: "customers" # books_path
  get "customers/:id", to: "customers#show",  as: "customer"

  # get 'books/index'
  # get 'books/show'
  # using
  resources :books, only: %i[index show] do
    collection do
      get "search"
    end
  end
  # OR
  # get "books",     to: "books#index", as: "books" # books_path
  # get "books/:id", to: "books#show",  as: "book"

  # get "authors/index"
  # get "authors/show"
  # using
  # resources :authors, only: %i[index show]
  # OR
  get "authors",     to: "authors#index", as: "authors" # authors_path
  get "authors/:id", to: "authors#show",  as: "author"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "home/about_data"
  root to: "home#index"
end
