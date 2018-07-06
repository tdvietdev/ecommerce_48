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
    resources :orders, except: [:new, :create, :destroy]
    resources :users
    resources :suggestions
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
  resources :products
  resources :rates
  resources :carts do
    collection do
      post :update_item
      post :add_product
      delete :delete_item
    end
  end
  resources :orders
end
