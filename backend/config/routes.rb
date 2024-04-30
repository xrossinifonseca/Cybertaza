Rails.application.routes.draw do

  scope "api/v1" do

    resources :colors
    resources :products
    resources :customers, only: [:index, :show, :create, :update, :destroy]

    # product
    patch '/products', to: 'products#update'


    # customers
    post '/session/login', to: 'session_customer#login'
    post '/session/logout', to: 'session_customer#logout'
    get '/profile', to: 'customers#profile'


    # admin
    scope "/admin" do
      get "/profile", to: 'users#current_user_information'
      post "/login", to: 'session_admin#login'
      post "/logout", to: 'session_admin#logout'
    end

  end





  # match '*unmatched_route', to: 'error#not_found', via: :all

end
