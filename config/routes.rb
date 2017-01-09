Rails.application.routes.draw do
  root to: 'home#index'
  get 'home/index', as: :home
  get '/read/:id' => 'home#show', as: :read

  resources :posts

  #devise_for :users
  devise_for :users, only: :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
