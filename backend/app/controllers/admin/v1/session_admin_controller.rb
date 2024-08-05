class Admin::V1::SessionAdminController < Admin::V1::BaseController

  skip_before_action :authenticate_admin, only: [:login]

  def login
     user = User.find_by(email:session_params[:email])


    if user && user.authenticate(session_params[:password])

      create_admin_token(user.id)

      return  render json: { message: "Login successful", data: UserSerializer.new(user) }, status: :ok
    end

    render json: { error: "Invalid credentials" }, status: :unauthorized
  end


  def logout
    cookies.delete(:check_token)
    cookies.delete(:auth_token)
    render json: { message: "Logout bem-sucedido" }, status: :ok
  end



  private
  def session_params
    params.require(:session_admin).permit(:email, :password)
  end

end
