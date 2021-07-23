# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, controller: :search, only: :index
        resources :most_items, only: :index
      end

      resources :merchants, only: %i[index show] do
        resources :items, only: :index
      end

      namespace :items do
        resources :find_all, controller: :search, only: :index
      end

      resources :items, only: %i[index show create update destroy] do
        get '/merchant', to: 'items#show'
      end

      namespace :revenue do
        resources :merchants, only: %i[index show]
        resources :unshipped, only: :index
      end
    end
  end
end
