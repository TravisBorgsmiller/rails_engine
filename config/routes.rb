Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end
      namespace :merchants do
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end
      get '/merchants/:id/items', to: 'merchant_items#index'
      get '/items/:id/merchant', to: 'item_merchant#show'
      resources :items, except: [:new, :edit]
      resources :merchants, except: [:new, :edit]
    end
  end
end
