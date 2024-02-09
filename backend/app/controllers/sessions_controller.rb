class SessionsController < ApplicationController


    def login
      customer =Customer.find_by(email:session_params[:email])

      if customer && customer.authenticate(session_params[:password])
        token = create_token(customer.id)
        set_cookie(token)
        return render json: { message: "Login bem-sucedido", customer: customer.as_json(except: :password_digest) }, status: :ok
      end

      render json: { error: "Credenciais inválidas" }, status: :unauthorized
    end


    def logout
      cookies.delete(:auth_token)
      render json: { message: "Logout bem-sucedido" }, status: :ok
    end

    private

    def session_params
      params.permit(:email,:password)
    end

  private
  def set_cookie(token)
    cookies.signed[:auth_token] = {
        value: token,
        httponly: true,
        secure: true,
        same_site: :strict
      }
  end
end
