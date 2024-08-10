class Api::V1::SessionCustomerController < Api::V1::BaseController

  skip_before_action :authenticate_customer, only: [:login]


    def login
      customer =Customer.find_by(email:session_params[:email])

      if customer && customer.authenticate(session_params[:password])

        create_customer_token(customer.id)

        return render json: { message: "Login successful", customer: CustomerSerialize.new(customer)}, status: :ok
      end

      render json: { error: "invalid credentials" }, status: :unauthorized
    end



    def logout
      cookies.delete(:check_token)
      cookies.delete(:auth_token)
      render json: { message: "Logout successful" }, status: :ok
    end


    private
    def session_params
      params.require(:session_customer).permit(:email, :password)
    end


end
