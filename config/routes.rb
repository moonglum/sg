Rails.application.routes.draw do
  resources :demo

  get "/aiur/*component", to: "aiur#show"
end
