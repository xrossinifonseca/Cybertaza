

  module AccessValidator

    def validate_token(cookies)
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


    def validate_admin_session(cookies)
     decoded = validate_token(cookies)

     if decoded && decoded["role"] != "admin"
      render_forbidden("Acesso não autorizado.")
      return nil
     end

     decoded
    end

    def validate_customer_session(cookies)
      decoded = validate_token(cookies)

      if decoded.nil?
       render_forbidden("Acesso não autorizado.")
       return nil
      end

      decoded
     end


    private
    def render_unauthorized(message)
      render json: { error: message }, status: :unauthorized
    end

    def render_forbidden(message)
      render json: { error: message }, status: :forbidden
    end

  end
