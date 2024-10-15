Rails.application.routes.draw do
  get 'profiles/show'
  get 'profiles/edit'
  get 'profiles/update'
  get 'users/show'
  get 'order_items/create'
  get 'food_items/index'
  get 'food_items/show'
  get 'food_items/new'
  get 'food_items/create'
  get 'food_items/edit'
  get 'food_items/update'
  get 'food_items/destroy'
  get 'orders/index'
  get 'orders/show'
  get 'orders/new'
  get 'orders/create'
  get 'orders/edit'
  get 'orders/update'
  get 'orders/destroy'
  get 'products/index'
  get 'products/show'
  get 'products/new'
  get 'products/create'
  get 'products/edit'
  get 'products/update'
  get 'products/destroy'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'welcome/index'
  # Root route
  root 'welcome#index'
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # profile management, allow to edit user details
  resource :profile, only: [:show, :edit, :update]
  resources :addresses
  resources :orders, only: [:index, :show]

  # user product browsing
  resources :products
  get 'menu', to: 'products#menu'
  get 'store', to: 'products#store'
end
