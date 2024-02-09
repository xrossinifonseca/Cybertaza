

  module AccessValidator

    def validate(cookies)

      token = cookies.signed[:auth_token]

    if token.blank?
      render_unauthorized("Token não encontrado")
      return nil
    end

    customer_id = decode_token(token)

    if customer_id.nil?
      render_unauthorized("Token inválido ou expirado")
      return nil
    end

    customer_id
    end


    def render_unauthorized(message)
      render json: { error: message }, status: :unauthorized
    end

  end
