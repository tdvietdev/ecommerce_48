Rails.application.routes.draw do
  root "static_pages#home"
  get "static_pages/home"
  get "static_pages/help"
  namespace :admin do
    resources :static_pages
  end
end
