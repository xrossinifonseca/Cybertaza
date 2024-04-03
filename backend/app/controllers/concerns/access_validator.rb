

  module AccessValidator

    def validate(cookies)
      token = cookies.signed[:auth_token]

    if token.blank?
      render_unauthorized("Acesso inválido.")
      return nil
    end

    decoded_token = decode_token(token)

    if decoded_token.nil?
      render_unauthorized("Token inválido ou expirado")
      return nil
    end

    decoded_token
    end


    def validate_admin(cookies)
     decoded_token = validate(cookies)

     if decoded_token && decoded_token["rule"] != "admin"
      render_forbidden("Acesso não autorizado.")
      return nil
     end

     decoded_token
    end


    private
    def render_unauthorized(message)
      render json: { error: message }, status: :unauthorized
    end

    def render_forbidden(message)
      render json: { error: message }, status: :forbidden
    end

  end
