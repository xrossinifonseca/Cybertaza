class Api::V1::BaseController < ApplicationController

  include ActionController::Cookies
  include JwtManager
  include AccessValidator

  before_action :authenticate_customer
  before_action :set_cart


  protected

  def create_customer_token(id)
    payload = {customer_id:id, role:"customer"}
    token = generate_token(payload)
    set_cookie(token)
  end

  def set_cart
      @cart = Cart.find_by(id: session[:cart_id])
      if @cart.nil?
        @cart  = Cart.create!
        session[:cart_id] = @cart.id
      end

      @cart
  end



  private
  def set_cookie(token)
    cookies.signed[:auth_token] = {
        value: token,
        httponly: true,
        secure: true,
        same_site: :strict
      }

      cookies.signed[:check_token] = {
        value: "is authenticated",
        secure: true,
        same_site: :strict
      }
  end


  def authenticate_customer
    begin
   if decoded = validate_customer_session(cookies)
    @current_customer = Customer.find(decoded["customer_id"])
    end

    rescue
      cookies.delete(:check_token)
      cookies.delete(:auth_token)
    end
  end

end
