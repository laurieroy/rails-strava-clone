Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :activities
  resources :shoes, except: [:show]
  resources :totals, only: [:index]


  root "static_pages#home", to: "/home"


  authenticated :user do
    root "activities#index", as: :authenticated_root
  end
end
