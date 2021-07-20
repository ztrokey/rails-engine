Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
      end
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        get '/merchant', to: 'items#show'
      end
    end
  end
  # resources :transactions
  # resources :invoices
  # resources :customers
  # resources :invoice_items
end
