Rails.application.routes.draw do

  get 'show_users', to: 'admin#show_users'
  get 'show_orders', to: 'admin#show_orders'
  post 'admin/destroy'
  post 'admin/update_order'

  get 'search', to: 'pages#search'

  get 'orders', to: 'orders#show'
  post 'orders/add'

  get 'checkout', to: 'checkout#show'

  get 'cart', to: 'cart#show'
  post 'cart/add'
  post 'cart/remove'

  root 'pages#home'
  resources :products
  devise_for :users

end
