Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  resources :activities

  unauthenticated do
    root "static_pages#home"
  end

  authenticated :user do
    root "activities#index", as: :authenticated_root
  end
end
