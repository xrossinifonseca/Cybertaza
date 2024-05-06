
module JwtManager
  def generate_token(payload)
    JWT.encode(payload, ENV["JWT_KEY"], 'HS256')
  end

  def decode_token(token)
    JWT.decode(token, ENV["JWT_KEY"], true, algorithm: 'HS256')[0]
  rescue JWT::DecodeError
    nil
  end
end
