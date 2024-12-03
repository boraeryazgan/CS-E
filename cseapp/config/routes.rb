Rails.application.routes.draw do
  root "users#new" # Kayıt sayfasını ana sayfa yap
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "users#login_form"
  post "login", to: "users#login"
  delete "logout", to: "users#logout"

  get "settings", to: "u_settings#index"
patch "settings/update_password", to: "u_settings#update_password"
post "settings/deactivate", to: "u_settings#deactivate_account"
resource :profile, only: [:show, :edit, :update], path: 'profile'
  resources :friendships, only: [:create, :update, :destroy]
  resources :blocks, only: [:create, :destroy]
end