Qweixin::Engine.routes.draw do
  resources :users

  get "app_login", to: "sessions#code2session"
end
