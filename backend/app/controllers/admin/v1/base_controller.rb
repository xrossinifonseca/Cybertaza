class Admin::V1::BaseController < ApplicationController

  include ActionController::Cookies
  include JwtManager
  include AccessValidator

  before_action :authenticate_admin


  protected

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
    begin
   if decoded = validate_admin_session(cookies)
    @current_user = User.find(decoded["user_id"])
    end
    rescue
      cookies.delete(:check_token)
      cookies.delete(:auth_token)
      render_forbidden("forbidden")
    end
  end



end
