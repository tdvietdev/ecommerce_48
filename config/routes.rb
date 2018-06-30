Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  namespace :admin do
    root "static_pages#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :static_pages
    resources :categories
    resources :products do
      resources :images
      resources :promotions
      collection do
        post :import
      end
      member do
        get :list_image
      end
    end
  end

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
  resources :categories
end
