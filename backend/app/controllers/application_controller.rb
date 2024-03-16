
class ApplicationController < ActionController::API

  include ActionController::Cookies


  private
  def generate_token(payload)
    JWT.encode(payload, ENV["JWT_KEY"], 'HS256')
  end

  def decode_token(token)
    JWT.decode(token, ENV["JWT_KEY"], true, algorithm: 'HS256')[0]

  rescue JWT::DecodeError
    nil
  end

  protected
  def create_customer_token(id)
    payload = {customer_id:id, rule:"cliente"}
    token = generate_token(payload)
  end

  def create_admin_token(id)
    payload = {user_id:id, rule:"admin"}
    token = generate_token(payload)
  end

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
end
