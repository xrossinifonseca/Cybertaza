Rails.application.routes.draw do

  scope "api/v1" do

    resources :colors
    resources :products
    resources :customers, only: [:index, :show, :create, :update, :destroy]

    # product
    patch '/products', to: 'products#update'


    # customers
    post '/session/login', to: 'sessions#login'
    post '/session/logout', to: 'sessions#logout'
    get '/profile', to: 'customers#profile'


    # admin
    scope "/admin" do
      get "/user", to: 'admin#user_info'
      post "/login", to: 'admin#login'
      post "/logout", to: 'admin#logout'
    end

  end





  # match '*unmatched_route', to: 'error#not_found', via: :all

end
