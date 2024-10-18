Rails.application.routes.draw do
  get 'order_history/index'
  get 'carts/show'
  get 'carts/add_item'
  get 'carts/remove_item'
  get 'carts/checkout'
  get 'store/index'
  get 'menu/index'
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
  resources :products do
    # search functionality
    collection do
      get 'search'
    end
  end
  
  get '/menu', to: 'menu#index'
  get '/store', to: 'store#index'

  # cart management routes
  resource :cart, only: [:show] do
    post 'add_item/:product_id', to: 'carts#add_item', as: 'add_item'
    delete 'remove_item/:id', to: 'carts#remove_item', as: 'remove_item'
    post 'checkout', to: 'carts#checkout', as: 'checkout'
  end

  get 'order_history', to: 'order_history#index'
  delete 'order_history/:id', to: 'order_history#destroy'
end
