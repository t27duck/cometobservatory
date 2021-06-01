Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/what", to: "pages#what", as: :what
  get "/privacy-policy", to: "pages#privacy", as: :privacy_policy

  resources :posts, only: [:index, :create]
  root "posts#index"
end
