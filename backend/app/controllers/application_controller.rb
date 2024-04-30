
class ApplicationController < ActionController::API

  include ActionController::Cookies
  include JwtManager
  include AccessValidator

  before_action :authenticate_admin


  protected
  def create_customer_token(id)
    payload = {customer_id:id, role:"customer"}
    token = generate_token(payload)
    set_cookie(token)
  end

  def create_admin_token(id)
    payload = {user_id:id, role:"admin"}
    token = generate_token(payload)
    set_cookie(token)

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

  def authenticate_admin
   if decoded = validate_admin_session(cookies)
    @current_user = User.find(decoded["user_id"])
    else
    nil
    end
  end

end
