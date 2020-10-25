Rails.application.routes.draw do
  #get "home/index"


  root to: 'home#index'
  get "home/about_data"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
