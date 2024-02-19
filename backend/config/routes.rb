Rails.application.routes.draw do

  scope "api/v1" do

    resources :customers, only: [:index, :show, :create, :update, :destroy]

    post '/session/login', to: 'sessions#login'
    post '/session/logout', to: 'sessions#logout'
  end

  match '*unmatched_route', to: 'error#not_found', via: :all

end
