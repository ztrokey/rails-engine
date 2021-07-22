Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :find, controller: :search, only: :index
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
        resources :merchants, only: :show
      end
    end
  end
end
