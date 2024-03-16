Rails.application.routes.draw do

  scope "api/v1" do

    # resources :users
    resources :products
    resources :customers, only: [:index, :show, :create, :update, :destroy]

    get '/profile', to: 'customers#profile'

    post '/session/login', to: 'sessions#login'
    post '/session/logout', to: 'sessions#logout'

    scope "/admin" do
      post "/login", to: 'admin#login'
      post "/logout", to: 'admin#logout'
    end

  end





  # match '*unmatched_route', to: 'error#not_found', via: :all

end
