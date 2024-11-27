Rails.application.routes.draw do
  root "users#new" # Kayıt sayfasını ana sayfa yap
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "users#login_form"
  post "login", to: "users#login"
  delete "logout", to: "users#logout"

  resource :profile, only: [:show, :edit, :update]
end