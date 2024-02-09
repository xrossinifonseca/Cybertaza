
class ApplicationController < ActionController::API

  private
  def generate_token(payload)
    JWT.encode(payload, ENV["JWT_KEY"], 'HS256')
  end

  private
  def decode_token(token)
    JWT.decode(token, ENV["JWT_KEY"], true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end

  protected
  def create_token(id)
    payload = {customer_id:id}
    token = generate_token(payload)
  end

end
