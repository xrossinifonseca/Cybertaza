Rails.application.routes.draw do


  scope "api/v1" do

    resources :customers, only: [:index, :show, :create, :update, :destroy]

  end

end
