Rails.application.routes.draw do

  devise_for :users

  resources :products

  resources :subscriptions

  resources :display, only:[:index]
get 'admin/index'
  

  root to: "products#index"
  match ':controller(/:action(/:id))', :via => [:get, :post]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
