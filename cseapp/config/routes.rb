Rails.application.routes.draw do
  resources :rooms do
    resources :messages
  end

  root 'pages#home'

  devise_for :users
  resource :profile, only: [:show, :edit, :update], controller: 'profiles'

  devise_scope :user do
    get 'users', to: 'devise/sessions#new'
  end

  get 'user/:id', to: 'users#show', as: 'user'

  # Users routes
  resources :users do
    member do
      get :add_friend  # `GET` isteğiyle `add_friend` action'ını tetiklemek için
    end
  end
end