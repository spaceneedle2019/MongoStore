Rails.application.routes.draw do

  resources :customers do
    resources :addresses
    resource :payment, :only => [:edit, :update, :destroy]
  end

  resources :products

  # You can have the root of your site routed with "root"
  root 'customers#index'

end
