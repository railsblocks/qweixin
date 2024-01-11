Rails.application.routes.draw do
  mount Qweixin::Engine => "/qweixin"
end
