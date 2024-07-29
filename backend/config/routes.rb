Rails.application.routes.draw do


  namespace :api do
    namespace :v1 do

      defaults format: :json do

        resources :colors
        resources :products
        resources :customers, only: [:index, :show, :create, :update, :destroy]
        resources :cart_items


        # search produict
        get '/search_product', to: 'products#search'



        get '/cart', to: 'carts#show'
        delete '/cart_items', to: 'cart_items#destroy'


        # customers
        post '/session/login', to: 'session_customer#login'
        post '/session/logout', to: 'session_customer#logout'
        get '/profile', to: 'customers#profile'



      end
    end
  end


  namespace :admin do
    namespace :v1 do
      defaults format: :json do

      resources :products
      resources :colors
      resources :movements, only: [:index, :create]
      resources :stock

      # admin
      post '/login', to: 'session_admin#login'
      post "/logout", to: 'session_admin#logout'
      get "/profile", to: 'users#current_user_information'


      # search product
      get '/search_product', to: 'products#search'


      # patch product
      patch '/products', to: 'products#update'

    end
  end
  end



  # match '*unmatched_route', to: 'error#not_found', via: :all

end
