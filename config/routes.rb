Rails.application.routes.draw do
  root to: "cats#index"
  resources :cats
  resources :cats do
    resources :cat_rental_requests, only: [:show]
  end
  resources :cat_rental_requests, except: [:show]

  resources :users
  resource :session
end
