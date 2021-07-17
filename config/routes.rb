Rails.application.routes.draw do
  resources :transactions
  resources :invoices
  resources :customers
  resources :invoice_items
  resources :items
  resources :merchants
end
