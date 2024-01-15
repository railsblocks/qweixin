Qweixin::Engine.routes.draw do
  resource :user

  get "app_login", to: "sessions#code2session"
  get "app_checksession", to: "sessions#checksession"
end
