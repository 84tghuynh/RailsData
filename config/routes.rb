Rails.application.routes.draw do
  get 'authors/index'
  get 'authors/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "home/about_data"
  root to: "home#index"
end
