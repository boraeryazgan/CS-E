Rails.application.routes.draw do
  get 'users/show'
  resources :rooms do
    resources :messages
  end
  root 'pages#home'
  devise_for :users
  resource :profile, only: [:show, :edit, :update], controller: 'profiles'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end
  get 'user/:id', to: 'users#show', as: 'user'
  # Defines the root path route ("/")
  # root "articles#index"

  resources :friendships, only: [:create, :update, :destroy]

  # Kullanıcılarla ilgili işlemler
  resources :users, only: [:index, :show]

  # Ana sayfa
  root "users#index"
end
end
