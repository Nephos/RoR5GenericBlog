Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index'
  get '/read/:id' => 'home#show'

  resources :posts

  #devise_for :users
  devise_for :users, only: :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
