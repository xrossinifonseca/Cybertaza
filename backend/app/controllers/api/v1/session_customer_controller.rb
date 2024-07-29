class Api::V1::SessionController < Api::V1::BaseController

    def login
      customer =Customer.find_by(email:session_params[:email])

      if customer && customer.authenticate(session_params[:password])

        create_customer_token(customer.id)

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
      params.require(:session_customer).permit(:email, :password)
    end


end
