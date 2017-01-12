Rails.application.routes.draw do
  get '/read' => 'home#index', as: :home
  get '/read/:id' => 'home#show', as: :read
  get '/last' => 'home#last', as: :last
  patch '/update/:id' => 'home#update', as: :update
  post '/create' => 'home#create', as: :create
  delete '/destroy/:id' => 'home#destroy', as: :destroy
  patch '/publish/:id' => 'home#publish', as: :publish

  resources :posts

  devise_for :users, only: :sessions

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
